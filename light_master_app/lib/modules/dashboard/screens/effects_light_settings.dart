import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_master_app/modules/dashboard/bloc/managed_light_source_bloc.dart';
import 'package:light_master_app/modules/dashboard/events/managed_light_source_event.dart';
import 'package:light_master_app/modules/dashboard/models/light.dart';
import 'package:light_master_app/modules/dashboard/models/light_source.dart';
import 'package:light_master_app/widgets/slider.dart';

class EffectsLightSettings extends StatelessWidget {
  final defaultEffectLight = EffectLight(Effect.Android.toString(), 50, 50);

  final roundedCardDecoration = BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(16)));

  final sliderIconColor = CupertinoColors.darkBackgroundGray;
  final double sliderIconSize = 24;

  final double dividerHorizontalPadding = 15;
  LightSource lightSource;
  // end
  EffectsLightSettings(this.lightSource);

  @override
  Widget build(BuildContext context) {
    // start: debug code
    var effectLight = EffectLight(Effect.Android.toString(), 1, 1);
    final managedLightSourceBloc =
        BlocProvider.of<ManagedLightSourceBloc>(context);
    // was necessary since the state could not be altered while being
    // constructed, therefore the state alteration was scheduled via
    // the future callback. But this should now be solvable via your BLoC sink.
    // previous code:
    // if (lightSource.light is SolidLight) {
    //   Future.delayed(
    //       Duration.zero, () async => lightSource.light = defaultEffectLight);
    // }
    // var effectLight = lightSource is EffectLight
    //     ? lightSource.light as EffectLight
    //     : defaultEffectLight;

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
                                ), (newBrightness) {
                          // set new brightness value here

                          // previous code:
                          lightSource.light = EffectLight(effectLight.effect,
                              newBrightness, effectLight.speed);
                        }))
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
                                ), (newSpeed) {
                          // set the new speed value here

                          // previous code:
                          lightSource.light = EffectLight(effectLight.effect,
                              effectLight.brightness, newSpeed);
                        }))
                      ],
                    )
                  ],
                )))
      ]),
      Expanded(
          child: Container(
              decoration: roundedCardDecoration,
              margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 8),
              padding: EdgeInsets.only(top: 2, bottom: 2),
              child: BlocBuilder<ManagedLightSourceBloc, List<LightSource>>(
                  builder: (BuildContext context, List<LightSource> state) {
                int index = 0;
                for (; index < state.length; index++) {
                  if (state[index].id == lightSource.id) {
                    lightSource = state[index];
                    break;
                  }
                }
                return ListView(
                  children: Effect
                      .values // todo: load effects from WLED instance
                      .asMap()
                      .entries
                      .map((entry) {
                        var currentEffect = entry.value;
                        var firstEntry = entry.key == 0;

                        var listEntry = ListTile(
                            title: Text(
                              currentEffect.toString(),
                            ),
                            onTap: () {
                              var effectLight = lightSource.light is EffectLight
                                  ? lightSource.light as EffectLight
                                  : defaultEffectLight;
                              lightSource.light = EffectLight(
                                  currentEffect.toString(),
                                  effectLight.brightness,
                                  effectLight.speed);
                              managedLightSourceBloc.add(
                                  ManagedLightSourceChangeEvent(lightSource));
                            },
                            trailing: lightSource.light is EffectLight &&
                                    (lightSource.light as EffectLight).effect ==
                                        currentEffect
                                ? Icon(
                                    CupertinoIcons.checkmark_alt,
                                    color: Colors.blue,
                                  )
                                : null);

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
                );
              })))
    ]);
  }
}
