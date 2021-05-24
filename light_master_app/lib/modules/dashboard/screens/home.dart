import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_master_app/core/models/app_model.dart';
import 'package:light_master_app/core/models/light.dart';
import 'package:light_master_app/core/models/light_source.dart';
import 'package:light_master_app/modules/dashboard/bloc/add_light_bloc.dart';
import 'package:light_master_app/modules/dashboard/bloc/managed_light_source_bloc.dart';
import 'package:light_master_app/modules/dashboard/events/managed_light_source_event.dart';
import 'package:light_master_app/modules/dashboard/screens/add_light.dart';

import '../../../widgets/card.dart';

class Home extends StatelessWidget {
  int _lightCount = 0;
  @override
  Widget build(BuildContext context) {
    final _managedLightSourceBloc = BlocProvider.of<ManagedLightSourceBloc>(context);
    AppModel model = AppModel();
    for (var i = 0; i < 5; i++) {
      model.addLightSource(
        LightSource("1.1.1.1", "Light ${model.lightSources.length}", true,
            SolidLight(Colors.blue[800])),
      );
    }
    return CupertinoPageScaffold(
        // consumes model from app_model.dart
        child: CustomScrollView(
          slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text('Lights'),
            trailing: TextButton(
              child: Text("Add"),
              onPressed: () => showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext bc) => BlocProvider(
                create: (BuildContext context) => AddLightBloc(),
                child: AddLight(),
              )),
            )),
          BlocBuilder<ManagedLightSourceBloc, List<LightSource>>(
            builder: (BuildContext context, List<LightSource> state){
              return SliverGrid(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200.0,
                        mainAxisSpacing: 0.0,
                        crossAxisSpacing: 0.0,
                        childAspectRatio: 2.0,
                        mainAxisExtent: 200.0,
                        ),
                        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                          return Container(
                            alignment: Alignment.center,
                            child: LMCard(),
                          );},
                          childCount: state.length,
                          ),
                      );
            }),
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.blue)
                        )
                      )
                  ),
                onPressed: () {
                  _managedLightSourceBloc.add(
                    ManagedLightSourceAddEvent(
                      LightSource(
                        "1.1.1.${_lightCount+1}",
                        "Light ${_lightCount}",
                        true,
                        SolidLight(Colors.blue[800])
                      ),
                  ));
                  _lightCount = _lightCount + 1;
                },
                  child: Text("+")),
              );
            },
          childCount: 1,
          ),),
    ]),
    );
  }
}
