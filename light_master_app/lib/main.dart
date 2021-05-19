import 'package:flutter/material.dart';
import 'package:light_master_app/core/models/app_model.dart';
import 'package:light_master_app/widgets/app.dart';
import 'package:provider/provider.dart';

import 'widgets/app.dart';

void main() {
  // MARK:- model is created from app_model.dart with child from app.dart
  runApp(ChangeNotifierProvider(
    create: (context) => AppModel(),
    child: App(),
  ));
}
