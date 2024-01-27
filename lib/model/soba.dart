import 'package:flutter/cupertino.dart';
import 'package:skolarac/model/korisnik.dart';
import 'package:skolarac/model/pitanje.dart';
import 'package:skolarac/model/ucesnik.dart';

class Soba extends ChangeNotifier {
  List<Igrac> igraci;
  String kod;
  int countdown = 0;
  String stanje = "cekanje";
  Pitanje? pitanje;
  int vrijemePitanja = 10;
  int vrijemeOtkrivanja = 5;
  int brojPitanja = 10;
  int trenutnoPitanje = 0;

  Soba({required this.igraci, required this.kod});

  toJson() {
    return {
      "igraci": igraci.map((igrac) => igrac.toJson()).toList(),
      "kod": kod,
    };
  }

  socketEvent(Map<String, dynamic> json) {
    igraci = json["igraci"].map<Igrac>((igrac) => Igrac.fromJson(igrac)).toList();
    kod = json["kod"];
    countdown = json["countdown"];
    stanje = json["stanje"];
    pitanje = json["pitanje"] != null ? Pitanje.fromJson(json["pitanje"]) : null;
    vrijemePitanja = json["vrijeme_pitanja"];
    vrijemeOtkrivanja = json["vrijeme_otkrivanja"];
    brojPitanja = json["broj_pitanja"];
    trenutnoPitanje = json["trenutno_pitanje"];
    notifyListeners();
  }

  factory Soba.fromJson(Map<String, dynamic> json) {
    return Soba(
      igraci: json["igraci"].map<Igrac>((igrac) => Igrac.fromJson(igrac)).toList(),
      kod: json["kod"],
    );
  }
}