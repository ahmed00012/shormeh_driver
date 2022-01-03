import 'dart:async';

import 'package:dilivery_app/maps/map.dart';
import 'package:dilivery_app/provider/accept_order_provider.dart';
import 'package:dilivery_app/provider/distance_between_ru.dart';
import 'package:dilivery_app/provider/distance_provider.dart';
import 'package:dilivery_app/provider/new_order_provider.dart';
import 'package:dilivery_app/provider/status_provider.dart';
import 'package:dilivery_app/screens/help/constants.dart';

import 'package:dilivery_app/screens/help/default_button.dart';
import 'package:dilivery_app/screens/help/form_error.dart';
import 'package:dilivery_app/screens/help/help.dart';
import 'package:dilivery_app/screens/help/loading_screen.dart';
import 'package:dilivery_app/screens/home/home_screen.dart';
import 'package:dilivery_app/screens/order_details/order_details_screen.dart';
import 'package:dilivery_app/servise/api_exceptions.dart';
import 'package:dilivery_app/servise/api_location.dart';
import 'package:dilivery_app/servise/api_order.dart';
import 'package:dilivery_app/servise/vars.dart';
import 'package:dilivery_app/translations/locale_keys.g.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class NewOrders extends StatefulWidget {
  const NewOrders({Key? key, this.lng, this.lat}) : super(key: key);
  final double? lat;
  final double? lng;

  @override
  _NewOrdersState createState() => _NewOrdersState();
}

class _NewOrdersState extends State<NewOrders> {
  Timer? timer;
  Position? position;
  double? lat;
  double? lng;
  String? note;
  GlobalKey<FormState> _formKey = GlobalKey();
  final List<String> errors = [];

  Future<void> _submitNote(int? id) async {
    _formKey.currentState?.validate();
    try {
      // print('0000000000000000000000000000');
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();
        LoadingScreen.show(context);
        await ApiOrder.instance.refuseOrder(id, note);

        // Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomeScreen(
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserLocation();
    Future.delayed(const Duration(seconds: 20), () {
      if (lat != null) _sendLoc();
    });
    _getUserLocationTimer();
    //  if(lat != null)
    _sendTimer();
    //   else
    // //  print('object');
  }

  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      lat = position.latitude;
      lng = position.longitude;
    });
  }

  void _getUserLocationTimer() async {
    timer = Timer.periodic(Duration(seconds: 280), (Timer t) {
      setState(() {
        _getUserLocation();
      });
    });
  }

  void _sendTimer() async {
    timer = Timer.periodic(Duration(seconds: 300), (Timer t) {
      setState(() {
        _sendLoc();
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> _sendLoc() async {
    try {
      // print('0000000000000000000000000000');
      // LoadingScreen.show(context);
      await ApiLocation.instance.sendLocation(lat.toString(), lng.toString());
      // Navigator.of(context).popUntil((route) => route.isFirst);
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      // helpNavigateTo(context, HomeScreen());
      //   }
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
        // // print(e?.request);
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
      ChangeNotifierProvider<NewOrderProvider>(
          create: (_) => NewOrderProvider(),
          child: Consumer<NewOrderProvider>(
              builder: (buildContext, newProvider, _) => Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        newProvider.order?.data?.length == 0
                            ? Container(
                                color: Colors.white,
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
                                      LocaleKeys.no_requests_translate.tr(),
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: kColorPrimary,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    )
                                  ],
                                ),
                              )
                            : lat != null
                                ? Expanded(
                                    child: SmartRefresher(
                                      controller: newProvider.controller,
                                      onLoading: () {
                                        // print(
                                        //     "-------------------------object--------------------------------");
                                        newProvider.onRefresh();
                                      },
                                      enablePullUp: true,
                                      enablePullDown: false,
                                      child: ListView.builder(
                                        itemCount:
                                            newProvider.order!.data?.length ??
                                                0,
                                        itemBuilder:
                                            (context, index) =>
                                                ChangeNotifierProvider<
                                                        DistanceProvider>(
                                                    create: (_) =>
                                                        DistanceProvider(
                                                            newProvider.order!
                                                                .data![index]),
                                                    child:
                                                        Consumer<
                                                                DistanceProvider>(
                                                            builder: (buildContext,
                                                                    disRuProvider,
                                                                    _) =>
                                                                ChangeNotifierProvider<
                                                                        DistanceCRProvider>(
                                                                    create: (_) => DistanceCRProvider(
                                                                        lat.toString(),
                                                                        lng.toString(),
                                                                        newProvider.order!.data![index]),
                                                                    child: Consumer<DistanceCRProvider>(
                                                                        builder: (buildContext, disCRProvider, _) =>
                                                                            Card(
                                                                              elevation: 3,
                                                                              clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.only(left: 12.0, right: 12, top: 12, bottom: 8),
                                                                                    child: Text(
                                                                                      "# ${newProvider.order!.data![index].id}",
                                                                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                      children: [
                                                                                        GestureDetector(
                                                                                          onTap: () {
                                                                                            // print(lat);
                                                                                            MapUtils.openMap(lat.toString(), lng.toString());
                                                                                          },
                                                                                          child: Column(
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
                                                                                          onTap: () {

                                                                                            MapUtils.openMap(newProvider.order!.data![index].cart!.vendor!.lat, newProvider.order!.data?[index].cart!.vendor!.long);
                                                                                          },
                                                                                          child: Column(
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
                                                                                          onTap: () {
                                                                                            MapUtils.openMap(newProvider.order!.data![index].cart?.address?.lat ?? "0", newProvider.order!.data![index].cart?.address?.lng ?? "0");
                                                                                          },
                                                                                          child: Column(
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
                                                                                    padding: const EdgeInsets.only(top: 22.0, bottom: 12),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                      children: [
                                                                                        Column(
                                                                                          children: [
                                                                                            Container(
                                                                                                decoration: BoxDecoration(
                                                                                                  color: kColorGray.withOpacity(.3),
                                                                                                  shape: BoxShape.circle,
                                                                                                ),
                                                                                                child: IconButton(
                                                                                                    onPressed: () => launch("tel://${newProvider.order!.data![index].user?.phone}"),
                                                                                                    icon: Icon(
                                                                                                      Icons.call,
                                                                                                      color: Colors.green,
                                                                                                      size: 24,
                                                                                                    ))),
                                                                                            Padding(
                                                                                              padding: const EdgeInsets.only(top: 10.0),
                                                                                              child: Text(
                                                                                                LocaleKeys.call_translate.tr(),
                                                                                                style: TextStyle(fontSize: 14),
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                        InkWell(
                                                                                          onTap: () {
                                                                                            helpNavigateTo(
                                                                                                context,
                                                                                                OrderDetailsScreen(
                                                                                                  order: newProvider.order!.data![index],
                                                                                                ));
                                                                                          },
                                                                                          child: Container(
                                                                                            color: kColorGray.withOpacity(.3),
                                                                                            width: 130,
                                                                                            height: 40,
                                                                                            alignment: Alignment.center,
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                              children: [
                                                                                                Text(
                                                                                                  LocaleKeys.order_details_translate.tr(),
                                                                                                  style: TextStyle(fontSize: 14),
                                                                                                ),
                                                                                                Icon(
                                                                                                  Icons.arrow_drop_down_circle_outlined,
                                                                                                  size: 15,
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(12.0),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                      children: [
                                                                                        ChangeNotifierProvider<AcceptOrderProvider>(
                                                                                            create: (context) => AcceptOrderProvider(),
                                                                                            child: Consumer<AcceptOrderProvider>(builder: (buildContext, acceptProvider, _) {
                                                                                              return InkWell(
                                                                                                onTap: () {
                                                                                                  acceptProvider.acceptOrder(newProvider.order!.data![index].id);
                                                                                                  Navigator.of(context)
                                                                                                      .push(MaterialPageRoute(
                                                                                                          builder: (context) => HomeScreen(
                                                                                                                selectedPage: 1,
                                                                                                              )))
                                                                                                      .then((value) => setState(() {}));
                                                                                                },
                                                                                                child: Container(
                                                                                                  width: 130,
                                                                                                  height: 40,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: Colors.white,
                                                                                                    border: Border.all(),
                                                                                                    borderRadius: BorderRadius.circular(5.0),
                                                                                                  ),
                                                                                                  child: Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                    children: [
                                                                                                      Text(
                                                                                                        LocaleKeys.accept_translate.tr(),
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
                                                                                              );
                                                                                            })),
                                                                                        GestureDetector(
                                                                                          onTap: () {
                                                                                            _showRefusedDialog(context, newProvider.order!.data![index].id);
                                                                                          },
                                                                                          child: Container(
                                                                                            width: 130,
                                                                                            height: 40,
                                                                                            decoration: BoxDecoration(
                                                                                              color: Colors.white,
                                                                                              border: Border.all(),
                                                                                              borderRadius: BorderRadius.circular(5.0),
                                                                                            ),
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                              children: [
                                                                                                Text(
                                                                                                  LocaleKeys.reject_translate.tr(),
                                                                                                  style: TextStyle(fontSize: 16),
                                                                                                ),
                                                                                                Icon(
                                                                                                  Icons.remove_circle,
                                                                                                  color: Colors.red,
                                                                                                  size: 20,
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
                                                                            ))))),
                                      ),
                                    ),
                                  )
                                : Center(child: Column(
                                  children: [
                                    CircularProgressIndicator(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("loading location ....", style: TextStyle(color: Colors.green, fontSize: 18),),
                                    ),
                                  ],
                                )),
                        ChangeNotifierProvider<StatusProvider>(
                            create: (context) => StatusProvider(),
                            child: Consumer<StatusProvider>(
                                builder: (buildContext, sProvider, _) =>
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12.0, bottom: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 0),
                                            child: SizedBox(
                                              height: 60,
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2 - 16,
                                              child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    primary: Colors.white,
                                                    backgroundColor:
                                                        kColorPrimary,
                                                    onSurface: Colors.grey,
                                                  ),
                                                  onPressed: () async {
                                                    //  LoadingScreen.show(context);
                                                    setState(() {
                                                      newProvider.getNewOrder();
                                                      newProvider.page=1;
                                                    });
                                                  },
                                                  child: Text(
                                                    LocaleKeys.refresh_translate
                                                        .tr(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  )),
                                            ),
                                          ),
                                          Container(
                                            height: 60,
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2 -
                                                8,
                                            child: DefaultButton(
                                                press: () async {
                                                  sProvider.changeStatus();
                                                },
                                                text: sProvider.statuss == "1"
                                                    ? LocaleKeys
                                                        .online_translate
                                                        .tr()
                                                    : LocaleKeys
                                                        .offline_translate
                                                        .tr(),
                                                height: 60,
                                                fontSize: 16,
                                                radius: 5,
                                                color: sProvider.statuss == "1"
                                                    ? kColorPrimary
                                                    : Colors.red,
                                                fontColor: Colors.white),
                                          ),
                                        ],
                                      ),
                                    )))
                      ],
                    ),
                  )));

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
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        child: DefaultButton(
                          text: LocaleKeys.send_translate.tr(),
                          press: () {
                            _submitNote(id!);
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
