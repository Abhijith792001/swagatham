import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:swagatham/service/common_interceptors.dart';

class ApiService {
  static const String baseUrl = 'https://mobile-api.amrita.ac.in/swagatham/';
  final Map<String, String> headers = {
    "X-API-KEY": '5c8522e3b4674e8ea767c5dbabb127a6',
    // "Content-Type": "application/json",
    // "Accept": "application/json",
  };

  late final Dio dio;

  ApiService() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));
    dio.interceptors.add(CustomInterceptors(headers: headers));
  }

  Future<Response> postApi(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await dio.post(
        endpoint,
        data: data,
        options: Options(
          responseType: ResponseType.json,
        ),
      );

      // Ensure response data is properly parsed
      if (response.data is String) {
        response.data = _parseResponse(response.data);
      }

      print("API Success: ${response.data}");
      return response;
    } on DioException catch (e) {
      print("API Error: ${e.message}");
      if (e.response != null) {
        print("Error Response: ${e.response?.data}");
      }
      rethrow;
    }
  }

  dynamic _parseResponse(String response) {
    try {
      return jsonDecode(response);
    } catch (e) {
      print("Failed to parse response: $e");
      return response;
    }
  }
}