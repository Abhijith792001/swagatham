import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:dio/dio.dart' as appDio;
import 'package:get/get.dart';
import 'package:swagatham/Pages/ProfilePage/model/student_model.dart';
import 'package:swagatham/routes/app_routes.dart';
import 'package:swagatham/service/api_service.dart';
import 'package:swagatham/utils/storage_manger.dart';

class ProfileController extends GetxController {
  final userData = User().obs;

  Rx<Uint8List?> profileImg = Rx<Uint8List?>(null);

  RxBool isLoading = false.obs;
  RxString successMessage = ''.obs;
  RxString userRole = ''.obs;

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
  void onInit() {
    // TODO: implement onInit
    super.onInit();
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

    final payload = {"application_no": applicationNo, "role": userRole.value};

    try {
      final appDio.Response response = await apiService.postApi(
        'verify',
        payload,
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        successMessage.value = "$_role Verified";

      } else {
        Get.snackbar("Failed", "Verification failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void backToHome() {
    Get.offAllNamed(AppRoutes.homePage);
    log("Cleared profile data");
  }
}
