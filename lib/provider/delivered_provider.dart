//
//
// import 'package:dilivery_app/models/delivered_order.dart';
// import 'package:dilivery_app/models/opened_orders_model.dart';
// import 'package:dilivery_app/servise/api_order.dart';
// import 'package:flutter/material.dart';
//
// class DeliveredOrderProvider extends ChangeNotifier{
//   DeliveredOrderProvider(){
//     // acceptOrder(order.id);
//   }
//   DeliveredOrder order = new DeliveredOrder();
//
//
//
//
//
//   void acceptOrder(DeliveredOrder order){
//     ApiOrder.instance.deliveredOrder(order.orders!.id).then((newOrder){
//       order = newOrder!;
//       notifyListeners();
//     }
//     );
//   }
//
// // void addToFav(Movie movie){
// //   movie.isfav = !movie.isfav;
// //   notifyListeners();
// // }
// //
// // void removeMovie (Movie movie){
// //   movies.remove(movie);
// //
// //   notifyListeners();
// // }
// }