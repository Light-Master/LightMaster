import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_master_app/modules/dashboard/bloc/add_light_bloc.dart';
import 'package:light_master_app/modules/dashboard/bloc/managed_light_source_bloc.dart';
import 'package:light_master_app/modules/dashboard/models/light.dart';
import 'package:light_master_app/modules/dashboard/models/light_source.dart';
import 'package:light_master_app/modules/dashboard/repositories/discover_devices.dart';
import 'package:light_master_app/modules/dashboard/repositories/light_master_repository.dart';

import '../modules/dashboard/screens/home.dart';

class App extends StatelessWidget {
  void printLightSource(LightSource ls) {
    print("${ls.name} ${ls.networkAddress} ${ls.isTurnedOn}");
    if (ls.light is SolidLight) {
      final solidLight = ls.light as SolidLight;
      print("\t${solidLight.color}");
    } else {
      final effectLight = ls.light as EffectLight;
      print(
          "\t${effectLight.effect} ${effectLight.brightness} ${effectLight.speed}");
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return CupertinoApp(
        theme: const CupertinoThemeData(
          brightness: Brightness.light,
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (BuildContext context) => ManagedLightSourceBloc(),
            ),
            BlocProvider(create: (BuildContext context) => AddLightBloc()),
          ],
          child: Home(),
        ),
        localizationsDelegates: [
          DefaultCupertinoLocalizations.delegate,
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate
        ]);
  }
}
