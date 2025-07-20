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
    fetchStudentData('');
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

    final now = DateTime.now();
    if (lastScanTime != null && now.difference(lastScanTime!) < scanCooldown) {
      return;
    }
    lastScanTime = now;
    result.value = scanData;

    pauseCamera();
    isScanning.value = false;

    scannedValue.value = scanData.code!;
    log("Scanned QR Code: ${scannedValue.value}");

    // Show snackbar
    Get.snackbar(
      'QR Code Scanned',
      scannedValue.value,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.TOP,
    );

    // ✅ Fetch student data using scanned value
    await fetchStudentData(scannedValue.value);

    // ✅ After fetching, navigate to profile screen
    if (studentProfile.value != null) {
      Get.offAllNamed(
        AppRoutes.profilePage,
        arguments: {'profile': studentProfile.value},
      );
    } else {
      Get.snackbar("Error", "Student not found");
      resumeScanning();
    }
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

  Future<void> fetchStudentData(String applicationNo) async {
    print("--------------->applicationNo $applicationNo");

    final payLoad = {"application_no": applicationNo.toString()};

    print(payLoad);
    final response = await apiService.postApi('profile', payLoad);

    print("-----------------------------> ${response}");

    try {
      isLoading.value = true;

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
}
