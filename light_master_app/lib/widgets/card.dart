import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:light_master_app/core/models/light.dart';
import 'package:light_master_app/core/models/light_source.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:provider/provider.dart';

import 'light_settings_sheet.dart';

class LMCard extends StatelessWidget {
  final double turnedOnElevation = 12;
  final double turnedOffElevation = 0;
  final double childPadding = 35;
  final Color shadowColor = Colors.yellow;

  LightSource lightSource =
      LightSource("1.1.1.1", "Light 1", false, SolidLight(Colors.blue[800]));

  @override
  Widget build(BuildContext context) {
    return /*Consumer<LightSource>(
        builder: (context, lightSource, child) =>*/
        GestureDetector(
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
      child: Stack(children: [
        Container(
            width: 160,
            height: 160,
            child: Card(
              color: lightSource.isTurnedOn ? Colors.grey : shadowColor,
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(children: [
                Positioned(
                    left: 20,
                    bottom: 20,
                    right: 20,
                    child: Text("Light______aaaaaaaaa aaaaaaaaa aaaaaaa aaaaaa",
                        textAlign: TextAlign.center))
              ]),
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(35.0),
              )),
              elevation: lightSource.isTurnedOn ? 0 : 12,
              margin: EdgeInsets.all(10),
            )),
      ]),
    );
  }
}
