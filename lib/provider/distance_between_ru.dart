

import 'dart:async';

import 'package:dilivery_app/models/distance_model.dart';
import 'package:dilivery_app/models/new_order_model.dart';
import 'package:dilivery_app/models/opened_orders_model.dart';
import 'package:dilivery_app/servise/api_distance.dart';
import 'package:dilivery_app/servise/api_order.dart';
import 'package:flutter/material.dart';

class DistanceCRProvider extends ChangeNotifier{

  DistanceCRProvider(String ?lat1,String? lng1,NewOrder order){
    const oneSec = Duration(seconds:50);
  //  Timer.periodic(oneSec, (Timer t) =>
       getDistance(lat1,lng1,order.cart!.vendor?.lat,order.cart!.vendor?.long);
  //  );

  }
  DistanceModel distance = new DistanceModel();





  void getDistance(String ?lat1,String ?lng1,String ?lat2,String ?lng2){
    ApiDistance.instance..getDistance(lat1,lng1,lat2,lng2,"driver").then((newOrder){
      distance = newOrder!;
      notifyListeners();
    }
    );
  }

}