import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_master_app/modules/dashboard/bloc/light_settings_sheet_bloc.dart';
import 'package:light_master_app/modules/dashboard/bloc/managed_light_source_bloc.dart';
import 'package:light_master_app/modules/dashboard/events/managed_light_source_event.dart';
import 'package:light_master_app/modules/dashboard/models/light.dart';
import 'package:light_master_app/modules/dashboard/models/light_source.dart';

import '../modules/dashboard/screens/light_settings_sheet.dart';

class LMCard extends StatelessWidget {
  final double turnedOnElevation = 12;
  final double turnedOffElevation = 0;
  final double childPadding = 35;
  final Color shadowColor = Colors.yellow;
  LightSource lightSource;

  LMCard(this.lightSource);

  @override
  Widget build(BuildContext context) {
    final _managedLightSourceBloc =
        BlocProvider.of<ManagedLightSourceBloc>(context);
    return /*Consumer<LightSource>(
        builder: (context, lightSource, child) =>*/
        GestureDetector(
      onTap: () {
        lightSource.isTurnedOn = !lightSource.isTurnedOn;
        _managedLightSourceBloc.add(ManagedLightSourceChangeEvent(lightSource));
      },
      onLongPress: () {
        showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(35),
                    topRight: const Radius.circular(35))),
            context: context,
            isScrollControlled: true,
            builder: (BuildContext bc) {
              return MultiBlocProvider(providers: [
                BlocProvider.value(
                  value: _managedLightSourceBloc,
                ),
                BlocProvider(create: (context) => LightSettingsSheetBloc())
              ], child: LightSettingsSheet(lightSource: lightSource));
            });
      },
      child: Stack(children: [
        Container(
            width: 160,
            height: 160,
            child: Card(
              color: lightSource.light is SolidLight
                  ? (lightSource.light as SolidLight).color
                  : lightSource.isTurnedOn
                      ? Colors.grey
                      : shadowColor,
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(children: [
                Positioned(
                    left: 20,
                    bottom: 20,
                    right: 20,
                    child: Text(lightSource.name, textAlign: TextAlign.center))
              ]),
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(35.0),
              )),
              elevation: lightSource.isTurnedOn ? 0 : 12,
              margin: EdgeInsets.all(10),
            )),
      ]),
    );
  }
}
