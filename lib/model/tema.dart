import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

enum TemaBoja { tamna, svijetla, auto }

class Tema extends ChangeNotifier {
  TemaBoja _boja = TemaBoja.svijetla;

  TemaBoja get boja => _boja;

  set boja(TemaBoja value) {
    _boja = value;
    notifyListeners();
  }

  ColorScheme getColorScheme() {
    bool tamna = false;

    if (_boja == TemaBoja.auto) {
      tamna = SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
    } else {
      tamna = _boja == TemaBoja.tamna;
    }

    if (tamna) {
      return ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: Color(0xFF31a062),
        surfaceTint: Colors.grey,
        primary: Colors.greenAccent,
        onPrimary: Colors.black,
      );
    } else {
      return ColorScheme.fromSeed(
        seedColor: Color(0xFF31a062),
        primary: Color(0xFF31a062),
        background: Color(0xFFf6f6f9),
        surfaceTint: Color(0xFFf6f6f9),
        onInverseSurface: Colors.white,
      );
    }
  }
}
