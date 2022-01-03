import 'package:dilivery_app/models/distance_model.dart';
import 'package:dilivery_app/models/opened_orders_model.dart';
import 'package:dilivery_app/models/user_model.dart';
import 'package:dilivery_app/servise/auth_service.dart';
import 'package:dilivery_app/servise/vars.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';



class ApiLocation {
  ApiLocation._();

  static final ApiLocation instance = ApiLocation._();
  static DistanceModel? distanceModel;

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


  Future<void> sendLocation(String ?lat,String ?lng) async {
    // Json Data
    var _data = {
      "lat": "$lat",
      "long": "$lng",
    };
    // Http Request

    String token = await _getUserToken();
    var _response = await dio.post(ServerConstants.SendLoc,
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

      //distanceModel = DistanceModel.fromJson(_response.data);
     // return distanceModel;
      //  return UserModel.fromJson(_response.body);
    } else {
      // DioErrorType type;
      // No Success

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
  // // print(AuthService.user!.accessToken);

  String? userToken = await user.getToken;
  // print(userToken);
  if (userToken == null) throw "User Not Logged In";
  return userToken;
}
