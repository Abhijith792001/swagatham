import 'package:get/get.dart';
import 'package:swagatham/Pages/InstructionPage/controller/instruction_controller.dart';
import 'package:swagatham/service/api_service.dart';

class InstructionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService(), fenix: true);
    Get.lazyPut(() => InstructionController(), fenix: true);
  }
}