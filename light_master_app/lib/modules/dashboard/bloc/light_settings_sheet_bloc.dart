import 'package:bloc/bloc.dart';

enum LightSettingsSheetEvent { mono, effect }

class LightSettingsSheetBloc
    extends Bloc<LightSettingsSheetEvent, LightSettingsSheetEvent> {
  LightSettingsSheetBloc() : super(LightSettingsSheetEvent.mono);

  @override
  Stream<LightSettingsSheetEvent> mapEventToState(
      LightSettingsSheetEvent event) async* {
    yield event;
  }
}
