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
    final double topPadding = 15;
    final double sidePadding = 45;

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            Text("Test 1"),
            Text("Test 2"),
            Text("Test 3"),
            Text("Test 4"),
            // SizedBox(
            //     height: 500,
            //     child: Consumer<LightSource>(
            //       builder: (builder, lightSource, child) => LMColorPicker(
            //           (lightSource.light as SolidLight).color,
            //           (newColor) =>
            //               lightSource.light = SolidLight(newColor)),
            //     ))
          ].toList()),
        )
      ],
    );

    // return Container(
    //     margin: EdgeInsets.only(top: 5, bottom: 5),
    //     color: Color.fromARGB(255, 225, 225, 225),
    //     child: CustomScrollView(
    //       scrollDirection: Axis.vertical,
    //       slivers: [
    //         SliverList(
    //           delegate: SliverChildListDelegate([
    //             Container(
    //               padding: EdgeInsets.only(top: 8, bottom: 8),
    //               child: Column(
    //                   mainAxisSize: MainAxisSize.min,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Container(
    //                         margin:
    //                             EdgeInsets.only(left: margin, right: margin),
    //                         padding: EdgeInsets.only(
    //                             top: topPadding,
    //                             left: sidePadding,
    //                             right: sidePadding),
    //                         height: 458 + topPadding,
    //                         decoration: BoxDecoration(
    //                             color: Colors.white,
    //                             borderRadius:
    //                                 BorderRadius.all(Radius.circular(16))),
    //                         child: Consumer<LightSource>(
    //                           builder: (builder, lightSource, child) =>
    //                               LMColorPicker(
    //                                   (lightSource.light as SolidLight).color,
    //                                   (newColor) => lightSource.light =
    //                                       SolidLight(newColor)),
    //                         )),
    //                   ]),
    //             )
    //           ].toList()),
    //         )
    //       ],
    //     ));
  }
}
