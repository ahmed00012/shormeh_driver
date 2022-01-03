
import 'package:dilivery_app/models/new_order_model.dart';
import 'package:dilivery_app/servise/api_order.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ClosedOrderProvider extends ChangeNotifier{
  ClosedOrderProvider(){
    getClosedOrder();
  }
  NewOrdersModel order = new NewOrdersModel();
  int page =1;
  RefreshController controller = RefreshController();

  void getClosedOrder(){
    ApiOrder.instance.getClosedOrder(1).then((newOrder){
      order = newOrder!;
      notifyListeners();
    }
    );
  }

  void onRefresh(){

    page++;
//    await Future.delayed(Duration(milliseconds: 1000));
    ApiOrder.instance..getClosedOrder(page).then((newOrder){
      NewOrdersModel? order2 = newOrder!;
      order.data?.addAll(order2.data ??[]);
      order2=null;
      controller.loadComplete();
      notifyListeners();

    }
    );
  }
}