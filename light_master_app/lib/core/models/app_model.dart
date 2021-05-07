import 'package:flutter/material.dart';
import 'package:light_master_app/core/models/light_source.dart';
import 'package:tuple/tuple.dart';

class AppModel extends ChangeNotifier {
  final List<Tuple2<LightSource, LightSource>> lightSources = [];

  void addLightSource(LightSource lightSource, bool placement) {
    if (placement && !lightSources.isEmpty && lightSources.last.item1 != null) {
      lightSources.add(Tuple2(lightSource, null));
    } else if (!placement &&
        !lightSources.isEmpty &&
        lightSources.last.item2 != null) {
      lightSources.add(Tuple2(null, lightSource));
    } else {
      lightSources.add(Tuple2(lightSource, null));
    }
    lightSource.addListener(onLightSourceChanged);
    notifyListeners();
  }

  void removeLightSource(LightSource lightSource) {
    lightSource.removeListener(onLightSourceChanged);
    lightSources.remove(lightSource);
    notifyListeners();
  }

  void onLightSourceChanged() {
    print("received change");
    notifyListeners();
  }
}
