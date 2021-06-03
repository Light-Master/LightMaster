import 'dart:ui';

import 'package:light_master_app/modules/dashboard/models/light.dart';
import 'package:light_master_app/modules/dashboard/models/light_source.dart';

class WledStateResolver {
  static LightSource resolve(
      String networkAddress, Map<String, dynamic> statusMap) {
    final infoMap = statusMap['info'] as Map<String, dynamic>;
    final name = infoMap['name'] as String;
    final stateMap = statusMap['state'] as Map<String, dynamic>;
    final isTurnedOn = stateMap['on'] as bool;
    final mainSegment = stateMap['seg'][stateMap['mainseg']];
    final testList = statusMap['effects'];
    // TODO: only use whitelisted
    final effectsList = testList.cast<String>().toList();
    Light light;

    if (mainSegment['fx'] == 0) {
      light = SolidLight(Color.fromRGBO(mainSegment['col'][0][0],
          mainSegment['col'][0][1], mainSegment['col'][0][2], 1));
    } else {
      final effectId = mainSegment['fx'] as int;
      final effectName = effectsList[effectId];
      final brigtness = ((mainSegment['bri'] as int) / 255 * 100).floor();
      final speed = ((mainSegment['sx'] as int) / 255 * 100).floor();
      light = EffectLight(effectName, brigtness, speed);
    }

    return LightSource(networkAddress, name, isTurnedOn, light, effectsList);
  }
}
