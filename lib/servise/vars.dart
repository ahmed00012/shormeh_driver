import 'dart:ui';

import 'package:dilivery_app/models/user_model.dart';
import 'package:dilivery_app/screens/help/error_dialog.dart';
import 'package:flutter/material.dart';

class ServerConstants {
  static bool isValidResponse(int statusCode) {
    return statusCode >= 200 && statusCode <= 302;
  }

  static void showDialog1(BuildContext context, String s) {
    showDialog(
      context: context,
      builder: (context) => ErrorPopUp(message: '$s'),
    );
  }

  static String? getUserToken() {
    // print('_getUserToken()');
    UserModel user = UserModel();
    // print('UserModel');

    String? userToken = user.accessToken;
    // print(userToken);
    // if (userToken == null) throw "User Not Logged In";
    return userToken;
  }

  static const bool IS_DEBUG = true; // TODO: Close Debugging in Release.
  static const String API = "https://worldapp.site/api";
  static const String Login = "${API}/auth/driverlogin";
  static const String AcceptOrder = "${API}/driver/accept_order";
  static const String GetOpenOrder = "${API}/driver/orders/opened";
  static const String GetCloseOrder = "${API}/driver/orders/closed";
  static const String GetNewOrder = "${API}/driver/orders/new";
  static const String GetOrderDetails = "${API}/driver/order/";
  static const String GetDistance = "${API}/driver/distance";
  static const String Rate = "${API}/driver/rate";
  static const String DeliveredOrder = "${API}/driver/deliver/order/";
  static const String FailedOrder = "${API}/driver/failed/order/";
  static const String RefuseOrder = "${API}/driver/refused/order";
  static const String Status = "${API}/driver/change_status";
  static const String Logout = "${API}/auth/driverlogout";
  static const String ChangePass = "${API}/auth/driver/change_password";
  static const String Slider = "${API}/settings/app";
  static const String SendLoc = "${API}/driver/save-driver-location";


}
