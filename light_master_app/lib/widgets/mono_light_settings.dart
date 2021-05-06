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
    double margin = 10;
    double padding = 15;

    selectedColor = this.widget.initialColor;

    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: margin, left: margin, right: margin),
            padding: EdgeInsets.all(padding),
            height: 458 + 2 * padding,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(35))),
            child: LMColorPicker(
                selectedColor, (newColor) => selectedColor = newColor),
          ),
        ]);
  }
}
