import 'package:get/get.dart';
import 'package:swagatham/Authentication/binding/auth_binding.dart';
import 'package:swagatham/Authentication/view/login_page.dart';
import 'package:swagatham/Pages/HomePage/binding/home_binding.dart';
import 'package:swagatham/Pages/HomePage/view/home_page.dart';
import 'package:swagatham/Pages/InstructionPage/binding/instruction_binding.dart';
import 'package:swagatham/Pages/InstructionPage/view/instruction_page.dart';
import 'package:swagatham/Pages/ProfilePage/view/profile_page.dart';
import 'package:swagatham/Pages/QrPage/view/qr_page.dart';
import 'package:swagatham/Pages/SplashPage/binding/splash_binding.dart';
import 'package:swagatham/Pages/SplashPage/view/splash_page.dart';
import 'package:swagatham/routes/app_routes.dart';

class AppPage {
  static List<GetPage> pages = [
    GetPage(
      name: AppRoutes.homePage,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(name: AppRoutes.qrPage, page: () => QrPage()),
    GetPage(name: AppRoutes.profilePage, page: () => ProfilePage()),
    GetPage(
      name: AppRoutes.loginPage,
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.splashPage,
      page: () => SplashPage(),

      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.instructionPage,
      page: () => InstructionPage(),
      binding: InstructionBinding(),
    ),
  ];
}
