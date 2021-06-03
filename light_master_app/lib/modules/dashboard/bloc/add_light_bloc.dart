import 'package:bloc/bloc.dart';
import 'package:light_master_app/modules/dashboard/models/light_source.dart';
import 'package:light_master_app/modules/dashboard/repositories/light_master_repository.dart';

class AddLightEvent {}

class AddLightAutoDetectEvent extends AddLightEvent {}

class AddLightDetectedEvent extends AddLightEvent {
  List<LightSource> lightSources;
  AddLightDetectedEvent(this.lightSources);
}

class AddLightSelectEvent extends AddLightEvent {
  int id;
  AddLightSelectEvent(this.id);
}

class AddLightBloc extends Bloc<AddLightEvent, List<LightSource>> {
  AddLightBloc() : super([]);
  List<LightSource> _lightSources = [];
  int selected;
  final LightMasterRepository _repo = LightMasterRepository();

  void autoDetect() async {
    try {
      _repo.getAutoDiscoveredLightSources().listen((list) {
        add(AddLightDetectedEvent(list));
      });
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Stream<List<LightSource>> mapEventToState(AddLightEvent event) async* {
    if (event is AddLightAutoDetectEvent) autoDetect();

    if (event is AddLightDetectedEvent) _lightSources = event.lightSources;

    if (event is AddLightSelectEvent) selected = event.id;

    yield [..._lightSources];
  }
}
