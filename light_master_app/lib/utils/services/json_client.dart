import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class JsonClient {
  final _baseUrl;
  final http.Client _httpClient;

  JsonClient({
    @required String baseUrl,
    @required http.Client httpClient,
  })  : _baseUrl = baseUrl,
        _httpClient = httpClient,
        assert(httpClient != null);

  Future<List<dynamic>> fetchEffects() async {
    final url = '$_baseUrl/json/eff';
    final response = await this._httpClient.get(url);

    if (response.statusCode != 200) {
      throw new Exception('error getting effects');
    }

    final json = jsonDecode(response.body);
    return json;
  }

  Future<List<dynamic>> fetchPaletts() async {
    final url = '$_baseUrl/json/pal';
    final response = await this._httpClient.get(url);

    if (response.statusCode != 200) {
      throw new Exception('error getting paletts');
    }

    final json = jsonDecode(response.body);
    return json;
  }

  void setName(String value) async {
    final url = '$_baseUrl/settings/ui?DS=$value';
    final response = await this._httpClient.post(url);

    if (response.statusCode != 200) {
      throw new Exception('could not reach instance');
    }
  }
}
