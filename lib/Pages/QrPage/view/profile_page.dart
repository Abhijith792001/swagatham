import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:swagatham/Pages/QrPage/controller/qr_controller.dart';
import 'package:swagatham/routes/app_routes.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final controller = Get.put(QrController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Color(0xffa4123f),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft, color: Colors.white),
          onPressed: () => Get.offAllNamed(AppRoutes.homePage),
        ),
        title: Text(
          'Student Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        final profile= controller.studentProfile.value;
        return Column(
          children: [
            SizedBox(height: 10.h),
            Center(
              child: CircleAvatar(
                radius: 45.r,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: const NetworkImage(
                  'https://abhijithjeejamon.netlify.app/assets/img/abhi.jpg',
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              profile?.stdNm?.toString() ?? '',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            Text(
              controller.scannedValue.value.toString(),
              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Replace old tiles inside Column(children: [...]) in body with this updated section
                    SectionTitle(title: 'Profile Details'),
                    // MiniInfoTile(
                    //   icon: LucideIcons.user,
                    //   title: 'Name',
                    //   value: 'Abhijith J',
                    // ),
                    MiniInfoTile(
                      icon: LucideIcons.bookOpen,
                      title: 'Course',
                      value: 'BCA (2023 – 2026)',
                    ),
                    MiniInfoTile(
                      icon: LucideIcons.badgeIndianRupee,
                      title: 'CAN Number',
                      value: '24508545HFKHF',
                    ),
                    MiniInfoTile(
                      icon: LucideIcons.userCheck,
                      title: 'Hosteller/Day Scholar',
                      value: 'Hosteller',
                    ),
                    MiniStatusTile(
                      icon: LucideIcons.calendarCheck2,
                      title: 'Hostel Arrival Date',
                      date: '15/07/2025',
                      status: 'IN', // or 'OUT'
                    ),
                    MiniInfoTile(
                      icon: LucideIcons.bedDouble,
                      title: 'Hostel Room Number',
                      value: 'G12',
                    ),
                    MiniInfoTile(
                      icon: LucideIcons.building2,
                      title: 'Building Name',
                      value: 'B-Block',
                    ),
                    MiniStatusTile(
                      icon: LucideIcons.calendarDays,
                      title: 'Campus Arrival Date',
                      date: '15/07/2025',
                      status: 'IN',
                    ),
                    MiniStatusTile(
                      icon: LucideIcons.fileCheck2,
                      title: 'Document',
                      date: '15/07/2025',
                      status: 'OUT',
                    ),
                    MiniInfoTile(
                      icon: LucideIcons.mapPin,
                      title: 'Location',
                      value: 'Amrita Campus',
                    ),

                    SizedBox(height: 20.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // controller.fetchStudentData("1001003334");
                          }, // You can add your function here
                          child: Container(
                            width: 0.7.sw,
                            padding: EdgeInsets.symmetric(
                              vertical: 12.h,
                              horizontal: 20.w,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xffd4145a), Color(0xffa4123f)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(18.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  LucideIcons.circleCheck,
                                  size: 20.sp,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Mark Us In',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, top: 10.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class MiniInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const MiniInfoTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Icon(icon, size: 16.sp, color: Colors.black54),
          SizedBox(width: 10.w),
          Text(
            "$title: ",
            style: TextStyle(fontSize: 13.sp, color: Colors.black87),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 13.sp, color: Colors.grey[700]),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class MiniStatusTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String date;
  final String status;

  const MiniStatusTile({
    super.key,
    required this.icon,
    required this.title,
    required this.date,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor =
        status.toUpperCase() == 'IN' ? Colors.green : Colors.red;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Icon(icon, size: 16.sp, color: Colors.black54),
          SizedBox(width: 10.w),
          Text(
            "$title: ",
            style: TextStyle(fontSize: 13.sp, color: Colors.black87),
          ),
          Expanded(
            child: Row(
              children: [
                Text(
                  date,
                  style: TextStyle(fontSize: 13.sp, color: Colors.grey[700]),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    border: Border.all(color: statusColor),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    status.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
