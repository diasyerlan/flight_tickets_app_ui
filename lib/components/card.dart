// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flights_app/constants.dart';
import 'package:flights_app/models/title_model.dart';
import 'package:flights_app/screens/search_page_extended.dart';
import 'package:flutter/material.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                          'assets/images/$image.png'),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 16,
                              color: white,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          subTitle,
                          style: TextStyle(fontSize: 14, color: grey6),
                        ),
                      ],
                    )
                  ],
                ),
                Divider(
                  color: grey6,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
