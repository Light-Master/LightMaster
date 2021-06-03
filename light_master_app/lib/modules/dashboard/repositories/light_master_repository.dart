import 'package:http/http.dart';
import 'package:light_master_app/modules/dashboard/models/light.dart';
import 'package:light_master_app/modules/dashboard/models/light_source.dart';
import 'package:light_master_app/modules/dashboard/repositories/discover_devices.dart';
import 'package:light_master_app/modules/dashboard/repositories/wled_rest_client.dart';
import 'package:light_master_app/utils/helpers/wled_state_resolver.dart';

class LightMasterRepository {
  static final httpClient = Client();
  final WledRestClient wledRestClient = WledRestClient(httpClient: httpClient);
  WLEDDiscoveryModel wledDiscoveryModel;
  // final WledWebSocketClient wledWebSocketClient =
  // WledWebSocketClient(baseUrl: "192.168.0.71");

  final cachedEffectLists = Map<String, List<String>>();

  LightMasterRepository() {
    this.wledDiscoveryModel = WLEDDiscoveryModel(this.wledRestClient);
  }

  WLEDDiscoveryModel get discoveryModel => wledDiscoveryModel;

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

    if (!this.cachedEffectLists.containsKey(networkAddress)) {
      await getEffectsList(networkAddress);
    }

    return WledStateResolver.resolve(networkAddress, statusMap);
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

  Stream<List<LightSource>> getAutoDiscoveredLightSources() {
    return this.wledDiscoveryModel.discoverWLEDDevices;
  }
}
