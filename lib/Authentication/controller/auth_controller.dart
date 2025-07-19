import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as appDio;
import 'package:swagatham/routes/app_routes.dart';
import 'package:swagatham/service/api_service.dart';
import 'package:swagatham/utils/storage_manger.dart';

class AuthController {
  ApiService apiService = ApiService();
  StorageManger appStorage = StorageManger();

  RxString currentUser = ''.obs;
  RxBool isLoading = false.obs;


  login(String email, String password) async {
    final payLoad = {'login_name': email, 'password': password};
    try {
      isLoading.value = true;
      appDio.Response response = await apiService.postApi('login', payLoad);
      if (response.statusCode == 200) {
        appStorage.write('isLoggedIn', true);
        Get.offAllNamed(AppRoutes.homePage);
        print("---------------> login done ${response}");
        Get.snackbar(
          'Success',
          'Login Succesfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green[600],
        );
      } else {
        print('Check your mail and password');
      }
    } catch (e) {
      Get.snackbar('Error', 'Api is error ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}
