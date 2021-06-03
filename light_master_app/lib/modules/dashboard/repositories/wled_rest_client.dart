import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:light_master_app/modules/dashboard/models/light.dart';
import 'package:meta/meta.dart';

class WledRestClient {
  final http.Client _httpClient;

  WledRestClient({
    @required http.Client httpClient,
  })  : _httpClient = httpClient,
        assert(httpClient != null);

  Future<List<String>> fetchEffects(String baseUrl) async {
    final url = Uri.http(baseUrl, '/json/eff');
    final response = await this._httpClient.get(url);

    if (response.statusCode != 200) {
      throw new Exception('error getting effects');
    }

    return jsonDecode(response.body).cast<String>().toList();
  }

  Future<Map<String, dynamic>> fetchState(String baseUrl) async {
    final url = Uri.http(baseUrl, '/json');
    final response = await this._httpClient.get(url);

    if (response.statusCode != 200) {
      throw new Exception('could not fetch status of wled instance $baseUrl');
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  Future<List<dynamic>> fetchPaletts(String baseUrl) async {
    final url = Uri.http(baseUrl, '/json/pal');
    final response = await this._httpClient.get(url);

    if (response.statusCode != 200) {
      throw new Exception('error getting paletts');
    }

    return jsonDecode(response.body);
  }

  Future setWledInstanceName(String baseUrl, String name) async {
    final url = Uri.http(baseUrl, 'settings/ui', {'DS': name});

    try {
      await this._httpClient.post(url,
          headers: {"Content-Type": "xapplication/x-www-form-urlencoded"});
    } catch (_) {
      // expected, WLED returns faulty response here which causes dart to crash.
    }
  }

  Future setWledInstanceState(String baseUrl, bool isTurnedOn) async {
    final url = Uri.http(baseUrl, '/json/state');
    final response =
        await this._httpClient.post(url, body: jsonEncode({"on": isTurnedOn}));

    if (response.statusCode != 200) {
      throw new Exception(
          'Tried turning on/off wled instance, expected 200, but got ${response.statusCode}');
    }
  }

  Future setSolidLight(String baseUrl, SolidLight solidLight) async {
    final url = Uri.http(baseUrl, '/json');
    log('RGB: ${solidLight.color.red}, ${solidLight.color.green}, ${solidLight.color.blue}');
    final response = await this._httpClient.post(url,
        body: jsonEncode({
          "bri": 255,
          "seg": [
            {
              "fx": 0,
              "col": [
                [
                  solidLight.color.red,
                  solidLight.color.green,
                  solidLight.color.blue
                ],
                [],
                []
              ],
              "bri": 255
            }
          ]
        }));

    if (response.statusCode != 200) {
      throw new Exception(
          "Tried setting solid color, expected 200, but got ${response.statusCode}");
    }
  }

  Future setEffectsLight(
      String baseUrl, int effectId, int brightness, int speed) async {
    final url = Uri.http(baseUrl, '/json');
    final response = await this._httpClient.post(url,
        body: jsonEncode({
          "bri": brightness,
          "seg": [
            {"fx": effectId, "sx": speed}
          ]
        }));

    if (response.statusCode != 200) {
      throw new Exception(
          "Tried setting effect color, expected 200, but got ${response.statusCode}");
    }
  }
}
