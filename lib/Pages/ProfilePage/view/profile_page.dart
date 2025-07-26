import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:swagatham/Pages/ProfilePage/controller/profile_controller.dart';
import 'package:intl/intl.dart';
import 'package:swagatham/routes/app_routes.dart';
import 'package:swagatham/theme/app_theme.dart';
import 'package:swagatham/widgets/primary_btn.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Get.offAllNamed(AppRoutes.homePage);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Color(0xffa4123f),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(LucideIcons.chevronLeft, color: Colors.white),
            onPressed: () => controller.backToHome(),
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
          final profile = controller.userData.value.profileInfo;
          final canDetails = controller.userData.value.canInfo;
      
          return Column(
            children: [
              SizedBox(height: 10.h),
              Center(
                child: CircleAvatar(
                  radius: 50.r,
                  backgroundColor: Colors.white,
                  child:
                      controller.profileImg.value != null
                          ? ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                            child: Image(
                              image: MemoryImage(
                                controller.profileImg.value!,
                                scale: 1,
                              ),
                              width: 160.w, // your desired width
                              height: 160.h, // your desired height
                              fit:
                                  BoxFit
                                      .cover, // optional: how the image should be fitted
                            ),
                          )
                          : Image(
                            image: NetworkImage(
                              "https://www.shutterstock.com/image-vector/vector-flat-illustration-grayscale-avatar-600nw-2264922221.jpg",
                            ),
                          ),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                profile?.stdNm?.toString() ?? 'Not Defined',
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
              ),
              Text(
                profile?.applicationNo?.toString() ?? 'Not Defined',
                style: TextStyle(fontSize: 12.5.sp, color: Colors.grey),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SectionTitle(title: 'Profile Details'),
                      // MiniInfoTile(
                      //   icon: LucideIcons.user,
                      //   title: 'Name',
                      //   value: 'Abhijith J',
                      // ),
                      // MiniInfoTile(
                      //   icon: LucideIcons.bookOpen,
                      //   title: 'Course',
                      //   value: profile?.pgmNm?.toString() ?? "",
                      // ),
                      // MiniInfoTile(
                      //   icon: LucideIcons.badgeIndianRupee,
                      //   title: 'CAN Number',
                      //   value: canDetails?.canNumber?.toString() ?? '',
                      // ),
                      // MiniInfoTile(
                      //   icon: LucideIcons.userCheck,
                      //   title: 'Hosteller/Day Scholar',
                      //   value:
                      //       controller.userData.value.hostelInfo == null
                      //           ? 'Day Scholar'
                      //           : 'Hosteler',
                      // ),
                      // controller.userData.value.hostelInfo == null
                      //     ? Container()
                      //     : Column(
                      //       children: [
                      //         MiniStatusTile(
                      //           icon: LucideIcons.calendarCheck2,
                      //           title: 'Hostel Arrival Date',
                      //           date:
                      //               controller.userData.value.hostelInfo == null
                      //                   ? "Not Joined"
                      //                   : DateFormat('dd/MM/yyyy').format(
                      //                     DateTime.parse(
                      //                       controller
                      //                           .userData
                      //                           .value
                      //                           .hostelInfo!
                      //                           .hostelOn
                      //                           .toString(),
                      //                     ),
                      //                   ),
      
                      //           status:
                      //               controller.userData.value.hostelInfo == null
                      //                   ? null
                      //                   : "IN",
      
                      //           statusColor: Colors.green, // or 'OUT'
                      //         ),
                      //         MiniInfoTile(
                      //           icon: LucideIcons.bedDouble,
                      //           title: 'Hostel Room Number',
                      //           value: 'G12',
                      //         ),
                      //         MiniInfoTile(
                      //           icon: LucideIcons.building2,
                      //           title: 'Building Name',
                      //           value: 'B-Block',
                      //         ),
                      //       ],
                      //     ),
                      // MiniStatusTile(
                      //   icon: LucideIcons.calendarDays,
                      //   title: 'Campus Arrival Date',
                      //   date:
                      //       controller.userData.value.addditionalInfo == null
                      //           ? "Not Joined"
                      //           : DateFormat('dd/MM/yyyy').format(
                      //             DateTime.parse(
                      //               controller
                      //                   .userData
                      //                   .value
                      //                   .addditionalInfo!
                      //                   .campusArrivalDate
                      //                   .toString(),
                      //             ),
                      //           ),
                      //   status:
                      //       controller.userData.value.hostelInfo == null
                      //           ? 'IN'
                      //           : null,
                      //   statusColor: Colors.green,
                      // ),
                      // (controller.userRole.value == '3' &&
                      //         controller.userData.value.hostelInfo != null)
                      //     ? MiniStatusTile(
                      //       icon: LucideIcons.fileCheck2,
                      //       title: 'Hostel Status',
                      //       date: '',
                      //       status:
                      //           controller
                      //               .userData
                      //               .value
                      //               .addditionalInfo
                      //               ?.hostelCheckStatus ??
                      //           'Pending',
                      //       statusColor:
                      //           controller
                      //                       .userData
                      //                       .value
                      //                       .addditionalInfo
                      //                       ?.hostelCheckStatus ==
                      //                   'Verified'
                      //               ? Colors.green
                      //               : Colors.red,
                      //     )
                      //     : const SizedBox.shrink(),
      
                      // controller.userRole.value == '2'
                      //     ? MiniStatusTile(
                      //       icon: LucideIcons.fileCheck2,
                      //       title: 'Document Status',
                      //       date: '',
                      //       status:
                      //           controller
                      //               .userData
                      //               .value
                      //               .addditionalInfo
                      //               ?.documentVerifyStatus
                      //               .toString() ??
                      //           'Pending',
                      //       statusColor:
                      //           controller
                      //                       .userData
                      //                       .value
                      //                       .addditionalInfo
                      //                       ?.documentVerifyStatus
                      //                       ?.toString() ==
                      //                   'Verified'
                      //               ? Colors.green
                      //               : Colors.red,
                      //     )
                      //     : Container(),
                      // controller.userRole.value == '1'
                      //     ? MiniStatusTile(
                      //       icon: LucideIcons.fileCheck2,
                      //       title: 'Gate Status',
                      //       date: '',
                      //       status:
                      //           controller
                      //               .userData
                      //               .value
                      //               .addditionalInfo
                      //               ?.gateVerifyStatus
                      //               .toString() ??
                      //           'Pending',
                      //       statusColor:
                      //           controller
                      //                       .userData
                      //                       .value
                      //                       .addditionalInfo
                      //                       ?.gateVerifyStatus
                      //                       ?.toString() ==
                      //                   'Verified'
                      //               ? Colors.green
                      //               : Colors.red,
                      //     )
                      //     : Container(),
                      // MiniInfoTile(
                      //   icon: LucideIcons.mapPin,
                      //   title: 'Location',
                      //   value: 'Coimbatore campus',
                      // ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // borderRadius: BorderRadius.circular(12),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.black12,
                          //     blurRadius: 4,
                          //     offset: Offset(0, 2),
                          //   ),
                          // ],
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Html(
                              data:
                                  controller.userData.value.html ??
                                  '<p>No content available.</p>',
                              style: {
                                "body": Style(
                                  fontSize: FontSize(16.0),
                                  lineHeight: LineHeight(1.5),
                                ),
                                "h3": Style(
                                  color: Get.theme.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                "p": Style(margin: Margins.only(bottom: 10)),
                                "li": Style(margin: Margins.only(bottom: 8)),
                                "hr": Style(
                                  margin: Margins.symmetric(vertical: 16),
                                  border: Border.all(color: Colors.grey.shade300),
                                ),
                              },
                            ),
                            //       (controller.userRole.value == '3' &&
                            //         controller.userData.value.hostelInfo != null)
                            //     ? MiniStatusTile(
                            //       // icon: LucideIcons.fileCheck2,
                            //       title: 'Hostel Status',
                            //       date: '',
                            //       status:
                            //           controller
                            //               .userData
                            //               .value
                            //               .addditionalInfo
                            //               ?.hostelCheckStatus ??
                            //           'Pending',
                            //       statusColor:
                            //           controller
                            //                       .userData
                            //                       .value
                            //                       .addditionalInfo
                            //                       ?.hostelCheckStatus ==
                            //                   'Verified'
                            //               ? Colors.green
                            //               : Colors.red,
                            //     )
                            //     : const SizedBox.shrink(),
      
                            // controller.userRole.value == '2'
                            //     ? MiniStatusTile(
                            //       title: 'Document Status',
                            //       date: '',
                            //       status:
                            //           controller
                            //               .userData
                            //               .value
                            //               .addditionalInfo
                            //               ?.documentVerifyStatus
                            //               .toString() ??
                            //           'Pending',
                            //       statusColor:
                            //           controller
                            //                       .userData
                            //                       .value
                            //                       .addditionalInfo
                            //                       ?.documentVerifyStatus
                            //                       ?.toString() ==
                            //                   'Verified'
                            //               ? Colors.green
                            //               : Colors.red,
                            //     )
                            //     : Container(),
                            // controller.userRole.value == '1'
                            //     ? MiniStatusTile(
                            //       title: 'Gate Status',
                            //       date: '',
                            //       status:
                            //           controller
                            //               .userData
                            //               .value
                            //               .addditionalInfo
                            //               ?.gateVerifyStatus
                            //               .toString() ??
                            //           'Pending',
                            //       statusColor:
                            //           controller
                            //                       .userData
                            //                       .value
                            //                       .addditionalInfo
                            //                       ?.gateVerifyStatus
                            //                       ?.toString() ==
                            //                   'Verified'
                            //               ? Colors.green
                            //               : Colors.red,
                            //     )
                            //     : Container(),
                          ],
                        ),
                      ),
      
                      SizedBox(height: 20.h),
      
                      (controller.userData.value.hostelInfo == null &&
                              controller.userRole.value == '3')
                          ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text('')],
                          )
                          : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.markUs(
                                    profile?.applicationNo?.toString() ?? '',
                                  );
                                }, // You can add your function here
                                child: Container(
                                  width: 0.7.sw,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 12.h,
                                    horizontal: 20.w,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xffd4145a),
                                        Color(0xffa4123f),
                                      ],
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
                                        'Mark as in',
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
      
                      SizedBox(height: 10.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.clearUserData();
                              Get.offAllNamed(AppRoutes.qrPage);
                            },
                            child: Chip(
                              backgroundColor: Colors.grey.shade100,
                              avatar: Icon(Icons.qr_code, size: 18),
                              label: Text('Scan Again'),
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
      ),
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
  final String title;
  final String value;

  const MiniInfoTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          // Icon(icon, size: 16.sp, color: Colors.black54),
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
  final String title;
  final String date;
  final String? status;
  final Color statusColor;

  const MiniStatusTile({
    super.key,
    required this.title,
    required this.date,
    required this.statusColor,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    // Color statusColor =
    //     status.toUpperCase() == 'IN' ? Colors.green : Colors.red;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          // this.icon,
          // Icon(icon, size: 16.sp, color: Colors.black54),
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
                status != null
                    ? Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: statusColor.withOpacity(0.1),
                        border: Border.all(color: statusColor),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        status!,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
