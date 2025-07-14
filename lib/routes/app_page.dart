import 'package:get/get.dart';
import 'package:swagatham/Authentication/view/login_page.dart';
import 'package:swagatham/HomePage/view/home_page.dart';
import 'package:swagatham/ProfilePage/view/profile_page.dart';
import 'package:swagatham/QrPage/view/qr_page.dart';
import 'package:swagatham/SplashPage/binding/splash_binding.dart';
import 'package:swagatham/SplashPage/view/splash_page.dart';
import 'package:swagatham/routes/app_routes.dart';

class AppPage {
  static List<GetPage> pages = [
    GetPage(name: AppRoutes.homePage, page: () => HomePage()),
    GetPage(name: AppRoutes.qrPage, page: () => QrPage()),
    GetPage(name: AppRoutes.profilePage, page: () => ProfilePage()),
    GetPage(name: AppRoutes.loginPage, page: () => LoginPage()),
    GetPage(
      name: AppRoutes.splashPage,
      page: () => SplashPage(),

      binding: SplashBinding(),
    ),
  ];
}
