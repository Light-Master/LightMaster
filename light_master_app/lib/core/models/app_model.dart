import 'package:flutter/material.dart';
import 'package:light_master_app/core/models/light_source.dart';

class AppModel extends ChangeNotifier {
  final List<LightSource> lightSources = [];

  void addLightSource(LightSource lightSource) {
    lightSources.add(lightSource);
    notifyListeners();
  }

  void removeLightSource(LightSource lightSource) {
    lightSources.remove(lightSource);
    notifyListeners();
  }
}
