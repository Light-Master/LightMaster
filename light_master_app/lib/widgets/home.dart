import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:light_master_app/core/models/app_model.dart';
import 'package:light_master_app/core/models/light.dart';
import 'package:light_master_app/core/models/light_source.dart';
import 'package:light_master_app/widgets/add_light.dart';
import 'package:light_master_app/widgets/light_settings_sheet.dart';
import 'package:provider/provider.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class Home extends StatelessWidget {
  bool mirror = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Consumer<AppModel>(builder: (context, model, child) {
      final lightSources = model.lightSources;
      return CustomScrollView(
        // TODO: remove +2
        semanticChildCount: lightSources.length + 2,
        slivers: [
          CupertinoSliverNavigationBar(
              largeTitle: Text('Lights'),
              trailing: TextButton(
                child: Text("Add"),
                onPressed: () => showCupertinoModalPopup(
                    context: context, builder: (BuildContext bc) => AddLight()),
              )),
          SliverSafeArea(
            top: false,
            minimum: const EdgeInsets.only(top: 8),
            sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              if (index < lightSources.length) {
                // TODO: return fancy light widgets
                return GestureDetector(
                    onTap: () {
                      print(
                          " ${model.lightSources[index].item1.name} at $index");
                    },
                    onLongPress: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(35),
                                  topRight: const Radius.circular(35))),
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext bc) {
                            return LightSettingsSheet(
                              lightSource: lightSources[index].item1,
                            );
                          });
                    },
                    child: Text(
                        "test") /*Stack(children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          children: [
                            //ImageCard Example
                            ImageCard(
                              elevation: 12,
                              childPadding: 40,
                              shadowColor: Colors.green,
                              image: Image.network(
                                'https://miro.medium.com/max/85/1*ilC2Aqp5sZd1wi0CopD1Hw.png',
                              ),
                            ),
                            ImageCard(
                              elevation: 8,
                              shadowColor: Colors.red,
                              childPadding: 40,
                              color: Colors.yellow,
                              image: Image.network(
                                'https://miro.medium.com/max/85/1*ilC2Aqp5sZd1wi0CopD1Hw.png',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ])*/
                    );
              } else if (index == lightSources.length) {
                // TODO: for testing purposes, rm later
                return Align(
                    child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: BorderSide(color: Colors.blue)))),
                        onPressed: () => {
                              model.addLightSource(
                                  LightSource(
                                      "1.1.1.1",
                                      "Light ${lightSources.length}",
                                      SolidLight(Colors.blue[800])),
                                  mirror)
                            },
                        child: Text("+"))
                  ],
                ));
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
