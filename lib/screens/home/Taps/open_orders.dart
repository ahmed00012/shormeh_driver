import 'dart:async';

import 'package:dilivery_app/maps/map.dart';
import 'package:dilivery_app/provider/distance_between_ru.dart';
import 'package:dilivery_app/provider/distance_provider.dart';
import 'package:dilivery_app/provider/open_order_provider.dart';

import 'package:dilivery_app/screens/help/constants.dart';
import 'package:dilivery_app/screens/help/default_button.dart';
import 'package:dilivery_app/screens/help/form_error.dart';
import 'package:dilivery_app/screens/help/help.dart';
import 'package:dilivery_app/screens/help/loading_screen.dart';
import 'package:dilivery_app/screens/order_details/order_details_screen.dart';
import 'package:dilivery_app/servise/api_exceptions.dart';
import 'package:dilivery_app/servise/api_order.dart';
import 'package:dilivery_app/servise/vars.dart';
import 'package:dilivery_app/translations/locale_keys.g.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home_screen.dart';

class OpenedOrders extends StatefulWidget {
  const OpenedOrders({Key? key}) : super(key: key);


  @override
  _OpenedOrdersState createState() => _OpenedOrdersState();
}

class _OpenedOrdersState extends State<OpenedOrders> {
  Position? position;
  double? lat;
  double? lng;
  double rate = 0;
  String ?comment ;
  String? note ;
  Timer? timer;
  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<FormState> _key = GlobalKey();
  int page =1;
  final List<String> errors = [];

  void launchMapsUrl(
      sourceLatitude,
      sourceLongitude,
      destinationLatitude,
      destinationLongitude) async {
    String mapOptions = [
      'saddr=$sourceLatitude,$sourceLongitude',
      'daddr=$destinationLatitude,$destinationLongitude',
      'dir_action=navigate'
    ].join('&');

    final url = 'https://www.google.com/maps?$mapOptions';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }  }

  @override
  void initState() {
    super.initState();
    _getUserLocation();


  }


  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      lat = position.latitude;
      lng = position.longitude;
    });
  }


  Future<void> _submitRate(int? id) async {
    try {
      // print('0000000000000000000000000000');
      // print('111111111111111111111');
      _key.currentState?.save();
       LoadingScreen.show(context);
      await ApiOrder.instance.rate(id, rate, comment!);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeScreen(
                selectedPage: 0,
              )));
    } on ApiException catch (_) {
      // print('ApiException');
      Navigator.of(context).pop();
      ServerConstants.showDialog1(context, _.toString());
    } on DioError catch (e) {
      //<<<<< IN THIS LINE
      // print(
      //     "e.response.statusCode    ////////////////////////////         DioError");
      if (e.response!.statusCode == 400) {
        // print(e.response!.statusCode);
      } else {
        // print(e.message);
        // // print(e.request);
      }
    } catch (e) {
      // print('catch');
      // print(e);

      Navigator.of(context).pop();
      ServerConstants.showDialog1(context, e.toString());
    } finally {
      if (mounted) setState(() {});
    }
  }
  Future<void> _submitRefused(int? id) async {
    _formKey.currentState?.validate();
    try {
      // print('0000000000000000000000000000');
      if (_formKey.currentState!.validate()) {
        // print('111111111111111111111');
        _formKey.currentState?.save();
        LoadingScreen.show(context);
        await ApiOrder.instance.failedOrder(id, note!);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>
                HomeScreen(
                  selectedPage: 0,
                )));
      }
    } on ApiException catch (_) {
      // print('ApiException');
      Navigator.of(context).pop();
      ServerConstants.showDialog1(context, _.toString());
    } on DioError catch (e) {
      //<<<<< IN THIS LINE
      // print(
      //     "e.response.statusCode    ////////////////////////////         DioError");
      if (e.response!.statusCode == 400) {
        // print(e.response!.statusCode);
      } else {
        // print(e.message);
        // // print(e.request);
      }
    } catch (e) {
      // print('catch');
      // print(e);

      Navigator.of(context).pop();
      ServerConstants.showDialog1(context, e.toString());
    } finally {
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<OpenOrderProvider>(
          create: (context) => OpenOrderProvider(),
          child: Consumer<OpenOrderProvider>(
              builder: (buildContext, openProvider, _) {
                return  lat != null?
                  Container(
                  child: openProvider.order?.data?.length ==0?
                  Container(
                    color: Colors.white,
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 0,
                            ),
                            Image.asset(
                              "assets/images/d.gif",
                              height: 270,
                              //   width: 300,
                            ),
                            SizedBox(height: 30,),
                            Text(
                              LocaleKeys.no_requests_translate.tr(),
                              style: TextStyle(
                                  fontSize: 22,
                                  color: kColorPrimary,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        )),
                  ):
                  Column(
                      children: [
                        Expanded(
                            child: SmartRefresher(
                              controller: openProvider.controller,
                              onLoading: () {
                                openProvider.onRefresh();
                              },
                              onRefresh: ()async{
                                openProvider.getOpenedOrder();
                                openProvider.page=1;
                                setState(() {
                                  _getUserLocation();
                                });
                                await Future.delayed(Duration(milliseconds: 4000));
                                openProvider.controller.refreshCompleted();
                              },
                              enablePullUp: true,
                              enablePullDown: true,
                              child: ListView.builder(
                                  itemCount: openProvider.order!.data?.length ?? 0,
                                  itemBuilder: (context, index) => ChangeNotifierProvider<DistanceProvider>(
                                      create: (_) => DistanceProvider(
                                          openProvider.order!.data![index]),
                                      child: Consumer<DistanceProvider>(
                                          builder:
                                              (buildContext, disRuProvider, _) =>
                                              ChangeNotifierProvider<
                                                  DistanceCRProvider>(
                                                  create: (_) =>
                                                      DistanceCRProvider(
                                                          lat.toString(),
                                                          lng.toString(),
                                                          openProvider.order!
                                                              .data![index]),
                                                  child:
                                                  Consumer<
                                                      DistanceCRProvider>(
                                                      builder: (buildContext,
                                                          disCRProvider,
                                                          _) =>
                                                          Card(
                                                            elevation: 3,
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    12)),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                      12.0,
                                                                      right: 12.0,
                                                                      top: 12,
                                                                      bottom:
                                                                      8),
                                                                  child: Text(
                                                                    "# ${openProvider.order!.data![index].id}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        14,
                                                                        fontWeight:
                                                                        FontWeight.bold),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                      5.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          // print(lat);
                                                                          MapUtils.openMap(lat.toString(),
                                                                              lng.toString());
                                                                        },
                                                                        child:
                                                                        Column(
                                                                          children: [
                                                                            Container(
                                                                              margin: EdgeInsets.only(bottom: 12),
                                                                              height: 60,
                                                                              width: 60,
                                                                              decoration: BoxDecoration(
                                                                                image: DecorationImage(
                                                                                  image: AssetImage('assets/images/dlivery-man.gif'),
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            //child: Image.asset("assets/images/t.png")),
                                                                            Text(
                                                                              LocaleKeys.my_location_translate.tr(),
                                                                              style: TextStyle(color: kColorAccent, fontSize: 14),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Column(
                                                                        children: [
                                                                          Text(
                                                                            "${disCRProvider.distance.message?.distance.toString() ?? "0"} km",
                                                                            style: TextStyle(fontSize: 14),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsets.only(top: 10.0),
                                                                            child: Container(
                                                                              height: 1.0,
                                                                              width: 50.0,
                                                                              color: Colors.black,
                                                                              margin: EdgeInsets.only(bottom: 25.0),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          // print(lat);
                                                                          MapUtils.openMap(openProvider.order!.data![index].cart!.vendor!.lat,
                                                                              openProvider.order!.data![index].cart!.vendor!.long);
                                                                        },
                                                                        child:
                                                                        Column(
                                                                          children: [
                                                                            Container(
                                                                              margin: EdgeInsets.only(bottom: 12),
                                                                              height: 60,
                                                                              width: 60,
                                                                              decoration: BoxDecoration(
                                                                                  image: DecorationImage(
                                                                                    image: AssetImage('assets/images/restaurant.gif'),
                                                                                    fit: BoxFit.cover,
                                                                                  )),
                                                                            ),
                                                                            //    child: Image.asset("assets/images/restaurant.png",height: 30,width: 30,)),
                                                                            Text(
                                                                              LocaleKeys.restaurant_translate.tr(),
                                                                              style: TextStyle(color: kColorAccent, fontSize: 14),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Column(
                                                                        children: [
                                                                          Text(
                                                                            "${disRuProvider.distance.message?.distance.toString() ?? "0"} km",
                                                                            style: TextStyle(fontSize: 14),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsets.only(top: 10.0),
                                                                            child: Container(
                                                                              height: 1.0,
                                                                              width: 50.0,
                                                                              color: Colors.black,
                                                                              margin: EdgeInsets.only(bottom: 25.0),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          MapUtils.openMap(openProvider.order!.data![index].cart?.address?.lat??"0",
                                                                              openProvider.order!.data![index].cart?.address?.lng??"0");
                                                                        },
                                                                        child:
                                                                        Column(
                                                                          children: [
                                                                            Container(
                                                                              height: 60,
                                                                              width: 60,
                                                                              margin: EdgeInsets.only(bottom: 12),
                                                                              decoration: BoxDecoration(
                                                                                  image: DecorationImage(
                                                                                    image: AssetImage('assets/images/home.gif'),
                                                                                    fit: BoxFit.cover,
                                                                                  )),
                                                                            ),
                                                                            //   child: Image.asset("assets/images/map.png")),
                                                                            Text(
                                                                              LocaleKeys.customer_translate.tr(),
                                                                              style: TextStyle(color: kColorAccent, fontSize: 14),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      top:
                                                                      22.0,
                                                                      bottom:
                                                                      12),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                    children: [
                                                                      Column(
                                                                        children: [
                                                                          Container(
                                                                              decoration:
                                                                              BoxDecoration(
                                                                                color: kColorGray.withOpacity(.3),
                                                                                shape: BoxShape.circle,
                                                                              ),
                                                                              child: IconButton(
                                                                                  onPressed: () => launch("tel://${openProvider.order!.data![index].user?.phone}"),
                                                                                  icon: Icon(
                                                                                    Icons.call,
                                                                                    color: Colors.green,
                                                                                    size: 24,
                                                                                  ))),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(top: 10.0),
                                                                            child: Text( LocaleKeys.call_translate.tr(),style: TextStyle(fontSize: 14),),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          helpNavigateTo(
                                                                              context,
                                                                              OrderDetailsScreen(
                                                                                order: openProvider.order!.data![index],
                                                                              ));
                                                                        },
                                                                        child:
                                                                        Container(
                                                                          color:
                                                                          kColorGray.withOpacity(.3),
                                                                          width:
                                                                          130,
                                                                          height:
                                                                          40,
                                                                          alignment:
                                                                          Alignment.center,
                                                                          child:
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                            children: [
                                                                              Text(
                                                                                LocaleKeys.order_details_translate.tr(),
                                                                                style: TextStyle(fontSize: 16),
                                                                              ),
                                                                              Icon(
                                                                                Icons.arrow_drop_down_circle_outlined,
                                                                                size: 20,
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .all(
                                                                      12.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          //  openProvider.deliveredOrder();

                                                                          openProvider.deliveredOrder(openProvider.order!.data![index].id);
                                                                          _showRatingDialog(context,
                                                                              openProvider.order!.data![index].id);
                                                                        },
                                                                        child:
                                                                        Container(
                                                                          width:
                                                                          155,
                                                                          height:
                                                                          40,
                                                                          decoration:
                                                                          BoxDecoration(
                                                                            color: Colors.white,
                                                                            border: Border.all(),
                                                                            borderRadius: BorderRadius.circular(5.0),
                                                                          ),
                                                                          child:
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                            children: [
                                                                              Text(
                                                                                LocaleKeys.delivered_translate.tr(),
                                                                                style: TextStyle(fontSize: 16),
                                                                              ),
                                                                              Icon(
                                                                                Icons.check_circle,
                                                                                color: Colors.green,
                                                                                size: 20,
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          //   openProvider.failedOrder(openProvider.order.orders?[index].id);
                                                                          _showRefusedDialog(context, openProvider.order!.data![index].id);
                                                                        },
                                                                        child:
                                                                        Container(
                                                                          width:
                                                                          155,
                                                                          height:
                                                                          40,
                                                                          decoration:
                                                                          BoxDecoration(
                                                                            color: Colors.white,
                                                                            border: Border.all(),
                                                                            borderRadius: BorderRadius.circular(5.0),
                                                                          ),
                                                                          child:
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                            children: [
                                                                              Text(
                                                                                LocaleKeys.unable_to_delivered_translate.tr(),
                                                                                style: TextStyle(fontSize: 14),
                                                                              ),
                                                                              Icon(
                                                                                Icons.remove_circle,
                                                                                color: Colors.red,
                                                                                size: 15,
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                  )
                                              )
                                      )
                                  )
                              ),
                            )
                        )
                      ]
                  ),
                ) :Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: CircularProgressIndicator()),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("loading location ....", style: TextStyle(color: Colors.green, fontSize: 18),),
                    ),
                  ],
                );
              }
              )
      );

  // : Center(child: CircularProgressIndicator())

  Future _showRatingDialog(context, int? id) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(LocaleKeys.rating_translate.tr()),
                    Container(
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemSize: 35,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            rate = rating;
                            // print(rate);
                          },
                        )),
                    Container(
                      height: 100,
                      width: 400,
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      padding: EdgeInsets.symmetric(
                        horizontal: 14,
                      ),
                      child: TextFormField(
                        onSaved: (newValue) => comment = newValue!,
                        maxLines: null,
                        expands: true,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                            fillColor: Colors.white,
                            focusedBorder: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: BorderSide(
                                    color: Color(0xffF2F2F2), width: 3.0)),
                            labelText: LocaleKeys.add_notes_translate.tr(),
                            labelStyle: TextStyle(
                              fontSize: 14,
                            )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      child: DefaultButton(
                        text: LocaleKeys.send_translate.tr(),
                        press: () {
                          _submitRate(id!);
                          // helpNavigateTo(context, HomeScreen());
                        },
                        color: kColorPrimary,
                        height: 40,
                        fontSize: 14,
                        radius: 8,
                        fontColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
  Future _showRefusedDialog(context, int? id) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(LocaleKeys.reason_translate.tr()),
                      Container(
                        height: 180,
                        width: 500,
                        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        padding: EdgeInsets.symmetric(
                          horizontal: 14,
                        ),
                        child: TextFormField(
                          onSaved: (newValue) => note = newValue!,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              if (errors.contains(kReasonNullError))
                                setState(() {
                                  errors.remove(kReasonNullError);
                                });
                            }
                            return null;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              if (!errors.contains(kReasonNullError))
                                setState(() {
                                  errors.add(kReasonNullError);
                                });
                              return "";
                            }
                            return null;
                          },
                          maxLines: null,
                          expands: true,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                              fillColor: Colors.white,
                              focusedBorder: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                  borderSide: BorderSide(
                                      color: Color(0xffF2F2F2), width: 3.0)),
                              labelText: LocaleKeys.add_notes_translate.tr(),
                              labelStyle: TextStyle(
                                fontSize: 14,
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FormError(errors: errors),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        child: DefaultButton(
                          text:LocaleKeys.send_translate.tr(),
                          press: () {
                            _submitRefused(id!);
                            // helpNavigateTo(context, HomeScreen());
                          },
                          color: kColorPrimary,
                          height: 40,
                          fontSize: 14,
                          radius: 8,
                          fontColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
