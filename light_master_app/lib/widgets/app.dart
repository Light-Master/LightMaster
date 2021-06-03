import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_master_app/modules/dashboard/bloc/add_light_bloc.dart';
import 'package:light_master_app/modules/dashboard/bloc/managed_light_source_bloc.dart';

import '../modules/dashboard/screens/home.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    // // var lightSource = LightSource(
    // //     "192.168.0.71", "NOT TESTING NAME", false, SolidLight(Colors.red));
    // // var repo = LightMasterRepository();
    // // repo.getEffectsList(lightSource).then(print);

    // repo
    //     .getLightSourceName(lightSource.networkAddress)
    //     .then(print)
    //     .then((_) => repo.setLightSourceName(lightSource))
    //     .then((value) => repo.getLightSourceName(lightSource.networkAddress));

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
