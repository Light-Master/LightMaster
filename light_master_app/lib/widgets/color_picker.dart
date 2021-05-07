import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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

    return Scaffold(
        body: Material(
            child: ColorPicker(
                pickerColor: selectedColor,
                onColorChanged: (newColor) {
                  print("color changed");
                  setState(() => selectedColor = newColor);
                  widget.colorChangedCallback(newColor);
                })));
  }
}
