

import 'package:dilivery_app/models/new_order_model.dart';
import 'package:dilivery_app/models/opened_orders_model.dart';
import 'package:dilivery_app/servise/api_order.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewOrderProvider extends ChangeNotifier{
  NewOrderProvider(){
    getNewOrder();
  }
  NewOrdersModel ?order = new NewOrdersModel();
  bool isLoading = true;
  int page =1;
  RefreshController controller = RefreshController();

  void getNewOrder(){
    ApiOrder.instance..getNewOrder(1).then((newOrder){
   order = newOrder!;
      notifyListeners();
    }
    );
  }

  void onRefresh(){
    page++;
    ApiOrder.instance..getNewOrder(page).then((newOrder){
      NewOrdersModel ?order2 = newOrder!;
      order?.data?.addAll(order2.data??[]);
      order2=null;
      controller.loadComplete();
      notifyListeners();
    }
    );
  }

  void refuseOrder(int ?id, String? notes){
    ApiOrder.instance.refuseOrder(id,notes);
    notifyListeners();
  }


// void addToFav(Movie movie){
//   movie.isfav = !movie.isfav;
//   notifyListeners();
// }
//
// void removeMovie (Movie movie){
//   movies.remove(movie);
//
//   notifyListeners();
// }
}