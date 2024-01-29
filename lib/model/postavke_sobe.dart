import 'package:skolarac/model/pitanje.dart';

class SobaPostavke {
  List<String> kategorije = [];
  int brojPitanja = 10;
  int vrijemePitanja = 15;
  int vrijemeOtkrivanja = 3;

  List<Pitanje> customPitanja = [];

  SobaPostavke({
    this.brojPitanja = 10,
    this.vrijemePitanja = 15,
    this.vrijemeOtkrivanja = 3,
  });

  toJson() {
    return {
      "broj_pitanja": brojPitanja,
      "vrijeme_pitanja": vrijemePitanja,
      "vrijeme_otkrivanja": vrijemeOtkrivanja,
      "kategorije": kategorije,
      "custom_pitanja": customPitanja.map((e) => e.toJson()).toList(),
    };
  }

 factory SobaPostavke.fromJson(Map<String, dynamic> json) {
   return SobaPostavke(
     brojPitanja: json["broj_pitanja"],
     vrijemePitanja: json["vrijeme_pitanja"],
     vrijemeOtkrivanja: json["vrijeme_otkrivanja"]
   );
 }
}