import 'package:flutter/material.dart';

class SelectionNotifier extends ChangeNotifier {
  bool _isSelected = false;

  getValue() => _isSelected;

  setValue(bool isSelected) async {
    _isSelected = isSelected;
    notifyListeners();
  }
}
