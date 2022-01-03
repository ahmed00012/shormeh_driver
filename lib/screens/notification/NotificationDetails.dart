import 'package:dilivery_app/models/notification_model.dart';
import 'package:dilivery_app/models/notification_model.dart';
import 'package:dilivery_app/translations/locale_keys.g.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

class NotificatinDetails extends StatefulWidget {
  const NotificatinDetails({Key? key, required this.data}) : super(key: key);
  final Data data;

  @override
  _NotificatinDetailsState createState() => _NotificatinDetailsState();
}

class _NotificatinDetailsState extends State<NotificatinDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.data.image!=""?
          Image.network(widget.data.image.toString(), fit: BoxFit.cover,):
          Container(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(widget.data.title),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.data.description),
          ),
        ],
      ),
    );
  }
}
