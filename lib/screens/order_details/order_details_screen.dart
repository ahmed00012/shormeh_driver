import 'package:dilivery_app/models/new_order_model.dart';
import 'package:dilivery_app/provider/order_details_provider.dart';
import 'package:dilivery_app/screens/help/constants.dart';
import 'package:dilivery_app/translations/locale_keys.g.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({Key? key, required this.order}) : super(key: key);
  final NewOrder order;

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool? pointDiscount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            LocaleKeys.order_details_translate.tr(),
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ChangeNotifierProvider<OrderDetailsProvider>(
            create: (context) => OrderDetailsProvider(widget.order),
            child: Consumer<OrderDetailsProvider>(
                builder: (buildContext, detailsProvider, _) {
              return (detailsProvider.order.orders != null)
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                Text(
                                LocaleKeys.order_no_translate.tr(),
                                textAlign: TextAlign.center,
                                 style: TextStyle(color: Colors.black,fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                                SizedBox(width: 10,),
                                Text(
                                  detailsProvider.order.orders!.id.toString(),
                                  style: TextStyle(
                                      color: kColorPrimary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              width: double.infinity,
                              padding: EdgeInsets.only(
                                left: 20,right: 20,bottom: 15
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    LocaleKeys.branch_name.tr(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                    detailsProvider
                                        .order.orders!.cart!.vendor!.name
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: kColorPrimary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                          for (int i = 0;
                              i <
                                  detailsProvider
                                      .order.orders!.cart!.items!.length;
                              i++)
                            Container(
                              margin: EdgeInsets.only(bottom: 8),
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color(0xffF2F2F2),
                              ),
                              child: ExpandablePanel(
                                theme: const ExpandableThemeData(
                                  headerAlignment:
                                      ExpandablePanelHeaderAlignment.center,

                                  tapBodyToCollapse: true,
                                ),
                                header: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          detailsProvider.order.orders!.cart!
                                              .items![i].count
                                              .toString(),
                                          //  textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: kColorPrimary,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 5,),
                                        FittedBox(
                                          fit: BoxFit.fitHeight,
                                          child: Text(
                                            detailsProvider.order.orders!.cart!
                                                .items![i].productName
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "R.S ${detailsProvider.order.orders!.cart!.items![i].total.toString()}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: kColorPrimary,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                collapsed: Container(
                             height: 0,
                                ),
                                expanded:  Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                        detailsProvider.order.orders?.cart!
                      .items![i].cartitemoption != null ?
                                          Container(
                                            //  height: 100,
                                              padding:
                                                  EdgeInsets.only(bottom: 10),
                                              child: Column(
                                                children: [
                                                  for (int j = 0;
                                                      j <
                                                          detailsProvider
                                                              .order
                                                              .orders!
                                                              .cart!
                                                              .items![i]
                                                              .cartitemoption!
                                                              .length;
                                                      j++)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(
                                                            LocaleKeys.options_translate.tr(),
                                                            softWrap: true,
                                                            overflow:
                                                            TextOverflow
                                                                .fade,
                                                          ),
                                                          Text(
                                                              context.locale.toString() == 'ar'?
                                                              detailsProvider
                                                                  .order
                                                                  .orders!
                                                                  .cart!
                                                                  .items![i]
                                                                  .cartitemoption![j]
                                                                  .optionvalue!.nameAr.toString():
                                                            detailsProvider
                                                                .order
                                                                .orders!
                                                                .cart!
                                                                .items![i]
                                                                .cartitemoption![
                                                                    j]
                                                                .optionvalue!.nameEn.toString(),
                                                            softWrap: true,
                                                            overflow:
                                                                TextOverflow
                                                                    .fade,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                ],
                                              ))
                                        : Container(),
                                          detailsProvider.order.orders?.cart!
                                              .items![i].cartitemaddon != null ?
                                          Container(
                                          //    height: 100,
                                              padding:
                                              EdgeInsets.only(bottom: 10),
                                              child: Column(
                                                children: [
                                                  for (int j = 0;
                                                  j <
                                                      detailsProvider
                                                          .order
                                                          .orders!
                                                          .cart!
                                                          .items![i]
                                                          .cartitemaddon!
                                                          .length;
                                                  j++)
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                        children: [

                                                          Text(
                                                            context.locale.toString() == 'ar'?
                                                            detailsProvider
                                                                .order
                                                                .orders!
                                                                .cart!
                                                                .items![i]
                                                                .cartitemaddon![j]
                                                                .addon!
                                                                .nameAr
                                                                .toString():
                                                            detailsProvider
                                                                .order
                                                                .orders!
                                                                .cart!
                                                                .items![i]
                                                                .cartitemaddon![
                                                            j]
                                                                .addon!
                                                                .nameEn
                                                                .toString(),
                                                            softWrap: true,
                                                            overflow:
                                                            TextOverflow
                                                                .fade,
                                                          ),
                                                          Text(
                  detailsProvider
                      .order
                      .orders!
                      .cart!
                      .items![i]
                      .cartitemaddon![
                  j]
                      .addon!
                      .price
                      .toString(),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                ],
                                              ))
                                              : Container(),
                                        ],
                                      ),
                                builder: (_, collapsed, expanded) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
                                    child: Expandable(
                                      collapsed: collapsed,
                                      expanded: expanded,
                                      theme: const ExpandableThemeData(
                                          crossFadePoint: 0),
                                    ),
                                  );
                                },
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20.0, left: 20, bottom: 20, top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LocaleKeys.payment_method_translate.tr(),
                                  //  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey.withOpacity(.5),
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  detailsProvider
                                      .order.orders!.cart!.paymentType
                                      .toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: detailsProvider.order.orders!.cart!
                                                  .paymentType
                                                  .toString() ==
                                              "cash"
                                          ? Colors.red
                                          : kColorPrimary,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LocaleKeys.delivery_translate.tr(),
                                  //  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey.withOpacity(.5),
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  "${detailsProvider.order.orders!.cart!.deliveryFee} R.S",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: kColorPrimary,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LocaleKeys.value_added_translate.tr(),
                                  //  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey.withOpacity(.5),
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  "${detailsProvider.order.orders!.cart!.tax} R.S",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: kColorPrimary,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20.0,
                                      left: 20,
                                      bottom: 5,
                                      top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        LocaleKeys.dis_code_translate.tr(),
                                        //  textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.grey.withOpacity(.5),
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Text(
                                        "${detailsProvider.order.orders?.cart!.discount != null ? detailsProvider.order.orders?.cart!.discount : 0.0} R.S",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: kColorPrimary,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20.0, left: 20, top: 20, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LocaleKeys.total_translate.tr(),
                                  //  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  "R.S ${detailsProvider.order.orders!.cart!.total}"
                                      .toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: kColorPrimary,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(child: CircularProgressIndicator());
            })));
  }
}
