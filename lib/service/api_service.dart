import 'package:dio/dio.dart';
import 'package:swagatham/service/common_interceptors.dart';

class ApiService {
  var headers = {"X-API-KEY": '5c8522e3b4674e8ea767c5dbabb127a6'};

  late Dio dio;

  ApiService() {
    dio = Dio();
    dio.interceptors.add(CustomInterceptors(headers: headers));
  }

  postApi(String value, Map<String, dynamic> data) async {
    try {
      Response response = await dio.post(
        'https://mobile-api.amrita.ac.in/swagatham/$value',
        data: data,
      );
      print("Successfully $response");
      return response;
    } catch (e) {
      print("-----------> api error ${e.toString()}");
    }
  }
}
