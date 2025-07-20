import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as appDio;
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:swagatham/Pages/QrPage/model/student_model.dart';
import 'package:swagatham/routes/app_routes.dart';
import 'package:swagatham/service/api_service.dart';
import 'package:swagatham/utils/storage_manger.dart';

class QrController extends GetxController {
  QRViewController? qrController;
  Rx<Barcode?> result = Rx<Barcode?>(null);
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Rx<ProfileInfo?> studentProfile = Rx<ProfileInfo?>(null);

  ApiService apiService = ApiService();
  StorageManger appStorage = StorageManger();

  RxBool isSelected = false.obs;
  RxBool isScanning = true.obs;
  RxBool isLoading = false.obs;
  RxString scannedValue = ''.obs;

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

  void _handleScanData(Barcode? scanData) {
    if (scanData == null || scanData.code == null) return;

    // Implement debouncing to prevent rapid consecutive scans
    final now = DateTime.now();
    if (lastScanTime != null && now.difference(lastScanTime!) < scanCooldown) {
      return;
    }

    lastScanTime = now;
    result.value = scanData;

    // Pause scanning temporarily to prevent continuous scanning
    pauseCamera();
    isScanning.value = false;

    // Show result
    Get.snackbar(
      'QR Code Scanned',
      scanData.code.toString(),
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.TOP,
    );

    if (scanData.code != null) {
      Get.offAllNamed(
        arguments: {'scanData': scanData.code},
        AppRoutes.profilePage,
      );
    } else {
      Get.offAllNamed(AppRoutes.homePage);
      Get.snackbar('Error', 'Try Again');
    }

    log("QR Code: ${scanData.code}");

    // Auto-resume scanning after 2 seconds (optional)
    Future.delayed(const Duration(seconds: 2), () {
      if (!isScanning.value) {
        resumeScanning();
      }
    });
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

  Future<void> toggleFlash() async {
    try {
      await qrController?.toggleFlash();
      isSelected.value = !isSelected.value;
      update();
    } catch (e) {
      log('Error toggling flash: $e');
    }
  }

  Future<void> flipCamera() async {
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

  Future<void> pauseCamera() async {
    try {
      await qrController?.pauseCamera();
    } catch (e) {
      log('Error pausing camera: $e');
    }
  }

  Future<void> resumeCamera() async {
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

  fetchStudentData(String applicationNo) async {
    // final payLoad = {"application_no": "1001003334"};

    print("--------------->applicationNo ${applicationNo}");

    try {
      isLoading.value = true;

      appDio.Response response = await apiService.postApi('profile',  {"application_no": "1001003334"});
      if (response.statusCode == 200 && response.data["success"] == true) {
        final studentModel = StudentModel.fromJson(response.data);
        final profile = studentModel.user?.profileInfo;

        if(profile != null){
          studentProfile.value = profile;
          print(studentProfile.value);

        }else{
          print('Check your api');
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Cheack your api ${e.toString()}');
    }
  }
}
