import 'package:flutter/material.dart';
import 'package:light_master_app/core/models/light.dart';

class LightSource extends ChangeNotifier {
  final String networkAddress;
  String _name;
  Light _light;

  LightSource(this.networkAddress, this._name, this._light);

  String get name => _name;
  set name(String newValue) {
    _name = newValue;
    print("Lightsource name set to $_name");
    notifyListeners();
  }

  Light get light => _light;
  set light(Light newLight) {
    this._light = newLight;
    notifyListeners();
  }
}
