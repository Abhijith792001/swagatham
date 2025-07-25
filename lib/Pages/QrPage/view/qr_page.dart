import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import '../controller/qr_controller.dart';

class QrPage extends StatelessWidget {
  QrPage({super.key});

  final controller = Get.put(QrController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Scan QR Code"),
        backgroundColor: Colors.transparent,
      ),
      body: AiBarcodeScanner(
        
        controller: controller.scannerController,
        onDetect: controller.onCodeDetected,
        onScan: (_) {}, // Required but not used
      ),
    );
  }
}
