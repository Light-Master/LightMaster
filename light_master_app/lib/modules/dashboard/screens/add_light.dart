import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_master_app/modules/dashboard/bloc/managed_light_source_bloc.dart';
import 'package:light_master_app/modules/dashboard/events/managed_light_source_event.dart';
import 'package:light_master_app/modules/dashboard/models/light.dart';
import 'package:light_master_app/modules/dashboard/models/light_source.dart';
import 'package:tuple/tuple.dart';

class AddLight extends StatelessWidget {
  final roundedSheetRadius = BorderRadius.only(
      topLeft: const Radius.circular(35), topRight: const Radius.circular(35));
  final addressEditingController = TextEditingController();

  final debugNetworkAddresses = [
    Tuple2("Instance 1", "8.70.129.107"),
    Tuple2("Instance 2", "195.165.111.105"),
    Tuple2("Instance 3", "233.76.207.248"),
    Tuple2("Instance 4", "45.102.68.169"),
    Tuple2("Instance 5", "48.105.22.76"),
    Tuple2("Instance 6", "78.222.118.231"),
    Tuple2("Instance 7", "251.119.177.152"),
    Tuple2("Instance 8", "65.153.60.226"),
    Tuple2("Instance 9", "116.222.230.13"),
    Tuple2("Instance 10", "83.22.167.64"),
    Tuple2("Instance 11", "211.26.235.252"),
    Tuple2("Instance 12", "97.34.228.57"),
    Tuple2("Instance 13", "70.56.50.122"),
    Tuple2("Instance 14", "171.27.87.132"),
    Tuple2("Instance 15", "166.108.153.126")
  ];

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
                    children: [
                      Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              child: Text('Add Light',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25))))
                    ],
                  )),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: CupertinoTextField(
                        placeholder: "Enter Network IP manually",
                        controller: addressEditingController,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        textAlign: TextAlign.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                      )),
                  SizedBox(
                      height: 307,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          // TODO: add auto search function to locate nearby lights on the network
                          child: ListView(
                            children: debugNetworkAddresses
                                .map((ad) => ListTile(
                                    title: Text("${ad.item1} (${ad.item2})")))
                                .toList(),
                          )))
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
