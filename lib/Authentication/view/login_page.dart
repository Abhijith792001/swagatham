import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:swagatham/routes/app_routes.dart';
import 'package:swagatham/theme/app_theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1, -1),
            end: Alignment(.1, 0),
            colors: [const Color(0xFFFFBFD2), Color.fromRGBO(241, 242, 237, 1)],
          ),
        ),
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 30.h),
              width: Get.width,
              child: SvgPicture.asset(
                'assets/images/amrita_logo.svg',
                width: 140.w,
              ),
            ),
            Text(
              "Welcome Back",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
            ),
            Text('Enter your details below', style: TextStyle(fontSize: 12.sp)),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.only(left: 20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.sp)),
                border: Border.all(color: Colors.black45),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Username',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.only(left: 20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.sp)),
                border: Border.all(color: Colors.black45),
              ),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            InkWell(
              onTap: () => {
                Get.offAllNamed(AppRoutes.homePage)
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                  gradient: AppTheme.primaryGradient
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
