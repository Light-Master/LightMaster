import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_master_app/modules/dashboard/bloc/managed_light_source_bloc.dart';
import 'package:light_master_app/modules/dashboard/events/managed_light_source_event.dart';
import 'package:light_master_app/modules/dashboard/models/light.dart';
import 'package:light_master_app/modules/dashboard/models/light_source.dart';

class AddLight extends StatelessWidget {
  final roundedSheetRadius = BorderRadius.only(
      topLeft: const Radius.circular(35), topRight: const Radius.circular(35));
  final addressEditingController = TextEditingController(text: 'IP');

  @override
  Widget build(BuildContext context) {
    // final addLightBloc = BlocProvider.of<AddLightBloc>(context);

    final managedLightSourceBloc =
        BlocProvider.of<ManagedLightSourceBloc>(context);

    return Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 225, 225, 225),
            borderRadius: roundedSheetRadius),
        height: 500,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 65,
                  decoration: BoxDecoration(
                      color: Colors.white, borderRadius: roundedSheetRadius),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Container(
                                alignment: Alignment.center,
                                child: Text('Add Light',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25))))
                      ])),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  Container(
                      color: Color.fromARGB(255, 225, 225, 225),
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Column(children: <Widget>[
                        Divider(
                          color: Color.fromARGB(0, 0, 0, 225),
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
                      padding:
                          EdgeInsets.only(top: 20.0, left: 20.0, bottom: 10.0),
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
