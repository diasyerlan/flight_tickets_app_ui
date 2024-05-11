// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flights_app/constants.dart';
import 'package:flutter/material.dart';
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
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(8)),
            child: Container(
                margin: const EdgeInsets.all(18),
                child: SvgPicture.asset('assets/icons/$icon.svg'))),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 100,
          height: 100,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: white, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
