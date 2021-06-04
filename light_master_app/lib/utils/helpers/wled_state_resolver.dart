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
    final effectsList = statusMap['effects']
        .cast<String>()
        .toList()
        .where((e) => !effectsBlacklist.contains(e))
        .toList();
    effectsList.sort();

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

  static List<String> effectsBlacklist = [
    "Solid",
    "Android",
    "Aurora",
    "Blends",
    "Blink",
    "Candle",
    "Candle Multi",
    "Chase",
    "Chase Flash",
    "Chase Flash Rnd",
    "Chase Rnd",
    "Dancing Shadows",
    "Dissolve",
    "Dissolve Rnd",
    "Fade",
    "Fire Flicker",
    "Fireworks",
    "Fireworks 1d",
    "Gradient",
    "Heartbeat",
    "ICU",
    "Lighthouse",
    "Lightning",
    "Loading",
    "Meteor",
    "Meteor Smooth",
    "Multi Comet",
    "Oscillate",
    "Percent",
    "Plasma",
    "Popcorn",
    "Railway",
    "Rain",
    "Running",
    "Running 2",
    "Saw",
    "Scan",
    "Scan Dual",
    "Scanner",
    "Scanner Dual",
    "Sine",
    "Sinelon",
    "Sinelon Dual",
    "Solid Glitter",
    "Solid Pattern",
    "Solid Pattern Tri",
    "Sparkle",
    "Sparkle Dark",
    "Sparkle+",
    "Spots",
    "Spots Fade",
    "Strobo",
    "Strobo Mega",
    "Strobo Rainbow",
    "Sweep",
    "Theater",
    "Tri Chase",
    "Tri Fade",
    "Tri Wipe",
    "Twinkle",
    "Twinkleup",
    "Two Areas",
    "Two Dots",
    "Washing Machine",
    "Wipe"
  ];
}
