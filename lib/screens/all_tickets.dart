import 'dart:convert';

import 'package:flights_app/components/bottom_bar.dart';
import 'package:flights_app/components/ticket_tile.dart';
import 'package:flights_app/constants.dart';
import 'package:flights_app/screens/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AllTickets extends StatefulWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;
  final String currentDate;
  const AllTickets({
    super.key,
    required this.controller1,
    required this.controller2,
    required this.currentDate,
  });

  @override
  State<AllTickets> createState() => _AllTicketsState();
}

class _AllTicketsState extends State<AllTickets> {
  List _items = [];

  @override
  Widget build(BuildContext context) {
    readJson();
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Container(
              width: width,
              height: 56.h,
              decoration: const BoxDecoration(color: grey8),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset('assets/icons/arrow.svg')),
                    SizedBox(width: 10.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.controller2.text}-${widget.controller1.text}',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: white),
                        ),
                        Text(
                          '${widget.currentDate}, 1 пассажир',
                          style: TextStyle(color: grey6),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 18.h),
                  height: 650.h,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      return TicketTile(
                        badge: _items[index]['badge'],
                        price: _items[index]['price']['value'],
                        departureAirport: _items[index]['departure']['airport'],
                        arrivalAirport: _items[index]['arrival']['airport'],
                        departureDate:
                            DateTime.parse(_items[index]['departure']['date']),
                        arrivalDate:
                            DateTime.parse(_items[index]['arrival']['date']),
                        hasTransfer: _items[index]['has_transfer'],
                      );
                    },
                  ),
                ),
                Positioned(
                  left: 90.w,
                  bottom: 0,
                  child: Container(
                    height: 37.h,
                    width: 203.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.r), color: blue),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset('assets/icons/filter.svg'),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                'Фильтр',
                                style: TextStyle(
                                    color: white, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset('assets/icons/graph.svg'),
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                'График цен',
                                style: TextStyle(
                                    color: white, fontWeight: FontWeight.w500),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )),
      bottomNavigationBar: CustomBottomBar(
          onItemTapped: (value) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomBar(selectedPage: value),
                ));
          },
          selectedIndex: 0),
    );
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/tickets.json');
    final data = await jsonDecode(response);
    setState(() {
      _items = data["tickets"];
    });
  }
}
