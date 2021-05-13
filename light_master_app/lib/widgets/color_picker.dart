import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

typedef void ColorChangedCallback(Color newColor);

class LMColorPicker extends StatefulWidget {
  final Color initialColor;
  final ColorChangedCallback colorChangedCallback;

  LMColorPicker(this.initialColor, this.colorChangedCallback);

  @override
  State<StatefulWidget> createState() => _LMColorPickerState();
}

class _LMColorPickerState extends State<LMColorPicker> {
  bool firstBuild = true;
  Color selectedColor;

  @override
  Widget build(BuildContext context) {
    if (firstBuild) {
      selectedColor = widget.initialColor;
      firstBuild = false;
    }

    return ColorPicker(
        pickersEnabled: {
          ColorPickerType.accent: false,
          ColorPickerType.both: false,
          ColorPickerType.bw: false,
          ColorPickerType.custom: true,
          ColorPickerType.primary: false,
          ColorPickerType.wheel: true,
        },
        color: selectedColor,
        wheelDiameter: 275,
        wheelWidth: 20,
        wheelHasBorder: false,
        onColorChanged: (newColor) {
          selectedColor = newColor;
          this.widget.colorChangedCallback(newColor);
        });
  }
}
