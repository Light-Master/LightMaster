import 'package:flutter/material.dart';
import 'package:light_master_app/core/models/light.dart';

class LightSource extends ChangeNotifier {
  final String networkAddress;
  bool _isTurnedOn;
  String _name;
  Light _light;

  LightSource(this.networkAddress, this._name, this._isTurnedOn, this._light);

  String get name => _name;
  set name(String newValue) {
    _name = newValue;
    print("Lightsource name set to $_name");
    notifyListeners();
  }

  bool get isTurnedOn => _isTurnedOn;
  set isTurnedOn(bool newValue) {
    _isTurnedOn = newValue;
    print("Light source was turned ${_isTurnedOn ? "on" : "off"}");
    notifyListeners();
  }

  Light get light => _light;
  set light(Light newLight) {
    this._light = newLight;
    notifyListeners();
  }
}
