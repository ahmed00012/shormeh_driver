// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// import 'main.dart';
//
// class NotificationSC extends StatefulWidget {
//   const NotificationSC({Key? key}) : super(key: key);
//
//   @override
//   _NotificationSCState createState() => _NotificationSCState();
// }
//
// class _NotificationSCState extends State<NotificationSC> {
//
//   int _counter = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     fcmNotification() {
//       //FCM
//       FirebaseMessaging.instance
//           .getInitialMessage();
//       //     .then((RemoteMessage message) {
//       //   if (message != null) {
//       //     // Navigator.pushNamed(context, '/message',
//       //     //     arguments: MessageArguments(message, true));
//       //   }
//       // });
//       //دية بتستقبل النوتيكفكشن وتعرضها
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         RemoteNotification? notification = message.notification;
//         AndroidNotification? android = message.notification?.android;
//         if (notification != null && android != null) {
//           flutterLocalNotificationsPlugin.show(
//               notification.hashCode,
//               notification.title,
//               notification.body,
//               NotificationDetails(
//                 android: AndroidNotificationDetails(
//                   "",
//                   notification.title??"",
//                   notification.body??"",
//                   // TODO add a proper drawable resource to android, for now using
//                   //      one that already exists in WorldDesigns app.
//                   icon: 'app_icon',
//                 ),
//               ));
//         }
//       });
//
//       //ديه بتفتح التطبيق وتقيم الخدمة
//       // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       //   print(
//       //       'A new onMessageOpenedApp event was published Message ${message.notification.title} ');
//       //   if (message.notification!.title == "تقيم الخدمة") {
//       //     Navigator.pushNamed(
//       //       context,
//       //       '/taqeem',
//       //     );
//       //   } else {
//       //     Navigator.pushNamed(
//       //       context,
//       //       '/message',
//       //     );
//       //   }
//       // });
//
//       FirebaseMessaging.instance.getToken().then((value) {
//         print("FIREBASE TOKEN $value");
//       });
//     }
//     // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     //   RemoteNotification? notification = message.notification;
//     //   AndroidNotification? android = message.notification?.android;
//     //   if (notification != null && android != null) {
//     //     flutterLocalNotificationsPlugin.show(
//     //         notification.hashCode,
//     //         notification.title,
//     //         notification.body,
//     //         NotificationDetails(
//     //           android: AndroidNotificationDetails(
//     //             channel.id,
//     //             channel.name,
//     //             channel.description,
//     //             color: Colors.blue,
//     //             playSound: true,
//     //             icon: '@mipmap/ic_launcher',
//     //           ),
//     //         ));
//     //   }
//     // });
//     //
//     //
//     //
//     // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     //   print('A new onMessageOpenedApp event was published!');
//     //   RemoteNotification? notification = message.notification;
//     //   AndroidNotification? android = message.notification?.android;
//     //   if (notification != null && android != null) {
//     //     showDialog(
//     //         context: context,
//     //         builder: (_) {
//     //           return AlertDialog(
//     //             title: Text(notification.title??""),
//     //             content: SingleChildScrollView(
//     //               child: Column(
//     //                 crossAxisAlignment: CrossAxisAlignment.start,
//     //                 children: [Text(notification.body??"")],
//     //               ),
//     //             ),
//     //           );
//     //         });
//     //   }
//     // });
//   }
//
//   void showNotification() {
//     setState(() {
//       _counter++;
//     });
//     flutterLocalNotificationsPlugin.show(
//         0,
//         "Testing $_counter",
//         "How you doin ?",
//         NotificationDetails(
//             android: AndroidNotificationDetails(channel.id, channel.name, channel.description,
//                 importance: Importance.high,
//                 color: Colors.blue,
//                 playSound: true,
//                 icon: '@mipmap/ic_launcher')));
//   }
//
//     @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("kk"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: showNotification,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
