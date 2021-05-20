import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_radio_button_group/flutter_radio_button_group.dart';
import 'package:light_master_app/core/models/app_model.dart';
import 'package:light_master_app/core/models/light.dart';
import 'package:light_master_app/core/models/light_source.dart';
import 'package:provider/provider.dart';

class AddLight extends StatefulWidget {
  // This class is the configuration for the state.
  // It holds the values (in this case nothing) provided
  // by the parent and used by the build  method of the
  // State. Fields in a Widget subclass are always marked
  // "final".

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<AddLight> {
  ButtonStyle _buttonStyle =
      ButtonStyle(minimumSize: MaterialStateProperty.all(Size.fromHeight(40)));
  Container _container = Container();
  String selected = "";

  void _manualAdd() {
    setState(() {
      _container = Container(
          child: Column(children: <Widget>[
        CupertinoTextField(
          textAlign: TextAlign.center,
          placeholder: 'Name',
        ),
        CupertinoTextField(
          textAlign: TextAlign.center,
          placeholder: 'IP-Address',
        )
      ]));
    });
  }

  void _autoDetect() {
    CircularProgressIndicator();
    Timer(Duration(seconds: 3), () {
      setState(() {
        _container = Container(
            child: Expanded(
                flex: 10,
                child: SingleChildScrollView(
                    child: FlutterRadioButtonGroup(
                        items: [
                      /*put your items here*/
                      "192.168.1.10",
                      "192.168.1.11",
                      "192.168.1.12",
                      "192.168.1.13",
                      "192.168.1.14",
                      "192.168.1.15",
                      "192.168.1.16",
                      "192.168.1.17",
                      "192.168.1.18",
                      "192.168.1.19",
                      "192.168.1.20",
                      "192.168.1.21",
                      "192.168.1.22",
                      "192.168.1.23",
                      "192.168.1.24",
                      "192.168.1.25",
                      "192.168.1.26",
                      "192.168.1.27",
                      "192.168.1.28",
                      "192.168.1.29",
                      "192.168.1.30",
                    ],
                        onSelected: (String selected) {
                          this.selected = selected;
                        }))));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called,
    // for instance, as done by the _increment method above.
    // The Flutter framework has been optimized to make
    // rerunning build methods fast, so that you can just
    // rebuild anything that needs updating rather than
    // having to individually changes instances of widgets.
    _autoDetect();
    return Container(
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(35),
                topRight: const Radius.circular(35))),
        height: 500,
        padding: EdgeInsets.only(bottom: 30),
        child: Stack(
          children: [
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(35),
                        topRight: const Radius.circular(35))),
                child: Consumer<AppModel>(builder: (context, model, child) {
                  //mainAxisAlignment: MainAxisAlignment.center,
                  return Stack(children: <Widget>[
                    ElevatedButton(
                        onPressed: _manualAdd,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.blue,
                          shadowColor: Colors.white,
                          elevation: 0,
                          minimumSize: Size(350, 50),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Text(' Add Lightsource')),
                    const Divider(
                      color: Colors.grey,
                      height: 20,
                      thickness: 1,
                      indent: 0,
                    ),
                    //Spacer(),
                    _container,
                    //Spacer(),
                    const Divider(
                      color: Colors.grey,
                      height: 20,
                      thickness: 1,
                      indent: 0,
                    ),
                    Spacer(),

                    ElevatedButton(
                        style: _buttonStyle,
                        onPressed: () {
                          model.addLightSource(
                            LightSource(
                                selected,
                                "Light ${model.lightSources.length}",
                                true,
                                SolidLight(Colors.blue[800])),
                          );
                          Navigator.pop(context);
                        },
                        child: Text('Save'))
                  ]);
                }))
          ],
        ));
  }
}
