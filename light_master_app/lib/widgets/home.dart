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
                // TODO: return fancy light widgets
                return GestureDetector(
                    onTap: () {
                      print("switching lights status $index");
                    },
                    onLongPress: () {
                      print("opening color settings $index");
                      showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext bc) {
                            return Container(
                                height: 150,
                                color: Colors.white,
                                child: new Column(children: [
                                  Row(children: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text("Close this"))
                                  ]),
                                  Row(children: [
                                    Text("Text 1"),
                                    Text("Text 1"),
                                    Text("Text 1"),
                                    Text("Text 1"),
                                    Text("Text 1"),
                                  ])
                                ]));
                          });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red[500]),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      width: 150,
                      child: Text("Light $index"),
                    ));
              } else if (index == lightSources.length) {
                // for testing purposes, rm later
                return Row(mainAxisSize: MainAxisSize.min, children: [
                  Text("this is an example with ${model.lightSources.length}.")
                ]);
              } else if (index == lightSources.length + 1) {
                // for testing purposes, rm later
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
