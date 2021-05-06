import 'package:flutter/material.dart';

class LightSource extends ChangeNotifier {
  final String networkAddress;
  String _name;
  // add colour

  LightSource(this.networkAddress, this._name);

  String get name => _name;

  set name(String newValue) {
    _name = name;
    notifyListeners();
  }
}
