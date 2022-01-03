import 'package:dilivery_app/models/delivered_order.dart';
import 'package:dilivery_app/models/new_order_model.dart';
import 'package:dilivery_app/models/notification_model.dart';
import 'package:dilivery_app/models/opened_orders_model.dart';
import 'package:dilivery_app/models/order_details.dart';
import 'package:dilivery_app/models/user_model.dart';
import 'package:dilivery_app/provider/auth_provider.dart';
import 'package:dilivery_app/screens/home/Taps/new_orders.dart';
import 'package:dilivery_app/servise/auth_service.dart';
import 'package:dilivery_app/servise/vars.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_exceptions.dart';


class ApiNotification {
  ApiNotification._();

  static final ApiNotification instance = ApiNotification._();
  static NotificationModel? notificationModel;


  var dio = Dio()
    ..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));

  //
  static Map<String, String> apiHeaders = {
    "Content-Type": "application/json",
    "X-Requested-With": "XMLHttpRequest",
    "Content-Language": "ar",
  };

  Future<NotificationModel?> getNotification(int page) async {
    // Json Data
    String token = await _getUserToken();
    var _response = await dio.get("https://worldapp.site/api/driver/notifications?page=$page",
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

      notificationModel = NotificationModel.fromJson(_response.data);
      return notificationModel;
      //  return UserModel.fromJson(_response.body);
    } else {
      // DioErrorType type;
      // No Success
      // print(
      //     'ApiException....not***********************************************************');

      // // print(_response.request.uri.data);
      // print('...................................................');

      //throw ApiException.fromApi(_response.statusCode!, _response.data);
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
