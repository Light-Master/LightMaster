import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class MonoLightSettings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MonoLightSettingsState();
}

class _MonoLightSettingsState extends State<MonoLightSettings> {
  Color selectedColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Material(
            child: ColorPicker(
                pickerColor: selectedColor,
                onColorChanged: (newColor) =>
                    setState(() => selectedColor = newColor))));
  }
}
