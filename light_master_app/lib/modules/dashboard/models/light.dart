import 'dart:ui';

import 'package:flutter/material.dart';

abstract class Light {}

class SolidLight extends Light {
  final Color _color;

  SolidLight(this._color);

  Color get color => _color;
}

class EffectLight extends Light {
  final String effect;
  final int brightness;
  final int speed;

  EffectLight(this.effect, this.brightness, this.speed);
}

enum Effect {
  Android,
  Aurora,
  Blends,
  Blink,
  BlinkRainbow,
  BouncingBalls,
  Bpm,
  Breathe,
  Candle,
  CandleMulti,
  CandyCane,
  Chase,
  ChaseFlash,
  ChaseFlashRnd,
  ChaseRainbow,
  Chunchun,
  Circus,
  Colorful,
  Colorloop,
  Colotwinkles
}
