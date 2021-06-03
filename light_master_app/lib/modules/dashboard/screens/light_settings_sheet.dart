import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_master_app/modules/dashboard/bloc/light_settings_sheet_bloc.dart';
import 'package:light_master_app/modules/dashboard/bloc/managed_light_source_bloc.dart';
import 'package:light_master_app/modules/dashboard/models/light_source.dart';
import 'package:light_master_app/modules/dashboard/screens/light_settings_sheet_footer.dart';
import 'package:light_master_app/modules/dashboard/screens/light_settings_sheet_navigation.dart';

import 'effects_light_settings.dart';
import 'light_settings_sheet_header.dart';
import 'mono_light_settings.dart';

enum LightSourceMode { mono_colour, effect_coloring }

class LightSettingsSheet extends StatelessWidget {
  final LightSource lightSource;
  final LightSource lightSourceCopy;

  LightSettingsSheet({Key key, this.lightSource})
      : this.lightSourceCopy = LightSource(
            lightSource.networkAddress,
            lightSource.name,
            lightSource.isTurnedOn,
            lightSource.light,
            lightSource.effects),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final _lightSettingsBloc = BlocProvider.of<LightSettingsSheetBloc>(context);
    final _managedLightSourceBloc =
        BlocProvider.of<ManagedLightSourceBloc>(context);
    LightSettingsSheetEvent mode;
    final settingsWidget =
        BlocBuilder<LightSettingsSheetBloc, LightSettingsSheetEvent>(
            builder: (BuildContext context, LightSettingsSheetEvent state) {
      switch (state) {
        case LightSettingsSheetEvent.mono:
          mode = LightSettingsSheetEvent.mono;
          return MonoLightSettings(lightSource);
        case LightSettingsSheetEvent.effect:
          mode = LightSettingsSheetEvent.effect;
          return EffectsLightSettings(lightSource);
      }
    });

    return FractionallySizedBox(
        heightFactor: 0.9,
        alignment: Alignment.bottomCenter,
        child: SizedBox.expand(
            child: Container(
                child: Column(children: [
          BlocProvider.value(
              value: _managedLightSourceBloc,
              child: LightSettingsSheetHeader(lightSource)),
          BlocProvider.value(
            value: _lightSettingsBloc,
            child: BlocProvider.value(
              value: _managedLightSourceBloc,
              child: LightSettingsSheetNavigation(),
            ),
          ),
          Expanded(
              child: Container(
                  padding: EdgeInsets.only(top: 2, bottom: 2),
                  color: Color.fromARGB(255, 225, 225, 225),
                  child: BlocProvider.value(
                      value: _managedLightSourceBloc, child: settingsWidget))),
          LightSettingsSheetFooter(() {
            // this is called when the cancel button is pressed
            // there exists no call back since we apply all changes to the original instance

            // previous code:
            // lightSource.networkAddress =
            //     this.widget.lightSourceCopy.networkAddress;
            // lightSource.name = this.widget.lightSourceCopy.name;
            // lightSource.light = this.widget.lightSourceCopy.light;
          })
        ]))));
  }
}
