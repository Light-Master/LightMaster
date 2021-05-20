import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:light_master_app/core/models/app_model.dart';
import 'package:light_master_app/core/models/light.dart';
import 'package:light_master_app/core/models/light_source.dart';
import 'package:light_master_app/utils/services/http_rest.dart';
import 'package:light_master_app/utils/services/websocket_client.dart';
import 'package:light_master_app/widgets/add_light.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'card.dart';

class Home extends StatelessWidget {
  final httpClient = http.Client();
  JsonApiClient apiClient;

  @override
  Widget build(BuildContext context) {
    apiClient =
        JsonApiClient(baseUrl: "http://192.168.0.71", httpClient: httpClient);
    // apiClient.fetchEffects().then((value) => print(value));
    // apiClient.fetchPaletts().then((value) => print(value));

    var websocketClient = WebsocketApiClient(baseUrl: "http://192.168.0.71");
    websocketClient.stateStream.listen((event) {
      print(event.toString());
    });

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
                  child: ChangeNotifierProvider.value(
                      value: model.lightSources[index], child: LMCard()),
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
                                  true,
                                  SolidLight(Colors.blue[800])),
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
