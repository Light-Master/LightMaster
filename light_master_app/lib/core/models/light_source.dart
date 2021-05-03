import 'package:flutter/material.dart';

class LightSource extends ChangeNotifier {
  final String networkAddress;
  String name;
  // add colour

  LightSource(this.networkAddress, this.name);
}
