import 'dart:developer';
import 'package:get/get.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:swagatham/routes/app_routes.dart';
import 'package:swagatham/service/api_service.dart';
import 'package:swagatham/utils/storage_manger.dart';
import 'package:swagatham/Pages/QrPage/model/student_model.dart';
import 'package:dio/dio.dart' as appDio;

class QrController extends GetxController {
  final scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
  );

  Rx<ProfileInfo?> studentProfile = Rx<ProfileInfo?>(null);
  RxString scannedValue = ''.obs;
  RxBool isScanning = true.obs;
  RxBool isLoading = false.obs;
  RxString successMessage = ''.obs;
  RxString userRole = ''.obs;

  final ApiService apiService = ApiService();
  final StorageManger appStorage = StorageManger();

  /// Handles scan result from AiBarcodeScanner
  Future<void> onCodeDetected(BarcodeCapture capture) async {
    final code = capture.barcodes.firstOrNull?.rawValue;

    if (code == null || !isScanning.value) return;

    scannedValue.value = code;
    isScanning.value = false;

    log("Scanned: $code");

    await fetchStudentData(code);

    if (studentProfile.value != null) {
      if (Get.context != null) {
        Get.offNamed(AppRoutes.profilePage);
      }
    } else {
      Get.snackbar("Error", "Student not found");
      await Future.delayed(const Duration(seconds: 2));
      isScanning.value = true;
    }
  }

  /// Fetches student profile by application number
  Future<void> fetchStudentData(String applicationNo) async {
    log("Fetching student data for: $applicationNo");
    final payload = {"application_no": applicationNo};

    try {
      isLoading.value = true;

      final appDio.Response response = await apiService.postApi('profile', payload);

      print("responseresponseresponseresponseresponseresponse ${response}");

      if (response.statusCode == 200) {
        final studentModel = StudentModel.fromJson(response.data);
        final profile = studentModel.user?.profileInfo;



        if (profile != null) {
          studentProfile.value = profile;
          log("Fetched profile: ${studentProfile.value}");
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

    final payload = {
      "application_no": applicationNo,
      "role": userRole.value,
    };

    try {
      final appDio.Response response = await apiService.postApi('verify', payload);

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
    studentProfile.value = null;
    Get.offAllNamed(AppRoutes.homePage);
    log("Cleared profile data");
  }

  @override
  void onClose() {
    scannerController.dispose();
    super.onClose();
  }
}
