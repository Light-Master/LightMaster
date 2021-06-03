import 'package:flutter/material.dart';

import 'light.dart';
import 'light_source.dart';

class WLedClient {
  Future<List<LightSource>> detectLeds() async {
    //sleep(Duration(seconds: 10));
    return [
      /*put your items here*/
      LightSource(
          "192.168.1.10", "Led1", false, SolidLight(Colors.blue[800]), []),
      LightSource(
          "192.168.1.11", "Led2", false, SolidLight(Colors.blue[800]), []),
      LightSource(
          "192.168.1.12", "Led3", false, SolidLight(Colors.blue[800]), []),
      LightSource(
          "192.168.1.13", "Led4", false, SolidLight(Colors.blue[800]), []),
      LightSource(
          "192.168.1.14", "Led5", false, SolidLight(Colors.blue[800]), []),
      LightSource(
          "192.168.1.15", "Led6", false, SolidLight(Colors.blue[800]), []),
      LightSource(
          "192.168.1.16", "Led7", false, SolidLight(Colors.blue[800]), []),
      LightSource(
          "192.168.1.17", "Led8", false, SolidLight(Colors.blue[800]), []),
      LightSource(
          "192.168.1.18", "Led9", false, SolidLight(Colors.blue[800]), []),
      LightSource(
          "192.168.1.19", "Led10", false, SolidLight(Colors.blue[800]), []),
    ];
  }
}
