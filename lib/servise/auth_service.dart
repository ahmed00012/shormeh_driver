import 'package:dilivery_app/models/change_status.dart';
import 'package:dilivery_app/models/user_model.dart';
import 'package:dilivery_app/servise/vars.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_exceptions.dart';


class AuthService {
  AuthService._();

  static final AuthService instance = AuthService._();
  static UserModel? user;
  static StatusModel ?status;

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
    "Content-Language": "en",
  };

  Future<UserModel?> login(String phone, String password, String deviceId,String? lang) async {
    // Json Data
    var _data = {
      "phone": "$phone",
      "password": "$password",
      "device_id": "$deviceId"
    };
    //('login start');
    // Http Request

    var _response = await dio.post(ServerConstants.Login,
        data: _data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "Content-Language": lang,
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ));

    //("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
    //("${_response.data}");

    if (ServerConstants.isValidResponse(_response.statusCode!)) {
      // OK
      // if (!ServerConstants.isValidResponse(
      //     int.parse(_response.data[0]))) {
      //   throw ApiException.fromApi(_response.statusCode!, _response.data);
      // }
    //  //(user!.accessToken);
   //   user!.saveToken(user!.accessToken);
   //    SharedPreferences prefs = await SharedPreferences.getInstance();
   //    prefs?.setBool("isLoggedIn", true);
      user = UserModel.fromJson(_response.data);
      return user;


      //  return UserModel.fromJson(_response.body);
    } else {
      // DioErrorType type;
      // No Success


      // //(_response.request.uri.data);
      //('...................................................');

      throw ApiException.fromApi(_response.statusCode!, _response.data);
    }
  }
  Future<void> logOut() async {
    // Json Data
    String token = await _getUserToken();
    var _response = await dio.post(ServerConstants.Logout,

        options: Options(
          headers: {
            ...apiHeaders,
            'Authorization':  '$token',
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ));

    //("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
    //("${_response.data}");

    if (ServerConstants.isValidResponse(_response.statusCode!)) {
      // OK
      // if (!ServerConstants.isValidResponse(
      //     int.parse(_response.data[0]))) {
      //   throw ApiException.fromApi(_response.statusCode!, _response.data);
      // }
      //  //(user!.accessToken);
      //   user!.saveToken(user!.accessToken);
      //    SharedPreferences prefs = await SharedPreferences.getInstance();
      //    prefs?.setBool("isLoggedIn", true);
      // user = UserModel.fromJson(_response.data);
      // return user;


      //  return UserModel.fromJson(_response.body);
    } else {
      // DioErrorType type;
      // No Success


      // //(_response.request.uri.data);
      //('...................................................');

      throw ApiException.fromApi(_response.statusCode!, _response.data);
    }
  }
  Future<void> changePass(String oldPassword, String newPassword) async {
    // Json Data
    var _data = {
      "old_password": "$oldPassword",
      "new_password": "$newPassword",
    };
    // Json Data
    String token = await _getUserToken();
    var _response = await dio.post(ServerConstants.ChangePass,
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

    //("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
    //("${_response.data}");

    if (ServerConstants.isValidResponse(_response.statusCode!)) {
      // OK
      // if (!ServerConstants.isValidResponse(
      //     int.parse(_response.data[0]))) {
      //   throw ApiException.fromApi(_response.statusCode!, _response.data);
      // }
      //  //(user!.accessToken);
      //   user!.saveToken(user!.accessToken);
      //    SharedPreferences prefs = await SharedPreferences.getInstance();
      //    prefs?.setBool("isLoggedIn", true);
      // user = UserModel.fromJson(_response.data);
      // return user;


      //  return UserModel.fromJson(_response.body);
    } else {
      // DioErrorType type;
      // No Success

      // //(_response.request.uri.data);
      //('...................................................');

      throw ApiException.fromApi(_response.statusCode!, _response.data);
    }
  }
  Future<StatusModel?> changeStatus() async {
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

    //("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
    //("${_response.data}");

    if (ServerConstants.isValidResponse(_response.statusCode!)) {
      status = StatusModel.fromJson(_response.data);
      return status;

    } else {
      // DioErrorType type;
      // No Success


      // //(_response.request.uri.data);
      //('...................................................');

      throw ApiException.fromApi(_response.statusCode!, _response.data);
    }
  }



}
Future<String> _getUserToken() async {
  //('_getUserToken()');
  UserModel user = UserModel();
  //('UserModel');
  ////(AuthService.user!.accessToken);

  String? userToken =  await user.getToken;
  //(userToken);
  if (userToken == null) throw "User Not Logged In";
  return userToken;
}
