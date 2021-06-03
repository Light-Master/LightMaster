import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_master_app/modules/dashboard/bloc/managed_light_source_bloc.dart';
import 'package:light_master_app/modules/dashboard/events/managed_light_source_event.dart';
import 'package:light_master_app/modules/dashboard/models/light.dart';
import 'package:light_master_app/modules/dashboard/models/light_source.dart';

import '../../../widgets/color_picker.dart';

class MonoLightSettings extends StatelessWidget {
  final double verticalMargin = 8;
  final double horizontalMargin = 10;
  LightSource lightSource;

  MonoLightSettings(this.lightSource);

  @override
  Widget build(BuildContext context) {
    var color = Colors.yellow[600];
    if (lightSource.light is SolidLight) {
      var light = lightSource.light as SolidLight;
      color = light.color;
    }
    final _managedLightSourceBloc =
        BlocProvider.of<ManagedLightSourceBloc>(context);

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
                  lightSource.light = SolidLight(newColor);
                  _managedLightSourceBloc
                      .add(ManagedLightSourceChangeColorEvent(lightSource));
                  // code previously:
                  // lightSource.light = SolidLight(newColor)
                }))
          ].toList()),
        )
      ],
    );
  }
}
