import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TitleModel extends ChangeNotifier {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller1 = TextEditingController();
  TextEditingController get controller => _controller;
  TextEditingController get controller1 => _controller1;
  void updateTitle(String newTitle) {
    _controller.text = newTitle;
  }

  void updateTitle1(String newTitle) {
    _controller1.text = newTitle;
  }
}
