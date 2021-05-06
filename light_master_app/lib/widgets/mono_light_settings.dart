import 'package:flutter/material.dart';
import 'package:light_master_app/core/models/light.dart';
import 'package:light_master_app/core/models/light_source.dart';
import 'package:light_master_app/widgets/color_picker.dart';
import 'package:provider/provider.dart';

class MonoLightSettings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MonoLightSettingsState();
}

class _MonoLightSettingsState extends State<MonoLightSettings> {
  Color selectedColor;

  @override
  Widget build(BuildContext context) {
    final double margin = 10;
    final double padding = 15;

    return Consumer<LightSource>(
      builder: (builder, lightSource, child) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: margin, left: margin, right: margin),
                padding: EdgeInsets.only(
                    top: padding, left: padding, right: padding),
                height: 458 + padding,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: LMColorPicker((lightSource.light as SolidLight).color,
                    (newColor) => lightSource.light = SolidLight(newColor)),
              ),
            ]);
      },
    );
  }
}
