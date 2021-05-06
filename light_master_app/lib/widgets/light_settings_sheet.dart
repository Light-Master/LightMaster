import 'package:flutter/material.dart';
import 'package:light_master_app/core/models/light.dart';
import 'package:light_master_app/core/models/light_source.dart';
import 'package:light_master_app/widgets/light_settings_sheet_footer.dart';

import 'effects_light_settings.dart';
import 'light_settings_sheet_header.dart';
import 'mono_light_settings.dart';

class LightSettingsSheet extends StatefulWidget {
  final LightSource lightSource;

  LightSettingsSheet({Key key, this.lightSource}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LightSettingsSheetState();
}

enum _LightSourceMode { mono_colour, effect_coloring }

class _LightSettingsSheetState extends State<LightSettingsSheet> {
  final selectedTabStyle =
      TextStyle(color: Colors.black, decoration: TextDecoration.underline);
  final unselectedTabStyle = TextStyle(color: Colors.grey);

  bool initialBuild = true;
  _LightSourceMode mode;

  @override
  Widget build(BuildContext context) {
    if (initialBuild) {
      if (this.widget.lightSource.light == null ||
          this.widget.lightSource.light is SolidLight) {
        mode = _LightSourceMode.mono_colour;
      } else {
        mode = _LightSourceMode.effect_coloring;
      }
      initialBuild = false;
    }

    Widget settingsWidget;
    switch (mode) {
      case _LightSourceMode.mono_colour:
        var initialColor = Colors.yellow[600];
        if (this.widget.lightSource.light is SolidLight) {
          var solidLight = this.widget.lightSource.light as SolidLight;
          if (solidLight.color != null) {
            settingsWidget = MonoLightSettings(solidLight.color);
          }
        }
        settingsWidget = MonoLightSettings(initialColor);
        break;
      case _LightSourceMode.effect_coloring:
        settingsWidget = EffectsLightSettings();
        break;
    }

    return FractionallySizedBox(
        alignment: Alignment.bottomCenter,
        widthFactor: 1,
        heightFactor: 0.75,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(35),
                    topRight: const Radius.circular(35))),
            child: new Column(children: [
              LightSettingsSheetHeader(lightSource: this.widget.lightSource),
              Container(
                  height: 35,
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () => setState(
                                () => mode = _LightSourceMode.mono_colour),
                            child: Text("Mono",
                                style: mode == _LightSourceMode.mono_colour
                                    ? selectedTabStyle
                                    : unselectedTabStyle)),
                        Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            child: VerticalDivider(
                              thickness: 1,
                              color: Colors.grey,
                            )),
                        TextButton(
                            onPressed: () => setState(
                                () => mode = _LightSourceMode.effect_coloring),
                            child: Text("Effects",
                                style: mode == _LightSourceMode.effect_coloring
                                    ? selectedTabStyle
                                    : unselectedTabStyle))
                      ])),
              Expanded(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(top: 10),
                            color: Color.fromARGB(255, 238, 238, 238),
                            child: settingsWidget))
                  ])),
              LightSettingsSheetFooter(onSaveButtonPressed)
            ])));
  }

  void onSaveButtonPressed() {
    print("Lightsource saved");
    // todo: implement save logic here
  }
}
