// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flights_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Rectangle extends StatelessWidget {
  final Color color;
  final String icon;
  final String title;
  const Rectangle({
    super.key,
    required this.color,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 60.h,
            width: 60.w,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(8.r)),
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
                child: SvgPicture.asset('assets/icons/$icon.svg'))),
        SizedBox(
          height: 5.h,
        ),
        SizedBox(
          width: 100.w,
          height: 70.h,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: white, fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
