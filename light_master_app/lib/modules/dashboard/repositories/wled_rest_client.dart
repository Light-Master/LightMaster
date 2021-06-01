import 'dart:convert';

import 'package:http/http.dart' as http;
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

  Future setWledInstanceName(String baseUrl, name) async {
    final url = Uri.http(
        baseUrl, 'settings/ui', {'DS': Uri.encodeQueryComponent(name)});
    final response = await this._httpClient.post(url, headers: {
      "Accept": "application/xml",
      "content-type": "xapplication/x-www-form-urlencoded"
    });

    if (response.statusCode != 200) {
      throw new Exception('could not reach instance');
    }
  }
}
