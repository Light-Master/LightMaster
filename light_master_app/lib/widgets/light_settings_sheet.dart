import 'package:flutter/material.dart';
import 'package:light_master_app/core/models/light.dart';
import 'package:light_master_app/core/models/light_source.dart';
import 'package:light_master_app/widgets/light_settings_sheet_footer.dart';
import 'package:light_master_app/widgets/light_settings_sheet_navigation.dart';
import 'package:provider/provider.dart';

import 'effects_light_settings.dart';
import 'light_settings_sheet_header.dart';
import 'mono_light_settings.dart';

class LightSettingsSheet extends StatefulWidget {
  final LightSource lightSource;

  LightSettingsSheet({Key key, this.lightSource}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LightSettingsSheetState();
}

enum LightSourceMode { mono_colour, effect_coloring }

class _LightSettingsSheetState extends State<LightSettingsSheet> {
  bool initialBuild = true;
  LightSourceMode mode;

  @override
  Widget build(BuildContext context) {
    if (initialBuild) {
      if (this.widget.lightSource.light == null ||
          this.widget.lightSource.light is SolidLight) {
        mode = LightSourceMode.mono_colour;
      } else {
        mode = LightSourceMode.effect_coloring;
      }
      initialBuild = false;
    }

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
        value: LightSource(
            this.widget.lightSource.networkAddress,
            this.widget.lightSource.name,
            this.widget.lightSource.isTurnedOn,
            this.widget.lightSource.light),
        child: FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            widthFactor: 1,
            heightFactor: 0.875,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(35),
                        topRight: const Radius.circular(35))),
                child: new Column(children: [
                  LightSettingsSheetHeader(),
                  LightSettingsSheetNavigation(
                      this.mode,
                      () => setState(() => mode = LightSourceMode.mono_colour),
                      () => setState(
                          () => mode = LightSourceMode.effect_coloring)),
                  Expanded(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                        Expanded(
                            child: Container(
                                margin: EdgeInsets.only(top: 5),
                                color: Color.fromARGB(255, 225, 225, 225),
                                child: settingsWidget))
                      ])),
                  Consumer<LightSource>(builder: (context, lightSource, child) {
                    return LightSettingsSheetFooter(() {
                      this.widget.lightSource.name = lightSource.name;
                      this.widget.lightSource.light = lightSource.light;
                    });
                  })
                ]))));
  }
}
