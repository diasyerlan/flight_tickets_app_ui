import 'package:flights_app/constants.dart';
import 'package:flights_app/models/title_model.dart';
import 'package:flights_app/screens/search_page_extended.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyCard extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  const MyCard({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TitleModel>(
      builder: (context, value, _) {
        return GestureDetector(
          onTap: () {
            Provider.of<TitleModel>(context, listen: false).updateTitle(title);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchExtended(
                        controller1: value.controller,
                        controller2: value.controller1,
                      )), // Navigate to AnotherPage
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                          fit: BoxFit.cover,
                          height: 50.h,
                          width: 50.w,
                          'assets/images/$image.png'),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          subTitle,
                          style: TextStyle(fontSize: 14.sp, color: grey9),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 3.h,),
                Divider(
                  color: grey9,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
