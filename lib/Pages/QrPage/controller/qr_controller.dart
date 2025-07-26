import 'dart:developer';
import 'package:get/get.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:swagatham/Pages/ProfilePage/model/student_model.dart';
import 'package:swagatham/routes/app_routes.dart';
import 'package:swagatham/service/api_service.dart';
import 'package:swagatham/utils/storage_manger.dart';
import 'package:dio/dio.dart' as appDio;
import 'package:permission_handler/permission_handler.dart';

class QrController extends GetxController {
  final scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
  );

  Rx<User?> userData = Rx<User?>(null);
  RxString scannedValue = ''.obs;
  RxBool isScanning = true.obs;
  RxBool isLoading = false.obs;
  RxString successMessage = ''.obs;
  RxString userRole = ''.obs;

  final ApiService apiService = ApiService();
  final StorageManger appStorage = StorageManger();

  /// Handles scan result from AiBarcodeScanner
  Future<void> onCodeDetected(BarcodeCapture capture) async {
    // Step 1: Check Camera Permission
    var cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      final result = await Permission.camera.request();
      if (!result.isGranted) {
        Get.snackbar(
          "Permission Denied",
          "Camera permission is required to scan QR",
        );
        return;
      }
    }

    // Step 2: Continue if permission granted
    final code = capture.barcodes.firstOrNull?.rawValue;

    if (code == null || !isScanning.value) return;

    scannedValue.value = code;
    isScanning.value = false;

    log("Scanned: $code");

    await fetchStudentData(code);

    if (userData.value != null) {
      if (Get.context != null) {
        Get.offNamed(
          AppRoutes.profilePage,
          arguments: {'studentProfileData': userData.value},
        );
      }
    } else {
      Get.snackbar("Error", "Student not found");
      await Future.delayed(const Duration(seconds: 2));
      isScanning.value = true;
    }
  }

  /// Fetches student profile by application number
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
    userData.value = null;
    Get.offAllNamed(AppRoutes.homePage);
    log("Cleared profile data");
  }

  @override
  void onClose() {
    scannerController.dispose();
    super.onClose();
  }
}
