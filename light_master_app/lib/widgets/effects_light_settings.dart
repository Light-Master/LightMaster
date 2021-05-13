import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:light_master_app/core/models/light.dart';
import 'package:light_master_app/core/models/light_source.dart';
import 'package:light_master_app/widgets/slider.dart';
import 'package:provider/provider.dart';

class EffectsLightSettings extends StatelessWidget {
  final defaultEffectLight = EffectLight(Effect.Android, 50, 50);

  final roundedCardDecoration = BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(16)));

  final sliderIconColor = CupertinoColors.darkBackgroundGray;
  final double sliderIconSize = 24;

  final double dividerHorizontalPadding = 15;

  @override
  Widget build(BuildContext context) {
    return Consumer<LightSource>(builder: (builder, lightSource, child) {
      if (lightSource.light is SolidLight) {
        Future.delayed(
            Duration.zero, () async => lightSource.light = defaultEffectLight);
      }
      var effectLight = lightSource is EffectLight
          ? lightSource.light as EffectLight
          : defaultEffectLight;
      return Column(children: [
        Row(children: [
          Expanded(
              child: Container(
                  decoration: roundedCardDecoration,
                  margin: EdgeInsets.only(top: 8, left: 10, right: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: LMSlider(
                                  effectLight.brightness,
                                  0,
                                  100,
                                  Icon(
                                    CupertinoIcons.brightness,
                                    color: sliderIconColor,
                                    size: sliderIconSize,
                                  ),
                                  (newBrightness) => lightSource.light =
                                      EffectLight(effectLight.effect,
                                          newBrightness, effectLight.speed)))
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: LMSlider(
                                  effectLight.speed,
                                  0,
                                  100,
                                  Icon(
                                    CupertinoIcons.speedometer,
                                    color: sliderIconColor,
                                    size: sliderIconSize,
                                  ),
                                  (newSpeed) => lightSource.light = EffectLight(
                                      effectLight.effect,
                                      effectLight.brightness,
                                      newSpeed)))
                        ],
                      )
                    ],
                  )))
        ]),
        Expanded(
            child: Container(
                decoration: roundedCardDecoration,
                margin:
                    EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 8),
                child: ListView(
                  children: Effect.values
                      .asMap()
                      .entries
                      .map((entry) {
                        var currentEffect = entry.value;
                        var firstEntry = entry.key == 0;

                        var listEntry = Material(
                            child: ListTile(
                                title: Text(
                                  currentEffect.toString(),
                                ),
                                onTap: () {
                                  var effectLight =
                                      lightSource.light as EffectLight;
                                  lightSource.light = EffectLight(
                                      currentEffect,
                                      effectLight.brightness,
                                      effectLight.speed);
                                },
                                trailing: lightSource.light is EffectLight &&
                                        (lightSource.light as EffectLight)
                                                .effect ==
                                            currentEffect
                                    ? Icon(
                                        CupertinoIcons.checkmark_alt,
                                        color: Colors.blue,
                                      )
                                    : null));

                        if (firstEntry) {
                          return [listEntry];
                        } else {
                          return [
                            Padding(
                                padding: EdgeInsets.only(
                                    left: dividerHorizontalPadding,
                                    right: dividerHorizontalPadding),
                                child: Divider(
                                    height: 1, color: Colors.grey[400])),
                            listEntry
                          ];
                        }
                      })
                      .expand((element) => element)
                      .toList(),
                )))
      ]);
    });
  }
}
