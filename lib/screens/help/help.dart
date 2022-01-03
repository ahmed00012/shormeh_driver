
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void helpNavigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void helpToast(String info ,Color color ) =>
    Fluttertoast.showToast(
        msg: info,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: color);


