import 'package:dilivery_app/models/notification_model.dart';
import 'package:dilivery_app/provider/notificationProvider.dart';
import 'package:dilivery_app/screens/help/constants.dart';
import 'package:dilivery_app/screens/help/help.dart';
import 'package:dilivery_app/screens/notification/NotificationDetails.dart';
import 'package:dilivery_app/translations/locale_keys.g.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationModel? notification = new NotificationModel();
  int page =1;
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          LocaleKeys.notifications_translate.tr(),
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
      body:   ChangeNotifierProvider<NotificationProvider>(
    create: (context) => NotificationProvider(),
    child: Consumer<NotificationProvider>(
    builder: (buildContext, notifProvider, _) =>
    notifProvider.notification.notifications?.data== null ?
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
                  LocaleKeys.no_notification_translate.tr(),
                style: TextStyle(
                    fontSize: 22,
                    color: kColorPrimary,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          )),
    ):
        SmartRefresher(
          controller: notifProvider.controller,
          onLoading: () {
            // print(
            //     "-------------------------object--------------------------------");
            notifProvider.onRefresh();
          },
          onRefresh: ()async{
            notifProvider.getNotification();
            notifProvider.page =1;
            await Future.delayed(Duration(milliseconds: 3000));
            notifProvider.controller.refreshCompleted();
          },
          enablePullUp: true,
          enablePullDown: true,
          child: ListView.separated(
            itemCount: notifProvider.notification.notifications?.data.length??0,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
              child: GestureDetector(
                onTap: (){
                   helpNavigateTo(context, NotificatinDetails(data: notifProvider.notification.notifications!.data[index]));
                },
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(0),
                          child: Container(
                            //height: 200,
                           // width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12.0),
                                topLeft: Radius.circular(12.0),
                              ),
                            ),
                            child: notifProvider.notification.notifications!.data[index].image!=""?
                              Image.network(notifProvider.notification.notifications!.data[index].image.toString(), fit: BoxFit.cover,):
                                Container(),
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                        child: Text(notifProvider.notification.notifications!.data[index].title, style: TextStyle(fontSize: 18, color: kColorAccent),
                        ),),


                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, bottom: 10),
                        child: Text(notifProvider.notification.notifications!.data[index].description.length >12?
                        "${notifProvider.notification.notifications!.data[index].description.substring(0, 12)} ....":
                        notifProvider.notification.notifications!.data[index].description
                          ,style: TextStyle(fontSize: 16, color: kColorGray),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            separatorBuilder: (context, index) => Divider(
              thickness: 5,
              color: Colors.white,
            ),
          ),
        )),
      ),
    ));
  }
}
