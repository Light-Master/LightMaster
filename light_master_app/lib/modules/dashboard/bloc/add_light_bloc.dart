import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio_button_group/flutter_radio_button_group.dart';
import 'package:light_master_app/modules/dashboard/models/light_source.dart';
import 'package:light_master_app/modules/dashboard/models/wled_client.dart';
import 'package:light_master_app/modules/dashboard/repositories/discover_devices.dart';
import 'package:light_master_app/modules/dashboard/repositories/wled_rest_client.dart';
import 'package:http/http.dart' as http;

class AddLightEvent{}
class AddLightAutoDetectEvent extends AddLightEvent{}
class AddLightDetectedEvent extends AddLightEvent{
  List<LightSource> lightSources;
  AddLightDetectedEvent(this.lightSources);
}
class AddLightSelectEvent extends AddLightEvent{
  int id;
  AddLightSelectEvent(this.id);
}

class AddLightBloc extends Bloc<AddLightEvent, List<LightSource>> {
  AddLightBloc() : super([]);
  List<LightSource> _lightSources = [];
  int selected;

  void autoDetect() async
  {
    try {
      final devices = WLEDDiscoveryModel(
          WledRestClient(httpClient: http.Client()));
      final currentList = devices.discoveredServices;
      // use ChangeNotifier
      devices.addListener(() {
        mapEventToState(AddLightDetectedEvent(devices.discoveredServices));
      });
    }
    catch(error){
      print(error.toString());
    }

  }

  @override
  Stream<List<LightSource>> mapEventToState(AddLightEvent event) async* {
    if(event is AddLightAutoDetectEvent)
      autoDetect();

    if(event is AddLightDetectedEvent)
      _lightSources = event.lightSources;

    if(event is AddLightSelectEvent)
      selected = event.id;

    yield [..._lightSources];

  }
}