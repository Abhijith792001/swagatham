import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:swagatham/Pages/QrPage/model/student_model.dart';
import 'package:swagatham/routes/app_routes.dart';
import 'package:swagatham/service/api_service.dart';
import 'package:swagatham/utils/storage_manger.dart';
import 'package:dio/dio.dart' as appDio;

class QrController extends GetxController {
  QRViewController? qrController;
  Rx<Barcode?> result = Rx<Barcode?>(null);
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Rx<ProfileInfo?> studentProfile = Rx<ProfileInfo?>(null);

  StorageManger appStorage = StorageManger();
  ApiService apiService = ApiService();

  RxBool isSelected = false.obs;
  RxBool isScanning = true.obs;
  RxBool isLoading = false.obs;
  RxBool success = false.obs;

  RxString scanedValue = ''.obs;
  RxString successMessage = ''.obs;
  RxString userRole = ''.obs;

  // Add debouncing to prevent multiple scans
  DateTime? lastScanTime;
  static const scanCooldown = Duration(milliseconds: 500);

  @override
  void onInit() {
    super.onInit();
  }

  void onQRViewCreated(QRViewController controller) {
    qrController = controller;

    // Configure scanner for better performance
    _configureScanner();

    qrController!.scannedDataStream.listen((scanData) {
      _handleScanData(scanData);
    });
  }

  void _configureScanner() {
    // Set scan area to reduce processing (optional)
    // qrController?.updateScanArea(Rect.fromLTWH(50, 50, 200, 200));

    // You can also set format filters to scan only QR codes
    // qrController?.updateScanArea(formats: [BarcodeFormat.qrcode]);
  }

  void _handleScanData(Barcode? scanData) async {
    if (scanData == null || scanData.code == null) return;

    // Implement debouncing
    final now = DateTime.now();
    if (lastScanTime != null && now.difference(lastScanTime!) < scanCooldown) {
      return;
    }

    lastScanTime = now;
    result.value = scanData;

    // Pause scanning temporarily
    pauseCamera();
    isScanning.value = false;

    scanedValue.value = scanData.code.toString();

    // Wait for API call to complete
    await fetchStudentData(scanedValue.value);

    if (studentProfile.value != null) {
      // Only navigate if we have valid profile data
      Get.offNamed(AppRoutes.profilePage);
    } else {
      // Resume scanning if API failed or no data
      Get.snackbar(
        'Error',
        'Failed to fetch student data. Please try again.',
        duration: const Duration(seconds: 2),
      );

      // Auto-resume scanning after showing error
      Future.delayed(const Duration(seconds: 2), () {
        resumeScanning();
      });
    }

    log("QR Code: ${scanData.code}");
  }

  void resumeScanning() {
    resumeCamera();
    isScanning.value = true;
    result.value = null; // Clear previous result
    lastScanTime = null;
  }

  void onPermissionSet(BuildContext context, bool permission) {
    log('Permission granted: $permission');
    if (!permission) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Camera permission denied')));
    }
  }

  Future toggleFlash() async {
    try {
      await qrController?.toggleFlash();
      isSelected.value = !isSelected.value;
      update();
    } catch (e) {
      log('Error toggling flash: $e');
    }
  }

  Future flipCamera() async {
    try {
      await qrController?.flipCamera();
      update();
    } catch (e) {
      log('Error flipping camera: $e');
    }
  }

  Future<bool?> getFlashStatus() async {
    try {
      return await qrController?.getFlashStatus();
    } catch (e) {
      log('Error getting flash status: $e');
      return null;
    }
  }

  Future<CameraFacing?> getCameraInfo() async {
    try {
      return await qrController?.getCameraInfo();
    } catch (e) {
      log('Error getting camera info: $e');
      return null;
    }
  }

  Future pauseCamera() async {
    try {
      await qrController?.pauseCamera();
    } catch (e) {
      log('Error pausing camera: $e');
    }
  }

  Future resumeCamera() async {
    try {
      await qrController?.resumeCamera();
    } catch (e) {
      log('Error resuming camera: $e');
    }
  }

  @override
  void onClose() {
    qrController?.dispose();
    super.onClose();
  }

  // Api Side

  Future<void> fetchStudentData(String applicationNo) async {
    print("--------------->applicationNo $applicationNo");

    try {
      isLoading.value = true;
      final payLoad = {"application_no": "1001003334"};
      final appDio.Response response = await apiService.postApi(
        'profile',
        payLoad,
      );

      print(response);
      if (response.statusCode == 200) {
        final studentModel = StudentModel.fromJson(response.data);
        final profile = studentModel.user?.profileInfo;
        if (profile != null) {
          studentProfile.value = profile;
          print("---------------------> ${studentProfile.value}");
        } else {
          print('Check your API: Profile is null');
        }
      } else {
        Get.snackbar(
          "Failed",
          response.data["error"] ?? "Something went wrong",
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Check your API: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markUs(String applicationNo) async {
    isLoading.value = false;
    final _role = await appStorage.read('role');
    switch (_role) {
      case 'Gate':
        userRole.value = "1";
      case 'Teacher':
        userRole.value = "2";
      case 'Warden':
        userRole.value = "3";
        break;
    }
    final payLoad = {"application_no": applicationNo, "role": userRole.value};
    try {
      appDio.Response response = await apiService.postApi('verify', payLoad);

      if (response.statusCode == 200 && response.data['success'] == true) {
        successMessage.value = "${_role} Verified";
      }
    } catch (e) {
      Get.snackbar('Error', "${e.toString()}");
    }
  }
}
