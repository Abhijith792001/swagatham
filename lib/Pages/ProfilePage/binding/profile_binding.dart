import 'package:get/get.dart';
import 'package:swagatham/Pages/ProfilePage/controller/profile_controller.dart';
import 'package:swagatham/service/api_service.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
      Get.put(ApiService());
    Get.put(ProfileController());
  }
}
