

import 'package:dilivery_app/provider/auth_provider.dart';
import 'package:dilivery_app/screens/home/home_screen.dart';
import 'package:dilivery_app/screens/splash_screen/splash_screen.dart';
import 'package:dilivery_app/translations/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('access_token');
  String? lang = prefs.getString('lang');
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(
      EasyLocalization(
          path: "assets/translations",
          supportedLocales: [
            Locale("ar"),
            Locale("en"),
          ],
          fallbackLocale: Locale(lang??"en"),
          assetLoader: CodegenLoader(),
          saveLocale: true,
     child: MyApp(log: token,)));
}

class MyApp extends StatelessWidget {
  final String ?log ;
  //late final bool status;
  const MyApp({Key? key, this.log}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider(
      create: (context)  => AuthProvider(),

    child: MaterialApp(

    title: 'Flutter Demo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    theme: ThemeData(
    primarySwatch: Colors.green,
      fontFamily: 'Tajawal',
    ),

    home: log == null?  SplashScreen(): HomeScreen(selectedPage: 0),
      debugShowCheckedModeBanner: false,
    )
    );
  }
}



