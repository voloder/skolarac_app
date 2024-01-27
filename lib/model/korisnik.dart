import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skolarac/model/ucesnik.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Korisnik extends ChangeNotifier {
  String? _ime;
  int? _avatar;

  // null safety :)
  String get ime => _ime ?? "Nepoznato ime";
  int get avatar => _avatar ?? 0;

  set ime(String ime) {
    _ime = ime;
    setPrefs();
    notifyListeners();
  }

  set avatar(int avatar) {
    _avatar = avatar;
    setPrefs();
    notifyListeners();
  }

  Future<void> getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _ime = prefs.getString("ime");
    _avatar = prefs.getInt("avatar");
  }

  Future<void> setPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("ime", _ime!);
    prefs.setInt("avatar", _avatar!);
  }

  sacuvan() {
    return _ime != null && _avatar != null;
  }

  napravi(String ime, bool spol) {
    _ime = ime;
    _avatar = Random().nextInt(4) + (spol ? 0 : 4);
    setPrefs();
    notifyListeners();
  }

  toJson() {
    return {
      "ime": _ime,
      "avatar": _avatar,
    };
  }

  Igrac toIgrac() {
    return Igrac(
      ime: _ime!,
      avatar: _avatar!,
      poeni: 0
    );
  }
 }