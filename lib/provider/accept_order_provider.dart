

import 'package:dilivery_app/models/new_order_model.dart';
import 'package:dilivery_app/models/opened_orders_model.dart';
import 'package:dilivery_app/servise/api_order.dart';
import 'package:flutter/material.dart';

class AcceptOrderProvider extends ChangeNotifier{
  AcceptOrderProvider(){
   // acceptOrder(order.id);
  }
  NewOrdersModel order = new NewOrdersModel();





  void acceptOrder(int? id){
    ApiOrder.instance..acceptOrder(id).then((newOrder){
      order = newOrder!;
      notifyListeners();
    }
    );
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