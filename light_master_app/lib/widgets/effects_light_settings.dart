import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:light_master_app/core/models/light.dart';
import 'package:light_master_app/core/models/light_source.dart';
import 'package:light_master_app/widgets/slider.dart';
import 'package:provider/provider.dart';

class EffectsLightSettings extends StatelessWidget {
  final roundedCardDecoration = BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(16)));

  final sliderIconColor = CupertinoColors.darkBackgroundGray;
  final double sliderIconSize = 24;

  @override
  Widget build(BuildContext context) {
    return Consumer<LightSource>(
        builder: (builder, lightSource, child) => Column(children: [
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
                                        0,
                                        100,
                                        Icon(
                                          CupertinoIcons.brightness,
                                          color: sliderIconColor,
                                          size: sliderIconSize,
                                        ),
                                        (newValue) => print(
                                            "setting effect brightness to $newValue")))
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: LMSlider(
                                        0,
                                        100,
                                        Icon(
                                          CupertinoIcons.speedometer,
                                          color: sliderIconColor,
                                          size: sliderIconSize,
                                        ),
                                        (newValue) => print(
                                            "setting effect speed to $newValue")))
                              ],
                            )
                          ],
                        )))
              ]),
              Expanded(
                  child: Container(
                      decoration: roundedCardDecoration,
                      margin: EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 8),
                      child: ListView(
                        children: Effect.values
                            .map((e) => ListTile(
                                title: Text(
                                  e.toString(),
                                ),
                                trailing: (Icon(
                                  CupertinoIcons.checkmark_alt,
                                  color: Colors.blue,
                                ))))
                            .toList(),
                      )))
            ]));
    // Consumer<LightSource>(
    //     builder: (builder, lightSource, child) => Material(
    //         child: ListView(
    //             children: Effect.values
    //                 .map((e) => ListTile(
    //                     title: Text(
    //                       e.toString(),
    //                     ),
    //                     trailing: (Icon(
    //                       CupertinoIcons.checkmark_alt,
    //                       color: Colors.blue,
    //                     ))))
    //                 .toList())))
  }
}

// class _EffectsLightSettingsState extends State<EffectsLightSettings> {
//   final List<String> effects = [
//     "Solid",
//     "Effect1",
//     "Effect2",
//     "Effect3",
//     "Effect4",
//     "Effect5",
//     "Effect6",
//     "Effect7",
//     "Effect8",
//     "Effect9",
//     "Effect10",
//     "Effect12",
//     "Effect13",
//     "Effect14",
//     "Effect15",
//     "Effect16",
//     "Effect17",
//     "Effect18",
//     "Effect19"
//   ];
//   int selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
// return Material(
//     child: ListView.builder(
//   // Let the ListView know how many items it needs to build.
//   itemCount: effects.length,
//   // Provide a builder function. This is where the magic happens.
//   // Convert each item into a widget based on the type of item it is.
//   itemBuilder: (context, index) {
//     final item = effects[index];
//     return Column(
//       children: <Widget>[
//         ListTile(
//           title: Text(item),
//           trailing: selectedIndex == index
//               ? Icon(
//                   CupertinoIcons.check_mark,
//                   color: Colors.blue,
//                 )
//               : null,
//           onTap: () => setState(() {
//             selectedIndex = index;
//           }),
//         ),
//         Divider(), //                           <-- Divider
//       ],
//     );
//   },
// ));
//   }
// }
