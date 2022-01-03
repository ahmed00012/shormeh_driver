import 'dart:async';
import 'dart:io';

import 'package:dilivery_app/models/change_status.dart';
import 'package:dilivery_app/models/user_model.dart';
import 'package:dilivery_app/servise/api_exceptions.dart';
import 'package:dilivery_app/servise/api_order.dart';
import 'package:dilivery_app/servise/auth_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  //AuthService _api = ApiProvider.instance;
  UserModel? userModel;
  StatusModel status = new StatusModel();
  String lang = "en";


  Future<void> login(
      String phone,
      String password,
      String deviceId,
      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lang =  prefs.getString("lang")??"en";
    userModel = await AuthService.instance.login(phone, password, deviceId,lang);

   // getProfile();
    notifyListeners();
  }
  Future<void> changePass(
      String oldPassword,
      String newPassword,
      ) async {
     await AuthService.instance.changePass(oldPassword, newPassword);
    notifyListeners();
  }
  Future<void> changeStatus() async{
  await  AuthService.instance.changeStatus().then((newOrder){
      status = newOrder!;
    notifyListeners();
    }
    );
  }

  Future<void> logout() async {
    await AuthService.instance.logOut();
   // await userModel?.resetUser();
    userModel = null;
//    _timer?.cancel();

    notifyListeners();
  }

  // Future<void> accept(
  //     int orderId,
  //     ) async {
  //   await ApiOrder.instance.accept(orderId);
  //   // getProfile();
  //   notifyListeners();
  // }



//   Future<void> logout() async {
//     await userModel?.resetUser();
//     userModel = null;
// //    _timer?.cancel();
//
//     notifyListeners();
//   }
}
