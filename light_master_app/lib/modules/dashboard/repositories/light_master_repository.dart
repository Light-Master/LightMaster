import 'dart:ui';

import 'package:http/http.dart';
import 'package:light_master_app/modules/dashboard/models/light.dart';
import 'package:light_master_app/modules/dashboard/models/light_source.dart';
import 'package:light_master_app/modules/dashboard/repositories/wled_rest_client.dart';

class LightMasterRepository {
  static final httpClient = Client();
  final WledRestClient wledRestClient = WledRestClient(httpClient: httpClient);
  // final WledWebSocketClient wledWebSocketClient =
  // WledWebSocketClient(baseUrl: "192.168.0.71");

  final cachedEffectLists = Map<String, List<String>>();

  Future<List<String>> getEffectsList(String networkAddress) async {
    if (this.cachedEffectLists.containsKey(networkAddress)) {
      return this.cachedEffectLists[networkAddress];
    } else {
      var effectsList = await wledRestClient.fetchEffects(networkAddress);

      this.cachedEffectLists[networkAddress] = effectsList;
      return effectsList;
    }
  }

  Future<String> getLightSourceName(String networkAddress) async {
    var stateMap = await wledRestClient.fetchState(networkAddress);
    var infoMap = stateMap["info"] as Map<String, dynamic>;
    return infoMap["name"] as String;
  }

  Future setLightSourceName(LightSource lightSource) {
    return this
        .wledRestClient
        .setWledInstanceName(lightSource.networkAddress, lightSource.name);
  }

  Future turnOnLight(LightSource lightSource) {
    return this
        .wledRestClient
        .setWledInstanceState(lightSource.networkAddress, true);
  }

  Future turnOffLight(LightSource lightSource) {
    return this
        .wledRestClient
        .setWledInstanceState(lightSource.networkAddress, false);
  }

  Future propagateLightSourceLight(LightSource lightSource) async {
    if (lightSource.light is SolidLight) {
      await this.wledRestClient.setSolidLight(
          lightSource.networkAddress, lightSource.light as SolidLight);
    } else {
      final effectLight = lightSource.light as EffectLight;
      final effectId = await this
          .getEffectIdByName(lightSource.networkAddress, effectLight.effect);

      return this.wledRestClient.setEffectsLight(
          lightSource.networkAddress,
          effectId,
          (effectLight.brightness / 100 * 255).floor(),
          (effectLight.speed / 100 * 255).floor());
    }
  }

  Future<LightSource> getLightSource(String networkAddress) async {
    final statusMap = await this.wledRestClient.fetchState(networkAddress);
    final infoMap = statusMap['info'] as Map<String, dynamic>;
    final name = infoMap['name'] as String;
    final stateMap = statusMap['state'] as Map<String, dynamic>;
    final isTurnedOn = stateMap['on'] as bool;
    final mainSegment = stateMap['seg'][stateMap['mainseg']];
    Light light;

    if (mainSegment['fx'] == 0) {
      light = SolidLight(Color.fromRGBO(mainSegment['col'][0][0],
          mainSegment['col'][0][1], mainSegment['col'][0][2], 1));
    } else {
      final effectId = mainSegment['fx'] as int;
      final effectName = await this.getEffectNameById(networkAddress, effectId);
      final brigtness = ((mainSegment['bri'] as int) / 255 * 100).floor();
      final speed = ((mainSegment['sx'] as int) / 255 * 100).floor();
      light = EffectLight(effectName, brigtness, speed);
    }

    return LightSource(networkAddress, name, isTurnedOn, light);
  }

  Future<int> getEffectIdByName(String networkAddress, String name) async {
    if (!this.cachedEffectLists.containsKey(networkAddress)) {
      await getEffectsList(networkAddress);
    }

    return this
        .cachedEffectLists[networkAddress]
        .asMap()
        .entries
        .singleWhere((effectEntry) => effectEntry.value == name)
        .key;
  }

  Future<String> getEffectNameById(String networkAddress, int id) async {
    if (!this.cachedEffectLists.containsKey(networkAddress)) {
      await getEffectsList(networkAddress);
    }

    return this.cachedEffectLists[networkAddress].elementAt(id);
  }
}
