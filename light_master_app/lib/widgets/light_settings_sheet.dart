import 'package:flutter/material.dart';
import 'package:light_master_app/core/models/light_source.dart';
import 'package:light_master_app/widgets/effects_light_settings.dart';
import 'package:light_master_app/widgets/mono_light_settings.dart';
import 'package:light_master_app/widgets/segmented_light_settings.dart';

class LightSettingsSheet extends StatefulWidget {
  final LightSource lightSource;

  LightSettingsSheet({Key key, this.lightSource}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LightSettingsSheetState();
}

enum _LightSourceMode { mono_colour, segmented_colour, effect }

class _LightSettingsSheetState extends State<LightSettingsSheet> {
  _LightSourceMode mode = _LightSourceMode.mono_colour;

  @override
  Widget build(BuildContext context) {
    Widget settingsWidget;
    switch (mode) {
      case _LightSourceMode.mono_colour:
        settingsWidget = MonoLightSettings();
        break;
      case _LightSourceMode.segmented_colour:
        settingsWidget = SegmentedLightSettings();
        break;
      case _LightSourceMode.effect:
        settingsWidget = EffectsLightSettings();
        break;
    }

    return FractionallySizedBox(
        alignment: Alignment.bottomCenter,
        widthFactor: 1,
        heightFactor: 0.75,
        child: Container(
            color: Colors.white,
            child: new Column(children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(widget.lightSource.name)]),
              Row(children: [
                TextButton(
                    onPressed: () => setState(() {
                          mode = _LightSourceMode.mono_colour;
                        }),
                    child: Text("Mono")),
                TextButton(
                    onPressed: () => setState(() {
                          mode = _LightSourceMode.segmented_colour;
                        }),
                    child: Text("Segments")),
                TextButton(
                    onPressed: () => setState(() {
                          mode = _LightSourceMode.effect;
                        }),
                    child: Text("Effects"))
              ]),
              settingsWidget,
              Row(children: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Close this"))
              ])
            ])));
  }
}
