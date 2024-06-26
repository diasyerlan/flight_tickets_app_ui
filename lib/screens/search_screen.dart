// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flights_app/components/card.dart';
import 'package:flights_app/components/rectangle.dart';
import 'package:flights_app/models/title_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flights_app/constants.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController controller;
  const SearchScreen({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TitleModel>(
      builder: (context, data, _) {
        return Column(
          children: [
            SizedBox(height: 18.h),
            Container(
              height: 115.h,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              decoration: BoxDecoration(
                color: grey4,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2.r,
                    blurRadius: 3.r,
                    offset: Offset(0.w, 3.h),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.h,
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/plane1.svg'),
                          SizedBox(width: 10.w),
                          SizedBox(
                            width: 200.w,
                            child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp('[а-яА-Я]+'),
                                ),
                              ],
                              controller: controller,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 12.h),
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  hintText: 'Откуда - Москва',
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 7.h),
                      child: Divider(
                        color: grey6,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset('assets/icons/search.svg'),
                              SizedBox(width: 10.w),
                              SizedBox(
                                width: 200.w,
                                child: TextField(
                                  controller: data.controller,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp('[а-яА-Я]+'),
                                    ),
                                  ],
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      hintText: 'Куда - Турция',
                                      contentPadding:
                                          EdgeInsets.only(bottom: 12.h),
                                      hintStyle: TextStyle(color: grey6),
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 12.w),
                            child: GestureDetector(
                                onTap: () {
                                  data.controller.clear();
                                },
                                child:
                                    SvgPicture.asset('assets/icons/union.svg')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Rectangle(
                      color: green, icon: 'route', title: 'Сложный маршрут'),
                  Rectangle(color: blue, icon: 'globe', title: 'Куда угодно'),
                  Rectangle(
                      color: darkBlue1, icon: 'calendar', title: 'Выходные'),
                  Rectangle(color: red, icon: 'fire', title: 'Горячие билеты')
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              height: 290.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2.r,
                  blurRadius: 3.r,
                  offset: Offset(0.w, 3.h),
                ),
              ], color: grey4, borderRadius: BorderRadius.circular(16.r)),
              child: Column(
                children: [
                  SizedBox(height: 16.h),
                  const MyCard(
                      image: 'stambul',
                      title: 'Стамбул',
                      subTitle: 'Популярное направление'),
                  const MyCard(
                      image: 'sochi',
                      title: 'Сочи',
                      subTitle: 'Популярное направление'),
                  const MyCard(
                      image: 'phuket',
                      title: 'Пхукет',
                      subTitle: 'Популярное направление'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
