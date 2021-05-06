import 'package:flutter/material.dart';
import 'package:light_master_app/widgets/color_picker.dart';

class MonoLightSettings extends StatefulWidget {
  final Color initialColor;

  MonoLightSettings(this.initialColor);

  @override
  State<StatefulWidget> createState() => _MonoLightSettingsState();
}

class _MonoLightSettingsState extends State<MonoLightSettings> {
  Color selectedColor;

  @override
  Widget build(BuildContext context) {
    selectedColor = this.widget.initialColor;

    return LMColorPicker(selectedColor, (newColor) => selectedColor = newColor);
  }
}
