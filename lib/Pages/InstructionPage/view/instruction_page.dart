import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:swagatham/Pages/InstructionPage/controller/instruction_controller.dart';
import 'package:swagatham/routes/app_routes.dart';

class InstructionPage extends GetView<InstructionController> {
  const InstructionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.offNamed(AppRoutes.homePage);
          },
          child: Icon(LucideIcons.chevronLeft),
        ),
        title: const Text('Instructions'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.fetchInstruction,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.errorMessage.value,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.fetchInstruction,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final instructions = controller.instructionData.value;
        if (instructions == null) {
          return const Center(child: Text('No instructions available'));
        }

        return RefreshIndicator(
          onRefresh: () async => controller.fetchInstruction(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Last updated: ${instructions.time}',
                  style: Get.textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Html(
                      data: instructions.instructions.instructions,
                      style: {
                        "body": Style(
                          fontSize: FontSize(16.0),
                          lineHeight: LineHeight(1.5),
                        ),
                        "h3": Style(
                          color: Get.theme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        "p": Style(margin: Margins.only(bottom: 10)),
                        "li": Style(margin: Margins.only(bottom: 8)),
                        "hr": Style(
                          margin: Margins.symmetric(vertical: 16),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
