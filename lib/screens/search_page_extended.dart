import 'dart:convert';

import 'package:flights_app/components/bottom_bar.dart';
import 'package:flights_app/components/container.dart';
import 'package:flights_app/constants.dart';
import 'package:flights_app/screens/all_tickets.dart';
import 'package:flights_app/screens/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class SearchExtended extends StatefulWidget {
  TextEditingController controller1;
  TextEditingController controller2;
  DateTime _dateTime = DateTime.now();
  SearchExtended({
    super.key,
    required this.controller1,
    required this.controller2,
  });

  @override
  State<SearchExtended> createState() => _SearchExtendedState();
}

class _SearchExtendedState extends State<SearchExtended> {
  List _items = [];
  final List _colors = [red, blue, white];
  bool isSwitched = false;
  String formatDate(DateTime dateTime) {
    final dateFormat = DateFormat('d MMM', 'ru');
    return dateFormat.format(dateTime);
  }

  String formatDateByDay(DateTime dateTime) {
    final dateFormat = DateFormat('E', 'ru');
    return dateFormat.format(dateTime);
  }

  void _showDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));
  }

  void _showAndChooseDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2030))
        .then((value) => setState(() {
              widget._dateTime = value!;
            }));
  }

  @override
  Widget build(BuildContext context) {
    readJson();
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Container(
              height: 112.h,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              decoration: BoxDecoration(
                  color: grey4, borderRadius: BorderRadius.circular(16.r)),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(
                          'assets/icons/arrow.svg',
                          height: 25.h,
                        )),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 10.w),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.69,
                            height: 20.h,
                            child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp('[а-яА-Я]+'),
                                ),
                              ],
                              controller: widget.controller2,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 14.h),
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  hintText: 'Откуда - Москва',
                                  border: InputBorder.none),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  TextEditingController test =
                                      widget.controller1;
                                  widget.controller1 = widget.controller2;
                                  widget.controller2 = test;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: SvgPicture.asset(
                                    'assets/icons/replace.svg'),
                              )),
                        ],
                      ),
                      SizedBox(
                        width: 320.w,
                        child: Divider(
                          color: grey5,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.69,
                              height: 20.h,
                              child: TextField(
                                controller: widget.controller1,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp('[а-яА-Я]+'),
                                  ),
                                ],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                    hintText: 'Куда - Турция',
                                    contentPadding:
                                        EdgeInsets.only(bottom: 9.h),
                                    hintStyle: TextStyle(color: grey6),
                                    border: InputBorder.none),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 18.w),
                              child: GestureDetector(
                                  onTap: () {
                                    widget.controller2.clear();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: SvgPicture.asset(
                                        'assets/icons/union.svg'),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  MyContainer(
                    icon: 'plus',
                    title1: 'обратно',
                    width: 110,
                    onTap: _showDatePicker,
                  ),
                  MyContainer(
                    title1: formatDate(widget._dateTime),
                    title2: formatDateByDay(widget._dateTime),
                    width: 100,
                    onTap: _showAndChooseDatePicker,
                  ),
                  const MyContainer(
                    icon: 'profile',
                    title1: '1, эконом',
                    width: 125,
                  ),
                  const MyContainer(
                    icon: 'filter',
                    title1: 'фильтр',
                    width: 90,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: grey1, borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: width,
              height: 340,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Прямые рельсы',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 240,
                      child: ListView.builder(
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 36,
                                width: 36,
                                decoration: BoxDecoration(
                                    color: _colors[index],
                                    shape: BoxShape.circle),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 7),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            _items[index]["title"],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${_items[index]["price"]["value"]} ₽',
                                                style: TextStyle(color: blue),
                                              ),
                                              Icon(
                                                Icons.keyboard_arrow_right,
                                                color: blue,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: _items[index]["time_range"]
                                            .map<Widget>((time) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(time,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    const Divider()
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Показать все',
                        style: TextStyle(color: blue, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllTickets(
                            controller1: widget.controller1,
                            controller2: widget.controller2,
                            currentDate: formatDate(widget._dateTime),
                          )), // Navigate to AnotherPage
                );
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 50,
                width: width,
                decoration: BoxDecoration(
                    color: blue, borderRadius: BorderRadius.circular(8)),
                child: Center(
                    child: Text(
                  'Посмотреть все билеты',
                  style: TextStyle(
                      color: white, fontSize: 16, fontWeight: FontWeight.w600),
                )),
              ),
            ),
            SizedBox(height: 10.h,),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 60.h,
              width: width,
              decoration: BoxDecoration(
                  color: grey8, borderRadius: BorderRadius.circular(8)),
              child: SwitchListTile(
                title: Text(
                  'Подписка на цену',
                  style: TextStyle(
                      fontSize: 16, color: white, fontWeight: FontWeight.w500),
                ),
                secondary: Icon(
                  Icons.notifications,
                  color: blue,
                ),
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
        onItemTapped: (int selectedPage) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BottomBar(selectedPage: selectedPage),
            ),
          );
        },
        selectedIndex: 0,
      ),
    );
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/offers_tickets.json');
    final data = await jsonDecode(response);
    setState(() {
      _items = data["tickets_offers"];
    });
  }
}
