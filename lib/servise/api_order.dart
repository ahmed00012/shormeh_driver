


import 'package:dilivery_app/models/delivered_order.dart';
import 'package:dilivery_app/models/new_order_model.dart';

import 'package:dilivery_app/models/opened_orders_model.dart';
import 'package:dilivery_app/models/order_details.dart';
import 'package:dilivery_app/models/user_model.dart';
import 'package:dilivery_app/servise/vars.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'api_exceptions.dart';


class ApiOrder {
  ApiOrder._();

  static final ApiOrder instance = ApiOrder._();
  static OpenedOrders? openedOrders;
  static NewOrdersModel? newOrders;
  static DeliveredOrder? delivered;
  static OrderDetailsModel? details;


  var dio = Dio()
    ..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));

  //
  static Map<String, String> apiHeaders ={
    "Content-Type": "application/json",
    "X-Requested-With": "XMLHttpRequest",
    "Content-Language": "en",

  };

  Future<NewOrdersModel?> getOpenedOrder(int page) async {
    // Json Data
    String token = await _getUserToken();
    var _response = await dio.get("https://worldapp.site/api/driver/orders/opened?page=$page",
        options: Options(
          headers: {
            ...apiHeaders,
            'Authorization':  '$token',
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ));

    // print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
    // print("${_response.data}");

    if (ServerConstants.isValidResponse(_response.statusCode!)) {
      // OK
      // if (!ServerConstants.isValidResponse(
      //     int.parse(_response.data[0]))) {
      //   throw ApiException.fromApi(_response.statusCode!, _response.data);
      // }

      newOrders = NewOrdersModel.fromJson(_response.data);
      return newOrders;
      //  return UserModel.fromJson(_response.body);
    } else {
      // DioErrorType type;
      // No Success
      // print(
      //     'ApiException....login***********************************************************');

      // // print(_response.request.uri.data);
      // print('...................................................');

      throw ApiException.fromApi(_response.statusCode!, _response.data);
    }
  }
  Future<NewOrdersModel?> getClosedOrder(int page) async {
    // Json Data
    String token = await _getUserToken();
    var _response = await dio.get("${ServerConstants.GetCloseOrder}?page=$page",
        options: Options(
          headers: {
            ...apiHeaders,
            'Authorization':  '$token',
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ));

    // print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
    // print("${_response.data}");

    if (ServerConstants.isValidResponse(_response.statusCode!)) {
      // OK
      // if (!ServerConstants.isValidResponse(
      //     int.parse(_response.data[0]))) {
      //   throw ApiException.fromApi(_response.statusCode!, _response.data);
      // }

      newOrders = NewOrdersModel.fromJson(_response.data);
      return newOrders;
      //  return UserModel.fromJson(_response.body);
    } else {
      // DioErrorType type;
      // No Success
      // print(
      //     'ApiException....login***********************************************************');

      // // print(_response.request.uri.data);
      // print('...................................................');

      //throw ApiException.fromApi(_response.statusCode!, _response.data);
    }
  }
  Future<NewOrdersModel?> getNewOrder(int page) async {
    // Json Data
    String token = await _getUserToken();
    var _response = await dio.get("https://worldapp.site/api/driver/orders/new?page=$page",
        options: Options(
          headers: {
            ...apiHeaders,
            'Authorization':  '$token',
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ));

    // print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
    // print("${_response.data}");

    if (ServerConstants.isValidResponse(_response.statusCode!)) {
      // OK
      // if (!ServerConstants.isValidResponse(
      //     int.parse(_response.data[0]))) {
      //   throw ApiException.fromApi(_response.statusCode!, _response.data);
      // }

      newOrders = NewOrdersModel.fromJson(_response.data);
      return newOrders;
      //  return UserModel.fromJson(_response.body);
    } else {
      // DioErrorType type;
      // No Success
      // print(
      //     'ApiException....login***********************************************************');

      // // print(_response.request.uri.data);
      // print('...................................................');

      throw ApiException.fromApi(_response.statusCode!, _response.data);
    }
  }
  Future<OrderDetailsModel?> getOrderDetails(int? id, String ?lang) async {
    // Json Data
    String token = await _getUserToken();
    var _response = await dio.get("https://worldapp.site/api/driver/order/$id",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Content-Language": lang,
            'Authorization':  '$token',
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ));

    // print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
    // print("${_response.data}");

    if (ServerConstants.isValidResponse(_response.statusCode!)) {
      // OK
      // if (!ServerConstants.isValidResponse(
      //     int.parse(_response.data[0]))) {
      //   throw ApiException.fromApi(_response.statusCode!, _response.data);
      // }

      details = OrderDetailsModel.fromJson(_response.data);
      return details;
      //  return UserModel.fromJson(_response.body);
    } else {
      // DioErrorType type;
      // No Success
      // print(
      //     'ApiException....ditails***********************************************************');

      // // print(_response.request.uri.data);
      // print('...................................................');

      throw ApiException.fromApi(_response.statusCode!, _response.data);
    }
  }
  Future<NewOrdersModel?> acceptOrder(int? orderId) async {
    // Json Data
    var _data = {
      "order_id": "$orderId",
    };
    // Http Request
    String token = await _getUserToken();
    var _response = await dio.post(ServerConstants.AcceptOrder,
        data: _data,
        options: Options(

          headers: {
            ...apiHeaders,
            'Authorization':  '$token',
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ));

    // print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
    // print("${_response.data}");

    if (ServerConstants.isValidResponse(_response.statusCode!)) {
      // OK
      // if (!ServerConstants.isValidResponse(
      //     int.parse(_response.data[0]))) {
      //   throw ApiException.fromApi(_response.statusCode!, _response.data);
      // }

      newOrders = NewOrdersModel.fromJson(_response.data);
      return newOrders;
      //  return UserModel.fromJson(_response.body);
    } else {
      // DioErrorType type;
      // No Success

      // // print(_response.request.uri.data);
      // print('...................................................');

      throw ApiException.fromApi(_response.statusCode!, _response.data);
    }
  }
  Future<void> deliveredOrder(int ?id) async {
    // Http Request
    String token = await _getUserToken();
    var _response = await dio.get("https://worldapp.site/api/driver/deliver/order/$id",
        options: Options(
          headers: {
            ...apiHeaders,
            'Authorization':  '$token',
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ));

    // print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
    // print("${_response.data}");

    if (ServerConstants.isValidResponse(_response.statusCode!)) {

    } else {
      // DioErrorType type;
      // No Success

      // // print(_response.request.uri.data);
      // print('...................................................');

      //throw ApiException.fromApi(_response.statusCode!, _response.data);
    }
  }
  Future<void> failedOrder(int? orderId, String note) async {
    var _data = {
      "notes": "$note",
    };
    // Http Request
    String token = await _getUserToken();
    var _response = await dio.post("https://worldapp.site/api/driver/failed/order/$orderId",
        data: _data,
        options: Options(
          headers: {
            ...apiHeaders,
            'Authorization':  '$token',
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ));

    // print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
    // print("${_response.data}");

    if (ServerConstants.isValidResponse(_response.statusCode!)) {
      // OK
      // if (!ServerConstants.isValidResponse(
      //     int.parse(_response.data[0]))) {
      //   throw ApiException.fromApi(_response.statusCode!, _response.data);
      // }

      //openedOrders = OpenedOrders.fromJson(_response.data);
    //  return openedOrders;
      //  return UserModel.fromJson(_response.body);
    } else {
      // DioErrorType type;
      // No Success

      // // print(_response.request.uri.data);
      // print('...................................................');

      throw ApiException.fromApi(_response.statusCode!, _response.data);
    }
  }
  Future<void> rate(int ?orderId, double rate, String comment) async {
    // Json Data
    var _data = {
      "order_id": "$orderId",
      "rate": "$rate",
      "comment": "$comment",
    };
    // Http Request

    String token = await _getUserToken();
    var _response = await dio.post(ServerConstants.Rate,
        data: _data,
        options: Options(
          headers: {
            ...apiHeaders,
            'Authorization':  '$token',
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ));

    // print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
    // print("${_response.data}");

    if (ServerConstants.isValidResponse(_response.statusCode!)) {
      // OK
      // if (!ServerConstants.isValidResponse(
      //     int.parse(_response.data[0]))) {
      //   throw ApiException.fromApi(_response.statusCode!, _response.data);
      // }

   //   openedOrders = OpenedOrders.fromJson(_response.data);
   //   return openedOrders;
      //  return UserModel.fromJson(_response.body);
    } else {
      // DioErrorType type;
      // No Success

      // // print(_response.request.uri.data);
      // print('...................................................');

      throw ApiException.fromApi(_response.statusCode!, _response.data);
    }
  }
  Future<void> refuseOrder(int ?orderId, String? comment) async {
    // Json Data
    var _data = {
      "order_id": "$orderId",
      "notes": "$comment",
    };
    // Http Request

    String token = await _getUserToken();
    var _response = await dio.post(ServerConstants.RefuseOrder,
        data: _data,
        options: Options(
          headers: {
            ...apiHeaders,
            'Authorization':  '$token',
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ));

    // print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
    // print("${_response.data}");

    if (ServerConstants.isValidResponse(_response.statusCode!)) {
      // OK
      // if (!ServerConstants.isValidResponse(
      //     int.parse(_response.data[0]))) {
      //   throw ApiException.fromApi(_response.statusCode!, _response.data);
      // }

      //   openedOrders = OpenedOrders.fromJson(_response.data);
      //   return openedOrders;
      //  return UserModel.fromJson(_response.body);
    } else {
      // DioErrorType type;
      // No Success

      // // print(_response.request.uri.data);
      // print('...................................................');

      throw ApiException.fromApi(_response.statusCode!, _response.data);
    }
  }
  Future<void> changeStatus() async {
    // Http Request
    String token = await _getUserToken();
    var _response = await dio.get("https://worldapp.site/api/driver/change_status",
        options: Options(
          headers: {
            ...apiHeaders,
            'Authorization':  '$token',
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ));

    // print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
    // print("${_response.data}");

    if (ServerConstants.isValidResponse(_response.statusCode!)) {

    } else {
      // DioErrorType type;
      // No Success

      // // print(_response.request.uri.data);
      // print('...................................................');
      throw ApiException.fromApi(_response.statusCode!, _response.data);
    }
  }


}
Future<String> _getUserToken() async {
  // print('_getUserToken()');
  UserModel user = UserModel();
  // print('UserModel');
  String? userToken = await user.getToken;
  // print(userToken);
  if (userToken == null) throw "User Not Logged In";
  return userToken;
}
Future<String> _getUserLang() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? lang = prefs.getString('lang');
  // print(lang);
  if (lang == null) throw "User Not Logged In";
  return lang;
}
