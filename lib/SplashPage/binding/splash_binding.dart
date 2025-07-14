import 'package:get/get.dart';
import 'package:swagatham/SplashPage/controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(SplashController());
  }

}