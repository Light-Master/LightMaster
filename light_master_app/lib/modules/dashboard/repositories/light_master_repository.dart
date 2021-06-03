import 'package:http/http.dart';
import 'package:light_master_app/modules/dashboard/models/light_source.dart';
import 'package:light_master_app/modules/dashboard/repositories/wled_rest_client.dart';

class LightMasterRepository {
  static final httpClient = Client();
  final WledRestClient wledRestClient = WledRestClient(httpClient: httpClient);
  // final WledWebSocketClient wledWebSocketClient =
  // WledWebSocketClient(baseUrl: "192.168.0.71");

  Future<List<String>> getEffectsList(LightSource lightSource) {
    // todo: add cache so list is not fetched everytime

    return wledRestClient.fetchEffects(lightSource.networkAddress);
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

  Future propagateLightSourceLight(LightSource lightSource) {}
}
