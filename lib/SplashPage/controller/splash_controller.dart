import 'package:get/get.dart';
import 'package:swagatham/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // splashScreen();
  }

  Future<void> splashScreen() async {
    Future.delayed(Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.loginPage);
    });
  }
}
