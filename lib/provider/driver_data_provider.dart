

import 'package:dilivery_app/models/delivered_order.dart';
import 'package:dilivery_app/models/new_order_model.dart';
import 'package:dilivery_app/models/opened_orders_model.dart';
import 'package:dilivery_app/servise/api_order.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverDataProvider extends ChangeNotifier{
  DriverDataProvider(){
    getData();
  }
  String? fName;
  String ?lName;
  String ?vNameEn;
  String ?vNameAr;
  void getData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fName = prefs.getString('fName');
    lName = prefs.getString('lName');
    vNameEn = prefs.getString('vendor_name_en');
    vNameAr = prefs.getString('vendor_name_ar');
    notifyListeners();
  }



}