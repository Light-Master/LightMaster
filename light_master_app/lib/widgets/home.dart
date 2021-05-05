import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:light_master_app/core/models/app_model.dart';
import 'package:light_master_app/core/models/light_source.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Consumer<AppModel>(builder: (context, model, child) {
      final lightSources = model.lightSources;
      return CustomScrollView(
        semanticChildCount: lightSources.length + 2,
        slivers: [
          const CupertinoSliverNavigationBar(largeTitle: Text('Lights')),
          SliverSafeArea(
            top: false,
            minimum: const EdgeInsets.only(top: 8),
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              if (index < lightSources.length) {
                // TODO: return light widgets
                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red[500]),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Text("Lights '$index'"),
                );
              } else if (index == lightSources.length) {
                // for testing purposes
                return Row(mainAxisSize: MainAxisSize.min, children: [
                  Text("this is an example with ${model.lightSources.length}.")
                ]);
              } else if (index == lightSources.length + 1) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                        onPressed: () => model
                            .addLightSource(LightSource("1.1.1.1", "LS x")),
                        child: Text("click me I dare you"))
                  ],
                );
              } else {
                return null;
              }
            })),
          )
        ],
      );
    }));
  }
}
