import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio_button_group/flutter_radio_button_group.dart';
import 'package:light_master_app/modules/dashboard/models/light_source.dart';
import 'package:light_master_app/modules/dashboard/models/wled_client.dart';

enum AddLightEvent {manual_add, auto_detect, detected}

class AddLightBloc extends Bloc<AddLightEvent, Container> {
  AddLightBloc() : super(Container());
  final _client = WLedClient();

  @override
  Stream<Container> mapEventToState(AddLightEvent event) async* {
    switch (event) {
      case AddLightEvent.auto_detect:
        yield Container(child: CircularProgressIndicator());
        List<LightSource> leds = await _client.detectLeds();
        yield Container(
            child: Expanded(
                flex: 20,
                child: SingleChildScrollView(
                    child: FlutterRadioButtonGroup(
                  items: List<String>.generate(leds.length,
                      (i) => "${leds[i].name} (${leds[i].networkAddress})"),
                ))));
        break;
      case AddLightEvent.manual_add:
        yield Container(
            child: CupertinoTextField(
          textAlign: TextAlign.center,
          placeholder: 'IP',
        ));
        break;
    }
  }
}
