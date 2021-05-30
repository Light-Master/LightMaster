import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_master_app/core/models/light_source.dart';
import 'package:light_master_app/modules/dashboard/bloc/add_light_bloc.dart';
import 'package:light_master_app/modules/dashboard/bloc/managed_light_source_bloc.dart';
import 'package:light_master_app/modules/dashboard/screens/add_light.dart';

import 'package:light_master_app/widgets/card.dart';

class Home extends StatelessWidget {
  int _lightCount = 0;
  @override
  Widget build(BuildContext context) {
    final _managedLightSourceBloc =
        BlocProvider.of<ManagedLightSourceBloc>(context);

    return CupertinoPageScaffold(
      // consumes model from app_model.dart
      child: CustomScrollView(slivers: <Widget>[
        CupertinoSliverNavigationBar(
            largeTitle: Text('Lights'),
            trailing: TextButton(
                child: Text("Add"),
                onPressed: () => showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(35),
                              topRight: const Radius.circular(35))),
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext bc) =>
                          MultiBlocProvider(providers: [
                        BlocProvider(create: (context) => AddLightBloc()),
                        BlocProvider.value(value: _managedLightSourceBloc)
                      ], child: AddLight()),
                    ))),
        BlocBuilder<ManagedLightSourceBloc, List<LightSource>>(
            builder: (BuildContext context, List<LightSource> state) {
          print("building with ${state.length} elements");
          return SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
              childAspectRatio: 2.0,
              mainAxisExtent: 185.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 20),
                  child: LMCard(state[index]),
                );
              },
              childCount: state.length,
            ),
          );
        }),
      ]),
    );
  }
}
