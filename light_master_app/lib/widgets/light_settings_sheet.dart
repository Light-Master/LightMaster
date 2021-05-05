import 'package:flutter/material.dart';

class LightSettingsSheet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LightSettingsSheetState();
}

enum _LightSourceMode { mono_colour, segmented_colour, effect }

class _LightSettingsSheetState extends State<LightSettingsSheet> {
  _LightSourceMode mode = _LightSourceMode.mono_colour;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        color: Colors.white,
        child: new Column(children: [
          Row(children: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Close this"))
          ]),
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
          Row(children: [
            Text("Current Mode is ${mode.toString()}"),
          ])
        ]));
  }
}
