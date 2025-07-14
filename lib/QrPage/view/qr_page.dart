import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import '../controller/qr_controller.dart';

class QrPage extends StatelessWidget {
  QrPage({super.key});

  final QrController controller = Get.put(QrController());

  @override
  Widget build(BuildContext context) {
    // Handle reassemble manually
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Platform.isAndroid) {
        controller.pauseCamera();
      }
      controller.resumeCamera();
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(LucideIcons.x, color: Colors.white),
        ),
        actions: [
          Obx(() => InkWell(
                onTap: controller.toggleFlash,
                child: Icon(
                  controller.isSelected.value
                      ? LucideIcons.flashlightOff
                      : LucideIcons.flashlight,
                  color: Colors.white,
                ),
              )),
          SizedBox(width: 15.w),
          const Icon(LucideIcons.ellipsisVertical, color: Colors.white),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(flex: 4, child: _buildQrView(context)),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 70.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.sp),
                  topRight: Radius.circular(30.sp),
                ),
                gradient: const LinearGradient(
                  begin: Alignment(0.00, 0.50),
                  end: Alignment(1.00, 0.50),
                  colors: [Color(0xFFA4123F), Color(0xFFFC5286)],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Scan QR code to get student',
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Quickly and get your student.',
                    style: TextStyle(fontSize: 10.sp, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    final scanArea =
        (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400)
            ? 150.0
            : 300.0;

    return QRView(
      key: controller.qrKey,
      onQRViewCreated: controller.onQRViewCreated,
      onPermissionSet: (ctrl, p) => controller.onPermissionSet(context, p),
      overlay: QrScannerOverlayShape(
        borderColor: const Color(0xffa4123f),
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 15,
        cutOutSize: scanArea,
      ),
    );
  }
}
