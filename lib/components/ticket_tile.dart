import 'package:flights_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TicketTile extends StatelessWidget {
  final String? badge;
  final int price;
  final DateTime departureDate;
  final DateTime arrivalDate;
  final String departureAirport;
  final String arrivalAirport;
  final bool hasTransfer;
  const TicketTile({
    super.key,
    this.badge,
    required this.price,
    required this.departureDate,
    required this.arrivalDate,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.hasTransfer,
  });

  @override
  Widget build(BuildContext context) {
    double timeDiff = double.parse(
        (arrivalDate.difference(departureDate).inMinutes / 60)
            .toStringAsFixed(1));
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 120.h,
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r), color: grey8),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 22.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$price ₽',
                    style: TextStyle(
                        fontSize: 22.sp, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 24.h,
                        width: 24.w,
                        decoration:
                            BoxDecoration(shape: BoxShape.circle, color: red),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(DateFormat.Hm().format(departureDate)),
                              Container(
                                margin:
                                     EdgeInsets.symmetric(horizontal: 5.w),
                                width: 10.w,
                                child: Divider(
                                  color: grey6,
                                ),
                              ),
                              Text(DateFormat.Hm().format(arrivalDate))
                            ],
                          ),
                          Row(
                            children: [
                              Text(arrivalAirport),
                              SizedBox(
                                width: 30.w,
                              ),
                              Text(departureAirport)
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text('$timeDiffч в пути'),
                          if (!hasTransfer) const Text('/Без пересадок')
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          if (badge != null)
            Positioned(
              top: -10.h,
              child: Container(
                height: 30.h,
                width: 130.w,
                decoration: BoxDecoration(
                    color: blue, borderRadius: BorderRadius.circular(50.r)),
                child: Center(
                    child: Text(
                  badge!,
                  style: TextStyle(color: white, fontWeight: FontWeight.w500),
                )),
              ),
            ),
        ],
      ),
    );
  }
}
