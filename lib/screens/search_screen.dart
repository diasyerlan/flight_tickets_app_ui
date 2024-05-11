// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flights_app/components/card.dart';
import 'package:flights_app/components/rectangle.dart';
import 'package:flights_app/models/title_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            const SizedBox(height: 18),
            Container(
              height: 96,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: grey4, borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/plane1.svg'),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 200,
                            child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp('[а-яА-Я]+'),
                                ),
                              ],
                              controller: controller,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 12),
                                  hintStyle: TextStyle(color: Colors.white),
                                  hintText: 'Откуда - Москва',
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Divider(
                        color: grey6,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset('assets/icons/search.svg'),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 200,
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
                                          const EdgeInsets.only(bottom: 12),
                                      hintStyle: TextStyle(color: grey6),
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
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
              padding: const EdgeInsets.symmetric(vertical: 10),
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
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 270,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: grey4, borderRadius: BorderRadius.circular(16)),
              child: const Column(
                children: [
                  SizedBox(height: 16),
                  MyCard(
                      image: 'stambul',
                      title: 'Стамбул',
                      subTitle: 'Популярное направление'),
                  MyCard(
                      image: 'sochi',
                      title: 'Сочи',
                      subTitle: 'Популярное направление'),
                  MyCard(
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
