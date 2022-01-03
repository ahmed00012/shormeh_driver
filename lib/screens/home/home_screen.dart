import 'dart:async';

import 'package:dilivery_app/provider/auth_provider.dart';
import 'package:dilivery_app/provider/driver_data_provider.dart';
import 'package:dilivery_app/screens/change_pass/change_pass_screen.dart';
import 'package:dilivery_app/screens/help/constants.dart';
import 'package:dilivery_app/screens/help/help.dart';
import 'package:dilivery_app/screens/help/loading_screen.dart';
import 'package:dilivery_app/screens/home/Taps/new_orders.dart';
import 'package:dilivery_app/screens/home/closed_orders_screen.dart';
import 'package:dilivery_app/screens/login/login_screen.dart';
import 'package:dilivery_app/screens/notification/notification_screen.dart';
import 'package:dilivery_app/servise/api_exceptions.dart';
import 'package:dilivery_app/servise/api_location.dart';
import 'package:dilivery_app/servise/vars.dart';
import 'package:dilivery_app/translations/locale_keys.g.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import 'Taps/open_orders.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.selectedPage}) : super(key: key);
  final int selectedPage;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController? _tabController;
  fcmNotification() {
    FirebaseMessaging.instance.requestPermission(

            sound: true, badge: true, alert: true, provisional: false);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {

        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,

            NotificationDetails(
               iOS: IOSNotificationDetails(
                 subtitle:notification.body ?? "",
               ),
              android: AndroidNotificationDetails(
                "",
                notification.title ?? "",
                notification.body ?? "",
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in WorldDesigns app.
                icon: '@mipmap/ic_launcher',
              ),
            ),


        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {

      if (message.notification!.title == "تغير حالة الطلب") {
        Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (context) => HomeScreen(
                      selectedPage: 0,
                    )))
            .then((value) => setState(() {}));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => NotificationScreen()))
            .then((value) => setState(() {}));
      }
    });

    // FirebaseMessaging.instance.getToken().then((value) {
    // //   print("FIREBASE TOKEN $value");
    // });
  }

  Future<void> _submit() async {
    try {
      // print('0000000000000000000000000000');
      LoadingScreen.show(context);
      await Provider.of<AuthProvider>(context, listen: false).logout();
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
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

  final List<Tab> listTab = [
    Tab(text: "ppp"),
    Tab(text: LocaleKeys.opened_translate.tr()),
    //   Tab(text: 'Women'),
  ];

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new CupertinoAlertDialog(
            title: new Text(
              LocaleKeys.exit_translate.tr(),
              // CodegenLoader.exit.tr(),
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(
                  LocaleKeys.no_translate.tr(),
                ),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text(
                  LocaleKeys.yes_translate.tr(),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fcmNotification();
    _tabController = new TabController(vsync: this, length: listTab.length);
    _nextPage(widget.selectedPage);
    // _getUserLocation();
    //   Future.delayed(const Duration(seconds: 20), () {
    //     if(lat !=null)
    //     _sendLoc();
    //   });
    // Timer.periodic(Duration(seconds:80), (Timer t) => _getUserLocation());
    // if(lat != null)
    // Timer.periodic(Duration(seconds:100), (Timer t) => _sendLoc());
    // else
    // //   print('object');
  }

  void _nextPage(int tab) {
    final int newTab = _tabController!.index + tab;
    if (newTab < 0 || newTab >= _tabController!.length) return;
    _tabController!.animateTo(newTab);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // _tabController = TabController(length: listTab.length, vsync: this);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: DefaultTabController(
          initialIndex: widget.selectedPage,
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                LocaleKeys.orders_translate.tr(),
                style: TextStyle(color: Colors.black),
              ),
              iconTheme: IconThemeData(color: Colors.black),
              centerTitle: true,
              automaticallyImplyLeading: false,
              bottom: TabBar(
                labelStyle: TextStyle(color: Colors.black, fontSize: 16),
                controller: _tabController,
                indicatorWeight: 4,
                indicatorColor: kColorPrimary,
                tabs: [
                  Tab(
                      child: Text(
                    LocaleKeys.new_translate.tr(),
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )),
                  Tab(
                      child: Text(
                    LocaleKeys.opened_translate.tr(),
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )),
                ],
              ),
            ),
            endDrawer: ChangeNotifierProvider<DriverDataProvider>(
                create: (context) => DriverDataProvider(),
                child: Consumer<DriverDataProvider>(
                    builder: (buildContext, dataProvider, _) => Drawer(
                          // Add a ListView to the drawer. This ensures the user can scroll
                          // through the options in the drawer if there isn't enough vertical
                          // space to fit everything.
                          child: Column(
                            // Important: Remove any padding from the ListView.
                            children: [
                              // const DrawerHeader(
                              //   decoration: BoxDecoration(
                              //     color: Colors.white,
                              //   ),
                              //   child: Text(fName),
                              // ),
                              SizedBox(height: 50),
                              // Padding(
                              //   padding: const EdgeInsets.only(top: 25.0),
                              //   child: ClipRRect(
                              //     borderRadius: BorderRadius.circular(6.0),
                              //     child: Image.asset(
                              //      "assets/images/t.png",
                              //       fit: BoxFit.fill,
                              //       height: 70,
                              //       width: 70,
                              //     ),
                              //   ),
                              // ),
                              Text(
                                "${dataProvider.fName} ${dataProvider.lName}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 6),
                                  child: context.locale.toString() == 'ar'
                                      ? Text(
                                          "${dataProvider.vNameAr}",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: kColorPrimary),
                                        )
                                      : Text(
                                          "${dataProvider.vNameEn}",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: kColorPrimary),
                                        )),
                              SizedBox(
                                height: 50,
                              ),
                              ListTile(
                                title: Row(
                                  children: [
                                    const Icon(
                                      Icons.home_outlined,
                                      size: 26,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      LocaleKeys.home_translate.tr(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  // Update the state of the app
                                  // ...
                                  // Then close the drawer
                                  helpNavigateTo(
                                      context, HomeScreen(selectedPage: 0));
                                  // Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: Row(
                                  children: [
                                    const Icon(Icons.history, size: 26),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      LocaleKeys.history_translate.tr(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  // Update the state of the app
                                  // ...
                                  // Then close the drawer
                                  helpNavigateTo(context, ClosedOrdersScreen());
                                },
                              ),
                              ListTile(
                                title: Row(
                                  children: [
                                    const Icon(Icons.notifications_none,
                                        size: 26),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      LocaleKeys.notifications_translate.tr(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  // Update the state of the app
                                  // ...
                                  // Then close the drawer
                                  //Navigator.pop(context);
                                  helpNavigateTo(context, NotificationScreen());
                                },
                              ),
                              ListTile(
                                title: Row(
                                  children: [
                                    const Icon(Icons.lock_outline, size: 26),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      LocaleKeys.password_setting_translate
                                          .tr(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  // Update the state of the app
                                  // ...
                                  // Then close the drawer
                                  helpNavigateTo(context, ChangePassScreen());
                                },
                              ),
                              ListTile(
                                title: Row(
                                  children: [
                                    const Icon(Icons.language, size: 26),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      LocaleKeys.language_translate.tr(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                onTap: () async {
                                  if (context.locale.toString() == 'ar') {
                                    await context.setLocale(
                                      Locale("en"),
                                    );
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString("lang", "en");
                                  } else {
                                    await context.setLocale(
                                      Locale("ar"),
                                    );
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString("lang", "ar");
                                  }
                                },
                              ),
                              ListTile(
                                title: Row(
                                  children: [
                                    const Icon(Icons.logout, size: 26),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      LocaleKeys.log_Out_translate.tr(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                onTap: () async {
                                  // Update the state of the app
                                  // ...
                                  // Then close the drawer
                                  _submit();
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.remove('access_token');
                                },
                              ),
                            ],
                          ),
                        ))),
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IndexedStack(
                children: [
                  TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      Container(
                          height: MediaQuery.of(context).size.height,
                          child: NewOrders()),
                      OpenedOrders(),
                      //  Women(),
                    ],
                  ),
                ],
              ),
            )),
          )),
    );
  }
}
