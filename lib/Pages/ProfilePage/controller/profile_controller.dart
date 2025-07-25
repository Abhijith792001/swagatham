import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as appDIo;
import 'package:get/get.dart';
import 'package:swagatham/Pages/ProfilePage/model/student_model.dart';
import 'package:swagatham/routes/app_routes.dart';

class ProfileController extends GetxController {
  final userData = User().obs;

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    userData.value = await Get.arguments['studentProfileData'];
    print("profile data ${jsonEncode(userData.value)}");
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  getStudentImg() async{

  }



  void backToHome() {
    Get.offAllNamed(AppRoutes.homePage);
    log("Cleared profile data");
  }
}
