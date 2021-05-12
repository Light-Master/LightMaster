import 'package:flutter/material.dart';
import 'package:light_master_app/core/models/light_source.dart';
import 'package:tuple/tuple.dart';
import 'package:light_master_app/widgets/cards.dart';

class AppModel extends ChangeNotifier {
  final List<Tuple2<LightSource, Cards>> lightSources = [];

  void addLightSource(LightSource lightSource, Cards card) {
    if (lightSource != null) {
      lightSources.add(Tuple2(lightSource, card));
      lightSource.addListener(onLightSourceChanged);
      notifyListeners();
    }
  }

  void removeLightSource(Tuple2<LightSource, Cards> item) {
    item.item1.removeListener(onLightSourceChanged);
    lightSources.remove(item);
    notifyListeners();
  }

  void onLightSourceChanged() {
    print("received change");
    notifyListeners();
  }
}
