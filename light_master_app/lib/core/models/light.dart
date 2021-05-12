import 'dart:ui';

import 'package:flutter/material.dart';

abstract class Light {}

class SolidLight extends Light {
  final Color color;

  SolidLight(this.color);
}

class EffectLight extends Light {
  final String effect;

  EffectLight(this.effect);
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
