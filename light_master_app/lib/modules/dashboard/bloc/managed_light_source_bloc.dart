import 'package:bloc/bloc.dart';
import 'package:light_master_app/modules/dashboard/events/managed_light_source_event.dart';
import 'package:light_master_app/modules/dashboard/models/light_source.dart';
import 'package:light_master_app/modules/dashboard/repositories/light_master_repository.dart';

class ManagedLightSourceBloc
    extends Bloc<ManagedLightSourceEvent, List<LightSource>> {
  ManagedLightSourceBloc() : super([]);
  final List<LightSource> _lightSources = [];
  final _client = LightMasterRepository();

  List<LightSource> get lightSources => _lightSources;

  @override
  Stream<List<LightSource>> mapEventToState(
      ManagedLightSourceEvent event) async* {
    if (event is ManagedLightSourceClearEvent)
      _lightSources.clear();
    else if (event is ManagedLightSourceAddEvent) {
      print("add event");
      yield _lightSources;
      try {
        int index = 0;
        for (; index < _lightSources.length; index++) {
          if (_lightSources[index].networkAddress == event.ip) break;
        }
        if (index == _lightSources.length)
          _lightSources.add(await _client.getLightSource(event.ip));
      } catch (error) {
        print(error.toString());
      }
    } else if (event is ManagedLightSourceChangeEvent) {
      int index = 0;
      print("change event");
      for (; index < _lightSources.length; index++) {
        if (_lightSources[index].id == event.lightSource.id) {
          _lightSources[index] = event.lightSource;
          break;
        }
      }
    } else if (event is ManagedLightSourceChangeColorEvent) {
      int index = 0;
      print("change color event");
      _client.propagateLightSourceLight(event.lightSource);
      for (; index < _lightSources.length; index++) {
        if (_lightSources[index].id == event.lightSource.id) {
          _lightSources[index] = event.lightSource;
          break;
        }
      }
    } else if (event is ManagedLightSourceChangeNameEvent) {
      int index = 0;
      print("change name event");
      _client.propagateLightSourceLight(event.lightSource);
      for (; index < _lightSources.length; index++) {
        if (_lightSources[index].id == event.lightSource.id) {
          _lightSources[index] = event.lightSource;
          break;
        }
      }
    } else if (event is ManagedLightSourceTurnEvent) {
      int index = 0;
      print("turn event");
      _client.turnLight(event.lightSource);
      for (; index < _lightSources.length; index++) {
        if (_lightSources[index].id == event.lightSource.id) {
          _lightSources[index] = event.lightSource;
          break;
        }
      }
    } else if (event is ManagedLightSourceRemoveEvent) {
      print("remove event");
      _lightSources.remove(event.lightSource);
    }

    yield [..._lightSources];
  }
}
