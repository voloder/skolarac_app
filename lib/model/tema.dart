import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TemaBoja { tamna, svijetla, auto }

class Tema extends ChangeNotifier {
  static TemaBoja boja = TemaBoja.auto;

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    boja = TemaBoja.values.firstWhere(
            (element) => element.name == (prefs.getString("tema") ?? "svijetla"), orElse: () => TemaBoja.svijetla);
  }

  setBoja(TemaBoja value) async {
    boja = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString("tema", value.name);
  }

  getBrightness() {
    if (boja == TemaBoja.auto) {
      return SchedulerBinding.instance.platformDispatcher.platformBrightness;
    } else {
      return boja == TemaBoja.tamna ? Brightness.dark : Brightness.light;
    }
  }

  ColorScheme getColorScheme() {
    bool tamna = false;

    getBrightness() == Brightness.dark ? tamna = true : tamna = false;

    if (tamna) {
      return ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: Color(0xFF31a062),
        surfaceTint: Colors.grey,
        primary: Color(0xFF30B074),
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
