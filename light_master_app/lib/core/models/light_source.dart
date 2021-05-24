import 'package:flutter/material.dart';
import 'package:light_master_app/core/models/light.dart';

class LightSource extends ChangeNotifier {
  static int _lastId = 0;
  int _id;
  String _networkAddress;
  bool _isTurnedOn;
  String _name;
  Light _light;

  LightSource(this._networkAddress, this._name, this._isTurnedOn, this._light)
  {
    _id = _lastId + 1;
    _lastId = _id;
  }

  int get id => _id;

  String get networkAddress => _networkAddress;

  String get name => _name;
  set name(String newValue) {
    print("light source name set to $newValue");
    _name = newValue;
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
