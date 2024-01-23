import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skolarac/model/ucesnik.dart';

class Korisnik extends ChangeNotifier {
  String _ime = "Nepoznato ime";
  int _avatar = 1;

  String get ime => _ime;
  int get avatar => _avatar;

  set ime(String ime) {
    _ime = ime;
    notifyListeners();
  }

  set avatar(int avatar) {
    _avatar = avatar;
    notifyListeners();
  }

  toJson() {
    return {
      "ime": _ime,
      "avatar": _avatar,
      "odabir": null,
      "poeni": 0
    };
  }

  Igrac toIgrac() {
    return Igrac(
      ime: _ime,
      avatar: _avatar,
      poeni: 0
    );
  }
 }