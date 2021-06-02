import 'package:bloc/bloc.dart';
import 'package:light_master_app/modules/dashboard/events/managed_light_source_event.dart';
import 'package:light_master_app/modules/dashboard/models/light_source.dart';

class ManagedLightSourceBloc
    extends Bloc<ManagedLightSourceEvent, List<LightSource>> {
  ManagedLightSourceBloc() : super([]);
  final List<LightSource> _lightSources = [];

  List<LightSource> get lightSources => _lightSources;

  @override
  Stream<List<LightSource>> mapEventToState(
      ManagedLightSourceEvent event) async* {
    if (event is ManagedLightSourceClearEvent)
      _lightSources.clear();
    else if (event is ManagedLightSourceAddEvent) {
      print("add event");
      _lightSources.add(event.lightSource);
    } else if (event is ManagedLightSourceChangeEvent) {
      int index = 0;
      print("change event");
      for (index; index < _lightSources.length; index++) {
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
