

import 'package:dilivery_app/models/new_order_model.dart';
import 'package:dilivery_app/models/notification_model.dart';
import 'package:dilivery_app/models/opened_orders_model.dart';
import 'package:dilivery_app/servise/api_notifacation.dart';
import 'package:dilivery_app/servise/api_order.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationProvider extends ChangeNotifier{
  NotificationProvider(){
    getNotification();
  }
  NotificationModel notification = new NotificationModel();
  int page =1;
  RefreshController controller = RefreshController();




  void getNotification(){
    ApiNotification.instance..getNotification(1).then((newNoti){
      notification = newNoti!;
      notifyListeners();
    }
    );
  }
  void onRefresh(){
    page++;
    ApiNotification.instance..getNotification(page).then((newNoti){
      NotificationModel? notification2 = newNoti!;
      notification.notifications!.data.addAll(notification2.notifications?.data??[]);
     notification2=null;
      controller.loadComplete();
      notifyListeners();

    }
    );
  }

  void refuseOrder(int ?id, String? notes){
    ApiOrder.instance.refuseOrder(id,notes);
    notifyListeners();
  }

}