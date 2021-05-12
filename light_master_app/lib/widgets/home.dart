import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:light_master_app/core/models/app_model.dart';
import 'package:light_master_app/core/models/light.dart';
import 'package:light_master_app/core/models/light_source.dart';
import 'package:light_master_app/widgets/add_light.dart';
import 'package:light_master_app/widgets/light_settings_sheet.dart';
import 'package:provider/provider.dart';
import 'package:light_master_app/widgets/cards.dart';

class Home extends StatelessWidget {
  bool mirror = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Consumer<AppModel>(builder: (context, model, child) {
      return CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
              largeTitle: Text('Lights'),
              trailing: TextButton(
                child: Text("Add"),
                onPressed: () => showCupertinoModalPopup(
                    context: context, builder: (BuildContext bc) => AddLight()),
              )),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 0.0,
              crossAxisSpacing: 0.0,
              childAspectRatio: 2.0,
              mainAxisExtent: 200.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      if (model.lightSources[index].item2.isTurnedOn) {
                        model.lightSources[index].item2.isTurnedOn = false;
                        print(
                            " ${model.lightSources[index].item1.name} with id:$index off");
                      } else {
                        model.lightSources[index].item2.isTurnedOn = true;
                        print(
                            " ${model.lightSources[index].item1.name} with id:$index on");
                      }
                    },
                    onLongPress: () {
                      print("opening color settings $index");
                      showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext bc) {
                            return LightSettingsSheet(
                              lightSource: model.lightSources[index].item1,
                            );
                          });
                    },
                    child: Cards(index, Colors.blue, false),
                  ),
                );
              },
              childCount: model.lightSources.length,
            ),
          ),
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
                                      side: BorderSide(color: Colors.blue)))),
                      onPressed: () => {
                            model.addLightSource(
                              LightSource(
                                  "1.1.1.1",
                                  "Light ${model.lightSources.length}",
                                  SolidLight(Colors.blue[800])),
                              Cards(index, Colors.blue, false),
                            )
                          },
                      child: Text("+")),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      );
    }));
  }
}
