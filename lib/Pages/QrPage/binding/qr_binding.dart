import 'package:get/get.dart';
import 'package:swagatham/Pages/QrPage/controller/qr_controller.dart';
import 'package:swagatham/service/api_service.dart';

class QrBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
        Get.lazyPut(() => ApiService(), fenix: true);
    Get.lazyPut(() => QrController(), fenix: true);
  }

  
}