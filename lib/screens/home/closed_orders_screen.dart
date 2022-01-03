import 'dart:async';

import 'package:dilivery_app/maps/map.dart';
import 'package:dilivery_app/provider/closed_order_provider.dart';
import 'package:dilivery_app/screens/help/constants.dart';
import 'package:dilivery_app/screens/help/help.dart';
import 'package:dilivery_app/screens/order_details/order_details_screen.dart';
import 'package:dilivery_app/translations/locale_keys.g.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class ClosedOrdersScreen extends StatefulWidget {
  const ClosedOrdersScreen({Key? key}) : super(key: key);

  @override
  _ClosedOrdersScreenState createState() => _ClosedOrdersScreenState();
}

class _ClosedOrdersScreenState extends State<ClosedOrdersScreen> {
  Position? position;
  double? lat;
  double? lng;
  double rate = 0;
  String comment = "none";
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  timer = Timer.periodic(Duration(seconds: 50), (Timer t) => _getUserLocation());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            LocaleKeys.history_translate.tr(),
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
        body: ChangeNotifierProvider<ClosedOrderProvider>(
          create: (_) => ClosedOrderProvider(),
          child: Consumer<ClosedOrderProvider>(
              builder: (buildContext, closeProvider, _) {
            return closeProvider.order.data?.length == 0
                ? Container(
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
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          LocaleKeys.empty_translate.tr(),
                          style: TextStyle(
                              fontSize: 22,
                              color: kColorPrimary,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                  )
                : Container(
                        child: SmartRefresher(
                        controller: closeProvider.controller,
                        onLoading: () {
                         // print("-------------------------object--------------------------------");
                          closeProvider.onRefresh();
                        },
                        enablePullUp: true,
                        enablePullDown: false,
                        child: ListView.builder(
                            itemCount:
                                closeProvider.order.data?.length ?? 0,
                            itemBuilder: (context, index) => Padding(
                               padding:
                                   const EdgeInsets
                                       .symmetric(horizontal: 8.0,vertical: 4),
                               child:   InkWell(
                                 onTap:
                                     () {
                                   helpNavigateTo(
                                       context,
                                       OrderDetailsScreen(
                                         order: closeProvider.order.data![index],
                                       ));
                                 },
                                 child: Container(
                                   margin: EdgeInsets.all(14),
                                   padding: EdgeInsets.symmetric(horizontal: 20),
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10),
                                     color: Color(0xffF2F2F2),
                                   ),
                                   child: Row(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children: [
                                       Container(
                                         margin: EdgeInsets.all(12),
                                         height: 45,
                                         width: 45,
                                         decoration: BoxDecoration(
                                           image: DecorationImage(
                                             image: AssetImage('assets/images/done.png'),
                                             fit: BoxFit.cover,
                                           ),
                                         ),
                                       ),
                                       SizedBox(width: 20,),
                                       Column(
                                         mainAxisAlignment:
                                         MainAxisAlignment.spaceBetween,
                                         children: [
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                             children: [
                                               Text(
                                           LocaleKeys.order_no_translate.tr(),
                                                 style: TextStyle(
                                                     color: Colors.black,
                                                     fontSize: 18.0,
                                                     fontWeight: FontWeight.bold),
                                               ),
                                               SizedBox(width: 20,),
                                               Text(
                                                 closeProvider.order.data![index].id.toString(),
                                                 style: TextStyle(
                                                     color: kColorPrimary,
                                                     fontSize: 18.0,
                                                     fontWeight: FontWeight.bold),
                                               ),
                                             ],
                                           ),
                                           // SizedBox(height: 5,),
                                           // FittedBox(
                                           //   fit: BoxFit.fitHeight,
                                           //   child: Text(
                                           //     closeProvider.order.data![index].user!.name.toString(),
                                           //     textAlign: TextAlign.center,
                                           //     style: TextStyle(
                                           //         color: Colors.black,
                                           //         fontSize: 14.0),
                                           //   ),
                                           // ),
                                         ],
                                       ),
                                     ],
                                   ),
                                   ),
                               ),
                               ),
                               // child: Card(
                               //   clipBehavior: Clip
                               //       .antiAliasWithSaveLayer,
                               //   shape: RoundedRectangleBorder(
                               //       borderRadius:
                               //           BorderRadius.circular(
                               //               12)),
                               //   child: Column(
                               //     mainAxisAlignment:
                               //         MainAxisAlignment
                               //             .start,
                               //     crossAxisAlignment:
                               //         CrossAxisAlignment
                               //             .start,
                               //     children: [
                               //       Padding(
                               //         padding: const EdgeInsets
                               //                 .only(
                               //             left:
                               //                 12.0,
                               //             right: 12,
                               //             top:
                               //                 12,
                               //             bottom:
                               //                 8),
                               //         child:
                               //             Text(
                               //           "# ${closeProvider.order.data![index].id}",
                               //           style: TextStyle(
                               //               fontSize:
                               //                   12,
                               //               fontWeight:
                               //                   FontWeight.bold),
                               //         ),
                               //       ),
                               //       Padding(
                               //         padding: const EdgeInsets
                               //                 .symmetric(
                               //             horizontal:
                               //                 5.0),
                               //         child:
                               //             Row(
                               //           mainAxisAlignment:
                               //               MainAxisAlignment.spaceBetween,
                               //           children: [
                               //             GestureDetector(
                               //               onTap:
                               //                   () {
                               //                 // print(lat);
                               //                 MapUtils.openMap(lat.toString(),
                               //                     lng.toString());
                               //               },
                               //               child:
                               //                   Column(
                               //                 children: [
                               //                   Container(
                               //                     margin: EdgeInsets.only(bottom: 12),
                               //                     height: 60,
                               //                     width: 60,
                               //                     decoration: BoxDecoration(
                               //                       image: DecorationImage(
                               //                         image: AssetImage('assets/images/dlivery-man.gif'),
                               //                         fit: BoxFit.cover,
                               //                       ),
                               //                     ),
                               //                   ),
                               //                   //child: Image.asset("assets/images/t.png")),
                               //                   Text(
                               //                     LocaleKeys.my_location_translate.tr(),
                               //                     style: TextStyle(color: kColorAccent, fontSize: 10),
                               //                   ),
                               //                 ],
                               //               ),
                               //             ),
                               //             // Column(
                               //             //   children: [
                               //             //     // Text(
                               //             //     //   "${disCRProvider.distance.message?.distance.toString() ?? "0"} km",
                               //             //     //   style: TextStyle(fontSize: 10),
                               //             //     // ),
                               //             //     Padding(
                               //             //       padding: EdgeInsets.only(top: 10.0),
                               //             //       child: Container(
                               //             //         height: 1.0,
                               //             //         width: 50.0,
                               //             //         color: Colors.black,
                               //             //         margin: EdgeInsets.only(bottom: 25.0),
                               //             //       ),
                               //             //     ),
                               //             //   ],
                               //             // ),
                               //             GestureDetector(
                               //               onTap:
                               //                   () {
                               //                 MapUtils.openMap(closeProvider.order.data![index].cart!.vendor?.lat, closeProvider.order.data![index].cart!.vendor!.long);
                               //               },
                               //               child:
                               //                   Column(
                               //                 children: [
                               //                   Container(
                               //                     margin: EdgeInsets.only(bottom: 12),
                               //                     height: 60,
                               //                     width: 60,
                               //                     decoration: BoxDecoration(
                               //                         image: DecorationImage(
                               //                       image: AssetImage('assets/images/restaurant.gif'),
                               //                       fit: BoxFit.cover,
                               //                     )),
                               //                   ),
                               //                   //    child: Image.asset("assets/images/restaurant.png",height: 30,width: 30,)),
                               //                   Text(
                               //                     LocaleKeys.restaurant_translate.tr(),
                               //                     style: TextStyle(color: kColorAccent, fontSize: 9),
                               //                   ),
                               //                 ],
                               //               ),
                               //             ),
                               //             // Column(
                               //             //   children: [
                               //             //     // Text(
                               //             //     //   "${disRuProvider.distance.message?.distance.toString() ?? "0"} km",
                               //             //     //   style: TextStyle(fontSize: 10),
                               //             //     // ),
                               //             //     Padding(
                               //             //       padding: EdgeInsets.symmetric(vertical: 5.0),
                               //             //       child: Container(
                               //             //         height: 1.0,
                               //             //         width: 50.0,
                               //             //         color: Colors.black,
                               //             //         margin: EdgeInsets.only(bottom: 25.0),
                               //             //       ),
                               //             //     ),
                               //             //   ],
                               //             // ),
                               //             GestureDetector(
                               //               onTap:
                               //                   () {
                               //                 MapUtils.openMap(closeProvider.order.data![index].cart!.address!.lat, closeProvider.order.data![index].cart!.address!.lng);
                               //               },
                               //               child:
                               //                   Column(
                               //                 children: [
                               //                   Container(
                               //                     height: 60,
                               //                     width: 60,
                               //                     margin: EdgeInsets.only(bottom: 12),
                               //                     decoration: BoxDecoration(
                               //                         image: DecorationImage(
                               //                       image: AssetImage('assets/images/home.gif'),
                               //                       fit: BoxFit.cover,
                               //                     )),
                               //                   ),
                               //                   //   child: Image.asset("assets/images/map.png")),
                               //                   Text(
                               //                     LocaleKeys.customer_translate.tr(),
                               //                     style: TextStyle(color: kColorAccent, fontSize: 9),
                               //                   ),
                               //                 ],
                               //               ),
                               //             ),
                               //           ],
                               //         ),
                               //       ),
                               //       Padding(
                               //         padding: const EdgeInsets
                               //                 .only(
                               //             top:
                               //                 22.0,
                               //             bottom:
                               //                 12),
                               //         child:
                               //             Row(
                               //           mainAxisAlignment:
                               //               MainAxisAlignment.spaceEvenly,
                               //           children: [
                               //             Container(
                               //                 height: 40,
                               //                 width: 40,
                               //                 decoration: BoxDecoration(
                               //                   color: kColorGray.withOpacity(.3),
                               //                   shape: BoxShape.circle,
                               //                 ),
                               //                 child: IconButton(
                               //                     onPressed: () => launch("tel://${closeProvider.order.data![index].user!.phone}"),
                               //                     icon: Icon(
                               //                       Icons.call,
                               //                       color: Colors.green,
                               //                       size: 20,
                               //                     ))),
                               //             InkWell(
                               //               onTap:
                               //                   () {
                               //                 helpNavigateTo(
                               //                     context,
                               //                     OrderDetailsScreen(
                               //                       order: closeProvider.order.data![index],
                               //                     ));
                               //               },
                               //               child:
                               //                   Container(
                               //                 color: kColorGray.withOpacity(.3),
                               //                 width: 130,
                               //                 height: 30,
                               //                 alignment: Alignment.center,
                               //                 child: Row(
                               //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                               //                   children: [
                               //                     Text(
                               //                       LocaleKeys.order_details_translate.tr(),
                               //                       style: TextStyle(fontSize: 12),
                               //                     ),
                               //                     Icon(
                               //                       Icons.arrow_drop_down_circle_outlined,
                               //                       size: 15,
                               //                     )
                               //                   ],
                               //                 ),
                               //               ),
                               //             ),
                               //             // Container(
                               //             //     color:
                               //             //     kColorGray.withOpacity(.3),
                               //             //     width:
                               //             //     130,
                               //             //     height:
                               //             //     30,
                               //             //     alignment: Alignment.center,
                               //             //    padding: const EdgeInsets
                               //             //        .only(
                               //             //        bottom:0),
                               //             // child: Icon(Icons.call,color: Colors.red,size: 24,)
                               //
                               //             //   ),
                               //           ],
                               //         ),
                               //       ),
                               //       // Padding(
                               //       //   padding: const EdgeInsets
                               //       //       .all(
                               //       //       12.0),
                               //       //   child: Row(
                               //       //     mainAxisAlignment:
                               //       //     MainAxisAlignment
                               //       //         .spaceEvenly,
                               //       //     children: [
                               //       //       GestureDetector(
                               //       //         onTap:
                               //       //             () {
                               //       //           //  openProvider.deliveredOrder();
                               //       //
                               //       //           openProvider.deliveredOrder(openProvider.order.orders?[index].id);
                               //       //           _showDoneDialog(context,
                               //       //               openProvider.order.orders?[index].id);
                               //       //         },
                               //       //         child:
                               //       //         Container(
                               //       //           width:
                               //       //           150,
                               //       //           height:
                               //       //           30,
                               //       //           decoration:
                               //       //           BoxDecoration(
                               //       //             color: Colors.white,
                               //       //             border: Border.all(),
                               //       //             borderRadius: BorderRadius.circular(5.0),
                               //       //           ),
                               //       //           child:
                               //       //           Row(
                               //       //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                               //       //             children: [
                               //       //               Text(
                               //       //                 "Delivered",
                               //       //                 style: TextStyle(fontSize: 12),
                               //       //               ),
                               //       //               Icon(
                               //       //                 Icons.check_circle,
                               //       //                 color: Colors.green,
                               //       //                 size: 15,
                               //       //               )
                               //       //             ],
                               //       //           ),
                               //       //         ),
                               //       //       ),
                               //       //       GestureDetector(
                               //       //         onTap:
                               //       //             () {
                               //       //           openProvider.failedOrder(openProvider.order.orders?[index].id);
                               //       //           //     _showDoneDialog(context, openProvider.order.orders?[index].id);
                               //       //         },
                               //       //         child:
                               //       //         Container(
                               //       //           width:
                               //       //           150,
                               //       //           height:
                               //       //           30,
                               //       //           decoration:
                               //       //           BoxDecoration(
                               //       //             color: Colors.white,
                               //       //             border: Border.all(),
                               //       //             borderRadius: BorderRadius.circular(5.0),
                               //       //           ),
                               //       //           child:
                               //       //           Row(
                               //       //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                               //       //             children: [
                               //       //               Text(
                               //       //                 "Unable To Delivered",
                               //       //                 style: TextStyle(fontSize: 12),
                               //       //               ),
                               //       //               Icon(
                               //       //                 Icons.remove_circle,
                               //       //                 color: Colors.red,
                               //       //                 size: 15,
                               //       //               )
                               //       //             ],
                               //       //           ),
                               //       //         ),
                               //       //       ),
                               //       //     ],
                               //       //   ),
                               //       // ),
                               //     ],
                               //   ),
                               // ),
                             )));
                //)

                //),
                  //    ))

          }),
        ));
  }
}
