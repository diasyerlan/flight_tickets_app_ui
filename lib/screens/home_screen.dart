import 'dart:convert';

import 'package:flights_app/constants.dart';
import 'package:flights_app/models/title_model.dart';
import 'package:flights_app/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          width: 200,
          margin: const EdgeInsets.only(top: 80, bottom: 40),
          child: const Text(
            'Поиск дешевых авиабилетов',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                height: 122,
                decoration: BoxDecoration(
                    color: grey4, borderRadius: BorderRadius.circular(16)),
                child: Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: grey5, borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SvgPicture.asset('assets/icons/search.svg'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                            width: 250,
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
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 12),
                                  hintStyle: TextStyle(color: Colors.white),
                                  hintText: 'Откуда - Москва',
                                  border: InputBorder.none),
                            ),
                          ),
                          SizedBox(
                            width: 280,
                            child: Divider(
                              color: grey6,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                            width: 250,
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
                                              0.85,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: SearchScreen(
                                              controller: _controller),
                                        );
                                      },
                                    );
                                  },
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      hintText: 'Куда - Турция',
                                      contentPadding:
                                          const EdgeInsets.only(bottom: 12),
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
                margin: const EdgeInsets.symmetric(vertical: 30),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Музыкально отлететь',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 213,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _items.length,
                  separatorBuilder: (context, _) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 133.16,
                          width: 132,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'assets/images/$index.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          _items[index]['title'],
                          style: TextStyle(color: white),
                        ),
                        const SizedBox(height: 5),
                        Text(_items[index]['town'],
                            style: TextStyle(color: grey7)),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/plane.svg'),
                            const SizedBox(width: 5),
                            Text('от ${_items[index]['price']['value']} ₽',
                                style: TextStyle(color: grey7)),
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
