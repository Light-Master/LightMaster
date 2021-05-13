import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:light_master_app/core/models/light_source.dart';
import 'package:provider/provider.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';

import 'light_settings_sheet.dart';

class LMCard extends StatelessWidget {
  final double turnedOnElevation = 12;
  final double turnedOffElevation = 0;
  final double childPadding = 45;
  final Color shadowColor = Colors.blue;
  double elevation;

  @override
  Widget build(BuildContext context) {
    return Consumer<LightSource>(
        builder: (context, lightSource, child) => GestureDetector(
            onTap: () {
              lightSource.isTurnedOn = !lightSource.isTurnedOn;
            },
            onLongPress: () {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(35),
                          topRight: const Radius.circular(35))),
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext bc) {
                    return LightSettingsSheet(lightSource: lightSource);
                  });
            },
            child: Container(
                decoration: BoxDecoration(
                  color:
                      lightSource.isTurnedOn ? Colors.transparent : shadowColor,
                ),
                child: ImageCard(
                  elevation: elevation = lightSource.isTurnedOn
                      ? turnedOffElevation
                      : turnedOnElevation,
                  childPadding: childPadding,
                  shadowColor: shadowColor,
                  image: Image.network(
                    'https://miro.medium.com/max/85/1*ilC2Aqp5sZd1wi0CopD1Hw.png',
                  ),
                ))));
  }
}
