import 'package:bloc/bloc.dart';
import 'package:light_master_app/core/models/light_source.dart';
import 'package:light_master_app/modules/dashboard/events/managed_light_source_event.dart';

class ManagedLightSourceBloc extends Bloc<ManagedLightSourceEvent, List<LightSource>>{
  ManagedLightSourceBloc() : super([]);
  final List<LightSource> _lightSources = [];

  List<LightSource> get lightSources => _lightSources;

  @override
  Stream<List<LightSource>> mapEventToState(ManagedLightSourceEvent event) async* {
    if(event is ManagedLightSourceClearEvent)
      _lightSources.clear();
    if(event is ManagedLightSourceAddEvent)
      _lightSources.add(event.lightSource);
    if(event is ManagedLightSourceChangeEvent) {
      int index = 0;
      for(index; index < _lightSources.length; index++){
        if(_lightSources[index].id == event.lightSource.id){
          _lightSources[index] = event.lightSource;
          break;
        }
      }
    }
    if(event is ManagedLightSourceRemoveEvent){
      _lightSources.remove(event.lightSource);
    }
    yield _lightSources;
  }

}
