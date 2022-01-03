
import 'package:dilivery_app/models/slider_model.dart';
import 'package:dilivery_app/servise/vars.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';



class ApiSlider {
  ApiSlider._();

  static final ApiSlider instance = ApiSlider._();
  static SliderModel? slider;


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

  Future<SliderModel?> getSlider() async {
    // Json Data
    var _response = await dio.get(ServerConstants.Slider,
        options: Options(
          headers: {
            ...apiHeaders,
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

      slider = SliderModel.fromJson(_response.data);
      return slider;
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

