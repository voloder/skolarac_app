import 'package:flutter/cupertino.dart';
import 'package:skolarac/model/korisnik.dart';
import 'package:skolarac/model/pitanje.dart';
import 'package:skolarac/model/postavke_sobe.dart';
import 'package:skolarac/model/ucesnik.dart';

class Soba extends ChangeNotifier {
  List<Igrac> igraci;
  String kod;
  int countdown = 0;
  String stanje = "cekanje";
  Pitanje? pitanje;
  int trenutnoPitanje = 0;

  SobaPostavke postavke = SobaPostavke();

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
    postavke = SobaPostavke.fromJson(json["postavke"]);
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