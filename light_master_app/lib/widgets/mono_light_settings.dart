import 'package:flutter/material.dart';
import 'package:light_master_app/core/models/light.dart';
import 'package:light_master_app/core/models/light_source.dart';
import 'package:provider/provider.dart';

import 'color_picker.dart';

class MonoLightSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double topMargin = 8;
    final double sideMargin = 10;
    final double topPadding = 0;

    var color = Colors.yellow[600];

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
                margin: EdgeInsets.only(
                    top: topMargin, left: sideMargin, right: sideMargin),
                padding: EdgeInsets.only(top: topPadding),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Consumer<LightSource>(
                    builder: (builder, lightSource, child) {
                  if (lightSource.light is SolidLight) {
                    var solidLight = lightSource.light as SolidLight;
                    color = solidLight.color;
                  }
                  return LMColorPicker(color,
                      (newColor) => lightSource.light = SolidLight(newColor));
                }))
          ].toList()),
        )
      ],
    );
  }
}
