import 'package:flutter/material.dart';
import 'package:flights_app/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MyContainer extends StatelessWidget {
  final double width;
  final String title1;
  final String? title2;
  final String? icon;
  final Function()? onTap;
  const MyContainer(
      {super.key,
      required this.width,
      required this.title1,
      this.title2,
      this.icon,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 4.h),
        width: width,
        decoration: BoxDecoration(
          color: grey5,
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (icon != null) SvgPicture.asset('assets/icons/$icon.svg'),
            Text(
              title1,
              style: TextStyle(fontSize: 14.sp, color: white),
            ),
            if (title2 != null)
              Text(title2!, style: TextStyle(fontSize: 14.sp, color: grey6))
          ],
        ),
      ),
    );
  }
}
