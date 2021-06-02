import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_radio_button_group/flutter_radio_button_group.dart';
import 'package:light_master_app/modules/dashboard/bloc/add_light_bloc.dart';
import 'package:light_master_app/core/models/light.dart';
import 'package:light_master_app/core/models/light_source.dart';
import 'package:light_master_app/modules/dashboard/bloc/managed_light_source_bloc.dart';
import 'package:light_master_app/modules/dashboard/events/managed_light_source_event.dart';

class AddLight extends StatelessWidget {
  final addressEditingController = TextEditingController(text: 'IP');

  @override
  Widget build(BuildContext context) {
    // final addLightBloc = BlocProvider.of<AddLightBloc>(context);

    final managedLightSourceBloc =
        BlocProvider.of<ManagedLightSourceBloc>(context);

    // FlutterRadioButtonGroup detected = FlutterRadioButtonGroup(
    //     items: [
    //       /*put your items here*/
    //       "192.168.1.10",
    //       "192.168.1.11",
    //       "192.168.1.12",
    //       "192.168.1.13",
    //       "192.168.1.14",
    //       "192.168.1.15",
    //       "192.168.1.16",
    //       //"192.168.1.17",
    //       //"192.168.1.18",
    //       //"192.168.1.19",
    //       //"192.168.1.20",
    //       //"192.168.1.21",
    //       //"192.168.1.22",
    //       //"192.168.1.23",
    //       //"192.168.1.24",
    //       //"192.168.1.25",
    //       //"192.168.1.26",
    //       //"192.168.1.27",
    //       //"192.168.1.28",
    //       //"192.168.1.29",
    //       //"192.168.1.30",
    //     ],
    //     onSelected: (String selected) {
    //       _selected = selected;
    //     });

    return Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 225, 225, 225),
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(35),
                topRight: const Radius.circular(35))),
        height: 500,
        child: Column(children: <Widget>[
          Container(
              height: 65,
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Text('Add Light',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25))),
          Expanded(
              child: SingleChildScrollView(
            child: Column(children: <Widget>[
              Container(
                  color: Color.fromARGB(255, 225, 225, 225),
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(children: <Widget>[
                    Divider(
                      color: Color.fromARGB(255, 225, 225, 225),
                      height: 10,
                      thickness: 1,
                      indent: 0,
                    ),
                    CupertinoTextField(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      textAlign: TextAlign.center,
                      controller: addressEditingController,
                      placeholder: "Address",
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
                  child: Text("wow"))
            ]),
          )),
          Container(
            color: Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 12.5, right: 12.5),
                        child: TextButton(
                            child: Text('Add'),
                            style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor:
                                    Color.fromARGB(255, 116, 128, 255)),
                            onPressed: () {
                              String address =
                                  this.addressEditingController.text != ""
                                      ? this.addressEditingController.text
                                      : "Effect wow";

                              // todo:
                              // only pass network ip in addEvent, BloC can query
                              // all configuration from repository later
                              managedLightSourceBloc.add(
                                  ManagedLightSourceAddEvent(LightSource(
                                      address,
                                      "Light name",
                                      true,
                                      SolidLight(Colors.blue[800]))));

                              Navigator.pop(context);
                            })))
              ],
            ),
          )
        ]));
  }
}
