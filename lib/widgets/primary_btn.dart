import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class PrimaryBtn extends StatelessWidget {
  const PrimaryBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width*0.8,
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(color: Color(0xffa4123f),
      borderRadius: BorderRadius.all(Radius.circular(16))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LucideIcons.qrCode,color: Colors.white,),
          SizedBox(width: 10.w,),
          Text(
            'Scan',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              
            ),
            

          ),
        ],
      ),
    );
  }
}
