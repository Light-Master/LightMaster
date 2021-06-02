import 'package:flutter/material.dart';
import 'light_source.dart';

class AppModel extends ChangeNotifier {
  final List<LightSource> lightSources = [];

  void addLightSource(LightSource lightSource) {
    if (lightSource != null) {
      lightSources.add(lightSource);
    }
  }

  void removeLightSource(LightSource lightSource) {
    lightSources.remove(lightSource);
  }

  void onLightSourceChanged() {
    print("received change");
  }
}
