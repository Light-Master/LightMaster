import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:light_master_app/core/models/light_source.dart';
import 'package:light_master_app/modules/dashboard/repositories/websocket_client.dart';
import 'package:light_master_app/modules/dashboard/repositories/wled_rest_client.dart';

import 'package:http/http.dart' as http;
import 'package:light_master_app/utils/helpers/wled_http_interceptor.dart';

class LightMasterRepository {
  static final httpClient =
      HttpClientWithInterceptor.build(interceptors: [WledHttpInterceptor()]);
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

  Future propagateLightSourceLight(LightSource lightSource) {}
}
