import 'package:flutter/material.dart';
import 'package:light_master_app/core/models/light_source.dart';
import 'package:light_master_app/widgets/light_settings_sheet_footer.dart';
import 'package:light_master_app/widgets/light_settings_sheet_navigation.dart';
import 'package:provider/provider.dart';

import '../modules/dashboard/screens/effects_light_settings.dart';
import 'light_settings_sheet_header.dart';
import '../modules/dashboard/screens/mono_light_settings.dart';

enum LightSourceMode { mono_colour, effect_coloring }

class LightSettingsSheet extends StatefulWidget {
  final LightSource lightSource;
  final LightSource lightSourceCopy;

  LightSettingsSheet({Key key, this.lightSource})
      : this.lightSourceCopy = LightSource(lightSource.networkAddress,
            lightSource.name, lightSource.isTurnedOn, lightSource.light),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _LightSettingsSheetState();
}

class _LightSettingsSheetState extends State<LightSettingsSheet> {
  bool initialBuild = true;
  var mode = LightSourceMode.mono_colour;

  @override
  Widget build(BuildContext context) {
    Widget settingsWidget;
    switch (mode) {
      case LightSourceMode.mono_colour:
        settingsWidget = MonoLightSettings();
        break;
      case LightSourceMode.effect_coloring:
        settingsWidget = EffectsLightSettings();
        break;
    }

    return ChangeNotifierProvider.value(
        value: this.widget.lightSource,
        child: FractionallySizedBox(
            heightFactor: 0.9,
            alignment: Alignment.bottomCenter,
            child: SizedBox.expand(
                child: Container(
                    child: Column(children: [
              LightSettingsSheetHeader(),
              LightSettingsSheetNavigation(
                  this.mode,
                  () => setState(() => mode = LightSourceMode.mono_colour),
                  () => setState(() => mode = LightSourceMode.effect_coloring)),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.only(top: 2, bottom: 2),
                      color: Color.fromARGB(255, 225, 225, 225),
                      child: settingsWidget)),
              LightSettingsSheetFooter(() {
                // this is called when the cancel button is pressed
                // there exists no call back since we apply all changes to the original instance

                // previous code:
                // lightSource.networkAddress =
                //     this.widget.lightSourceCopy.networkAddress;
                // lightSource.name = this.widget.lightSourceCopy.name;
                // lightSource.light = this.widget.lightSourceCopy.light;
              })
            ])))));
  }
}
