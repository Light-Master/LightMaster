import 'dart:ffi';

import 'package:light_master_app/core/models/light_source.dart';

abstract class ManagedLightSourceEvent {}

class ManagedLightSourceAddEvent extends ManagedLightSourceEvent {
  ManagedLightSourceAddEvent(LightSource lightSource) {
    _lightSource = lightSource;
  }
  LightSource _lightSource;
  get lightSource => _lightSource;
}

class ManagedLightSourceChangeEvent extends ManagedLightSourceEvent {
  ManagedLightSourceChangeEvent(LightSource lightSource) {
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
