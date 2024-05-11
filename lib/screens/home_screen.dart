import 'dart:convert';

import 'package:flights_app/constants.dart';
import 'package:flights_app/models/title_model.dart';
import 'package:flights_app/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  String _savedText = '';
  List _items = [];

  @override
  void initState() {
    super.initState();
    _loadSavedText();
  }

  Future<void> _loadSavedText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedText = prefs.getString('text') ?? '';
      _controller.text = _savedText;
    });
  }

  Future<void> _saveText(String text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('text', text);
  }

  @override
  Widget build(BuildContext context) {
    readJson();
    return Column(
      children: [
        Container(
          width: 200.w,
          margin: EdgeInsets.only(top: 80.h, bottom: 40.h),
          child: Text(
            'Поиск дешевых авиабилетов',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Container(
                height: 140.h,
                decoration: BoxDecoration(
                    color: grey4, borderRadius: BorderRadius.circular(16.r)),
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  decoration: BoxDecoration(
                      color: grey5, borderRadius: BorderRadius.circular(16.r)),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: SvgPicture.asset('assets/icons/search.svg'),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20.h,
                            width: 250.w,
                            child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp('[а-яА-Я]+'),
                                ),
                              ],
                              controller: _controller,
                              onChanged: (text) {
                                _saveText(text);
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 14.h),
                                  hintStyle: TextStyle(
                                      color: Colors.white, fontSize: 14.sp),
                                  hintText: 'Откуда - Москва',
                                  border: InputBorder.none),
                            ),
                          ),
                          SizedBox(
                            width: 280.w,
                            child: Divider(
                              color: grey6,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                            width: 250.w,
                            child: Consumer<TitleModel>(
                              builder: (context, value, _) {
                                return TextField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp('[а-яА-Я]+'),
                                    ),
                                  ],
                                  onTap: () {
                                    Provider.of<TitleModel>(context,
                                            listen: false)
                                        .updateTitle1(_savedText);
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.92,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: SearchScreen(
                                              controller: _controller),
                                        );
                                      },
                                    );
                                  },
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.sp),
                                  decoration: InputDecoration(
                                      hintText: 'Куда - Турция',
                                      contentPadding:
                                          EdgeInsets.only(bottom: 10.h),
                                      hintStyle: TextStyle(color: grey6),
                                      border: InputBorder.none),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30.h),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Музыкально отлететь',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 213.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _items.length,
                  separatorBuilder: (context, _) => SizedBox(width: 16.w),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 133.16.h,
                          width: 132.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: Image.asset(
                              'assets/images/$index.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          _items[index]['title'],
                          style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp),
                        ),
                        SizedBox(height: 5.h),
                        Text(_items[index]['town'],
                            style: TextStyle(color: grey7, fontSize: 14.sp)),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/plane.svg'),
                            SizedBox(width: 5.w),
                            Text('от ${_items[index]['price']['value']} ₽',
                                style:
                                    TextStyle(color: grey7, fontSize: 14.sp)),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/offers.json');
    final data = await jsonDecode(response);
    setState(() {
      _items = data["offers"];
    });
  }
}
