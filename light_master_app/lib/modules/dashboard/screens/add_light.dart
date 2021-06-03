import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_master_app/modules/dashboard/bloc/add_light_bloc.dart';
import 'package:light_master_app/modules/dashboard/bloc/managed_light_source_bloc.dart';
import 'package:light_master_app/modules/dashboard/events/managed_light_source_event.dart';
import 'package:light_master_app/modules/dashboard/models/light_source.dart';

class AddLight extends StatelessWidget {
  final roundedSheetRadius = BorderRadius.only(
      topLeft: const Radius.circular(35), topRight: const Radius.circular(35));
  final addressEditingController = TextEditingController();
  bool first = true;
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    final managedLightSourceBloc =
        BlocProvider.of<ManagedLightSourceBloc>(context);
    final addLightBloc = BlocProvider.of<AddLightBloc>(context);
    if (first) {
      addLightBloc.add(AddLightAutoDetectEvent());
      first = false;
    }
    return BlocBuilder<AddLightBloc, List<LightSource>>(
        builder: (BuildContext context, List<LightSource> state) {
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
                    state.length == 0
                        ? Column(children: [
                            Text(
                              "Auto Detect",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            CircularProgressIndicator()
                          ])
                        : SizedBox(
                            height: 307,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                                padding: EdgeInsets.only(top: 2, bottom: 2),
                                child: ListView(
                                  // TODO: replace with fetched addresses
                                  children: state
                                      .asMap()
                                      .entries
                                      .map((MapEntry<int, LightSource>
                                          lightEntry) {
                                        var index = lightEntry.key;
                                        var light = lightEntry.value;

                                        var lightTile = ListTile(
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(light.name),
                                                Container(
                                                    margin:
                                                        EdgeInsets.only(top: 3),
                                                    child: Text(
                                                        light.networkAddress,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[500],
                                                            fontSize: 12)))
                                              ],
                                            ),
                                            onTap: () {
                                              selected = index;
                                              addLightBloc.add(
                                                  AddLightSelectEvent(index));
                                            },
                                            trailing: index == selected
                                                ? Icon(
                                                    CupertinoIcons
                                                        .checkmark_alt,
                                                    color: Colors.blue,
                                                  )
                                                : null);

                                        return index == selected
                                            ? [lightTile]
                                            : [
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 15, right: 15),
                                                    child: Divider(
                                                        height: 1,
                                                        color:
                                                            Colors.grey[400])),
                                                lightTile
                                              ];
                                      })
                                      .expand((element) => element)
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
                                            : state[selected].networkAddress;

                                    // todo:
                                    // only pass network ip in addEvent, BloC can query
                                    // all configuration from repository later
                                    managedLightSourceBloc.add(
                                        ManagedLightSourceAddEvent(address));

                                    Navigator.pop(context);
                                  })))
                    ],
                  ),
                )
              ]));
    });
  }
}
