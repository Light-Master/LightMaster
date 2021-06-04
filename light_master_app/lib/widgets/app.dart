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

    var lightSource =
        LightSource("192.168.0.71", "So wow", false, SolidLight(Colors.red));
    var repo = LightMasterRepository();
    // repo.getEffectsList(lightSource).then(print);

    // repo
    //     .propagateLightSourceLight(lightSource)
    //     .then((value) {
    //       lightSource.light = EffectLight("Wipe", 128, 100);
    //       return repo.propagateLightSourceLight(lightSource);
    //     })
    //     .then((value) => repo.getLightSource("192.168.0.71"))
    //     .then(printLightSource)
    //     .then((value) {
    //       lightSource.light = SolidLight(Colors.red[800]);
    //       return repo.propagateLightSourceLight(lightSource);
    //     })
    //     .then((value) => repo.getLightSource(lightSource.networkAddress))
    //     .then(printLightSource)
    //     .then((value) {
    //       lightSource.light = EffectLight("Rainbow", 255, 10);
    //       return repo.propagateLightSourceLight(lightSource);
    //     })
    //     .then((value) => repo.getLightSource(lightSource.networkAddress))
    //     .then(printLightSource)
    //     .then((value) => repo.turnOffLight(lightSource))
    //     .then((value) => repo.getLightSource(lightSource.networkAddress))
    //     .then(printLightSource);

    // repo
    //     .getLightSourceName(lightSource.networkAddress)
    //     .then(print)
    //     .then((_) => repo.setLightSourceName(lightSource))
    //     .then((value) => repo.getLightSourceName(lightSource.networkAddress))
    //     .then(print);

    repo.getAutoDiscoveredLightSources().listen((list) {
      list.forEach((element) => print(element.toString()));
      print("");
    });

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
