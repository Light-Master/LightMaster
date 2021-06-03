import 'package:light_master_app/modules/dashboard/models/light_source.dart';

abstract class ManagedLightSourceEvent {}

class ManagedLightSourceAddEvent extends ManagedLightSourceEvent {
  String ip;
  ManagedLightSourceAddEvent(this.ip);
}

class ManagedLightSourceChangeEvent extends ManagedLightSourceEvent {
  ManagedLightSourceChangeEvent(LightSource lightSource) {
    _lightSource = lightSource;
  }
  LightSource _lightSource;
  get lightSource => _lightSource;
}

class ManagedLightSourceChangeNameEvent extends ManagedLightSourceEvent {
  ManagedLightSourceChangeNameEvent(LightSource lightSource) {
    _lightSource = lightSource;
  }
  LightSource _lightSource;
  get lightSource => _lightSource;
}

class ManagedLightSourceChangeColorEvent extends ManagedLightSourceEvent {
  ManagedLightSourceChangeColorEvent(LightSource lightSource) {
    _lightSource = lightSource;
  }
  LightSource _lightSource;
  get lightSource => _lightSource;
}

class ManagedLightSourceChangeEffectEvent extends ManagedLightSourceEvent {
  ManagedLightSourceChangeEffectEvent(LightSource lightSource) {
    _lightSource = lightSource;
  }
  LightSource _lightSource;
  get lightSource => _lightSource;
}

class ManagedLightSourceTurnEvent extends ManagedLightSourceEvent {
  ManagedLightSourceChangeEffectEvent(LightSource lightSource) {
    _lightSource = lightSource;
  }
  LightSource _lightSource;
  get lightSource => _lightSource;
}

class ManagedLightSourceRemoveEvent extends ManagedLightSourceEvent {
  ManagedLightSourceRemoveEvent(LightSource lightSource) {
    _lightSource = lightSource;
  }
  LightSource _lightSource;
  get lightSource => _lightSource;
}

class ManagedLightSourceClearEvent extends ManagedLightSourceEvent {
  ManagedLightSourceClearEvent();
}
