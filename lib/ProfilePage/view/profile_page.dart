import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:swagatham/routes/app_routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => {Get.offAllNamed(AppRoutes.homePage)},
          child: Icon(LucideIcons.chevronLeft, color: Colors.white),
        ),
        backgroundColor: Color(0xffa4123f),
        title: Text('Profile Page', style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100.h,
                decoration: BoxDecoration(color: Color(0xffa4123f)),
              ),
              SizedBox(height: 45.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        'Abhijith J',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '24508545HFKHF',
                        style: TextStyle(
                          fontSize: 13.33.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.sp),
                child: Text(
                  'Personal Details',
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Positioned(
            top: 30.h,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 4),
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(
                  'https://abhijithjeejamon.netlify.app/assets/img/abhi.jpg',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
