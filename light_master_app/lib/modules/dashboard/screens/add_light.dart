import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_radio_button_group/flutter_radio_button_group.dart';
import 'package:light_master_app/modules/dashboard/bloc/add_light_bloc.dart';
import 'package:light_master_app/core/models/app_model.dart';
import 'package:light_master_app/core/models/light.dart';
import 'package:light_master_app/core/models/light_source.dart';
import 'package:provider/provider.dart';

class AddLight extends StatelessWidget {
  ButtonStyle _buttonStyle = ButtonStyle(
      minimumSize: MaterialStateProperty.all(Size.fromHeight(50)),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue));
  String selected = "";

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called,
    // for instance, as done by the _increment method above.
    // The Flutter framework has been optimized to make
    // rerunning build methods fast, so that you can just
    // rebuild anything that needs updating rather than
    // having to individually changes instances of widgets.

    final _addLightBloc = BlocProvider.of<AddLightBloc>(context);

    //_autoDetect();
    return Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 225, 225, 225),
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(35),
                topRight: const Radius.circular(35))),
        height: 500,
        padding: EdgeInsets.only(bottom: 20),
        child: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Text('Add new light',
                  style: new TextStyle(color: Colors.black, fontSize: 25.0))),
          Expanded(
              child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Container(
                  color: Color.fromARGB(255, 225, 225, 225),
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(children: <Widget>[
                    CupertinoTextField(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      textAlign: TextAlign.center,
                      placeholder: 'Name',
                    ),
                    Divider(
                      color: Color.fromARGB(255, 225, 225, 225),
                      height: 10,
                      thickness: 1,
                      indent: 0,
                    ),
                    CupertinoTextField(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      textAlign: TextAlign.center,
                      placeholder: 'IP-Address',
                    ),
                    Divider(
                      color: Color.fromARGB(255, 225, 225, 225),
                      height: 10,
                      thickness: 1,
                      indent: 0,
                    ),
                  ])),
              Container(
                  color: Colors.white70,
                  padding: EdgeInsets.only(top: 20.0, left: 20.0, bottom: 10.0),
                  // TODO: add auto search function to locate nearby lights on the network
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
                      }))
            ]),
          )),
          Container(
              padding: EdgeInsets.only(top: 20, bottom: 0, left: 20, right: 20),
              child: ElevatedButton(
                  style: _buttonStyle,
                  onPressed: () {
                    /*
                      model.addLightSource(
                        LightSource(
                            selected,
                            "Light ${model.lightSources.length}",
                            true,
                            SolidLight(Colors.yellow)),
                      );*/
                    Navigator.pop(context);
                  },
                  child: Text('Save',
                      style: new TextStyle(
                          color: Color.fromARGB(255, 225, 225, 225),
                          fontSize: 15.0))))
        ]));
  }
}
