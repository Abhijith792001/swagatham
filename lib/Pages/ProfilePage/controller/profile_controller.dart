import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:typed_data';
import 'package:dio/dio.dart' as appDio;
import 'package:get/get.dart';
import 'package:swagatham/Pages/ProfilePage/model/student_model.dart';
import 'package:swagatham/Pages/QrPage/controller/qr_controller.dart';
import 'package:swagatham/routes/app_routes.dart';
import 'package:swagatham/service/api_service.dart';
import 'package:swagatham/utils/storage_manger.dart';

class ProfileController extends GetxController {
  final userData = User().obs;

  Rx<Uint8List?> profileImg = Rx<Uint8List?>(null);

  RxBool isLoading = false.obs;
  RxString successMessage = ''.obs;
  RxString userRole = ''.obs;
  RxBool scanAgain = false.obs;

  final ApiService apiService = ApiService();
  final StorageManger appStorage = StorageManger();

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    userData.value = await Get.arguments['studentProfileData'];
    print("profile data img${jsonEncode(userData.value)}");
    getStudentImg();
  }

  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
     final _role = await appStorage.read('role');

    switch (_role) {
      case 'Gate':
        userRole.value = "1";
        break;
      case 'Teacher':
        userRole.value = "2";
        break;
      case 'Warden':
        userRole.value = "3";
        break;
    }
  }

  getStudentImg() async {
    appDio.Dio dio = appDio.Dio();

    final headers = {"X-API-KEY": '5c8522e3b4674e8ea767c5dbabb127a6'};

    appDio.Response response = await dio.post(
      'https://swagatham.amrita.edu/pdf/profpic_classroom_swagatham_new.php?app_no=${userData.value.profileInfo?.applicationNo.toString()}',
      options: appDio.Options(
        headers: headers,
        responseType: appDio.ResponseType.bytes,
      ),
    );

    profileImg.value = await Uint8List.fromList(response.data);
  }

  /// Used in ProfilePage to mark user presence
  Future<void> markUs(String applicationNo) async {
    // print("_role.runtimeType_role.runtimeType_role.runtimeType_role.runtimeType ${}");

    // final _role = await appStorage.read('role');
    // switch (_role) {
    //   case 'Gate':
    //     userRole.value = "1";
    //     break;
    //   case 'Teacher':
    //     userRole.value = "2";
    //     break;
    //   case 'Warden':
    //     userRole.value = "3";
    //     break;
    // }



    print("userRole is =--------------------> ${userRole.value.toString()}");

    final roleNumber = userRole.value.toString();

    final payload = {"application_no": applicationNo, "role":roleNumber};
    print(payload);

    try {
      final appDio.Response response = await apiService.postApi(
        'verify',
        payload,
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        scanAgain.value = true;
        // successMessage.value = "$_role Verified";
        fetchStudentData(applicationNo);
        // log('$_role Verified');
        Get.snackbar(
          "Success",
          "Verification Success",
          backgroundColor: const Color.fromARGB(50, 200, 230, 201),
          borderColor: Colors.green,
          borderWidth: 1.5, // Optional: Set border width if using borderColor
          snackPosition: SnackPosition.TOP, // Optional: can be BOTTOM
          colorText: Colors.black, // Optional: customize text color
        );
      } else {
        Get.snackbar("Failed", "Verification failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> fetchStudentData(String applicationNo) async {
    final _role = await appStorage.read('role');
    switch (_role) {
      case 'Gate':
        userRole.value = "1";
        break;
      case 'Teacher':
        userRole.value = "2";
        break;
      case 'Warden':
        userRole.value = "3";
        break;
    }
    log("Fetching student data for: $applicationNo");
    final payload = {"application_no": applicationNo, "role": userRole.value};

    try {
      isLoading.value = true;

      final appDio.Response response = await apiService.postApi(
        'profile',
        payload,
      );

      print(
        "responseresponseresponseresponseresponseresponse ${response.data}",
      );

      if (response.statusCode == 200) {
        print('${response.statusCode}');
        final studentModel = StudentModel.fromJson(response.data);
        final profile = studentModel.user;

        if (profile != null) {
          userData.value = profile;
          log("Fetched profile: ${userData.value}");
        } else {
          Get.snackbar("Error", "Profile data is empty");
        }
      } else {
        Get.snackbar("Error", response.data["error"] ?? "API failed");
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void backToHome() {
    clearUserData();
    Get.offAllNamed(AppRoutes.homePage);
    log("Cleared profile data");
  }

  void clearUserData(){
    userData.value = User();
  }
}
