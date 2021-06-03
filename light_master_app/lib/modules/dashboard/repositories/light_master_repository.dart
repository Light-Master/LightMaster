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

  Future<List<String>> getEffectsList(LightSource lightSource) async {
    if (this.cachedEffectLists.containsKey(lightSource.networkAddress)) {
      return this.cachedEffectLists[lightSource.networkAddress];
    } else {
      var effectsList =
          await wledRestClient.fetchEffects(lightSource.networkAddress);

      this.cachedEffectLists[lightSource.networkAddress] = effectsList;
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
      var effectLight = lightSource.light as EffectLight;

      if (!this.cachedEffectLists.containsKey(lightSource.networkAddress)) {
        await getEffectsList(lightSource);
      }

      final effectId = this
          .cachedEffectLists[lightSource.networkAddress]
          .asMap()
          .entries
          .singleWhere((effectEntry) => effectEntry.value == effectLight.effect)
          .key;

      return this.wledRestClient.setEffectsLight(lightSource.networkAddress,
          effectId, effectLight.brightness, effectLight.speed);
    }
  }
}
