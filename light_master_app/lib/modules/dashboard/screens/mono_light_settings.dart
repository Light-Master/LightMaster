import 'package:flutter/material.dart';

import '../../../widgets/color_picker.dart';

class MonoLightSettings extends StatelessWidget {
  final double verticalMargin = 8;
  final double horizontalMargin = 10;

  @override
  Widget build(BuildContext context) {
    var color = Colors.yellow[600];

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
                margin: EdgeInsets.only(
                    top: verticalMargin,
                    bottom: verticalMargin,
                    left: horizontalMargin,
                    right: horizontalMargin),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: LMColorPicker(color, (newColor) {
                  // pass the color to the BLoC here.

                  // code previously:
                  // lightSource.light = SolidLight(newColor)
                }))
          ].toList()),
        )
      ],
    );
  }
}
