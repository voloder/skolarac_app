import 'dart:convert';

class Biljeska {
  String naslov;
  String tekst;

  Biljeska({required this.naslov, required this.tekst});

  String toJson() {
    return jsonEncode({"naslov": naslov, "biljeska": tekst});
  }

  factory Biljeska.fromJson(String json) {
    final map = jsonDecode(json);
    return Biljeska(naslov: map["naslov"], tekst: map["biljeska"]);
  }
}