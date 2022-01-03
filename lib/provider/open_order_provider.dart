

import 'package:dilivery_app/models/delivered_order.dart';
import 'package:dilivery_app/models/new_order_model.dart';
import 'package:dilivery_app/models/opened_orders_model.dart';
import 'package:dilivery_app/servise/api_order.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OpenOrderProvider extends ChangeNotifier{
  OpenOrderProvider(){
    getOpenedOrder();
  }
  NewOrdersModel? order = new NewOrdersModel();
  RefreshController controller = RefreshController();
  int page =1;


  void deliveredOrder(int ?id){
    ApiOrder.instance.deliveredOrder(id);
      notifyListeners();
    }
  // void failedOrder(int ?id, String ){
  //   ApiOrder.instance.failedOrder(id);
  //   notifyListeners();
  // }
  void getOpenedOrder(){
    ApiOrder.instance.getOpenedOrder(1).then((newOrder){
  order = newOrder!;
      notifyListeners();
    }
    );
  }
  void onRefresh(){
    page++;
    ApiOrder.instance..getOpenedOrder(page).then((newOrder){
      NewOrdersModel? order2 = newOrder!;
      order?.data?.addAll(order2.data??[]);
     order2= null;
      controller.loadComplete();
      notifyListeners();
    }
    );
  }



}