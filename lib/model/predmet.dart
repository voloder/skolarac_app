import 'dart:convert';

class Predmet {
  String naziv;
  List<int> ocjene = [];

  double get prosjek => ocjene.isEmpty ? 0 : ocjene.reduce((a, b) => a + b) / ocjene.length;

  Predmet({required this.naziv, List<int> ocjene = const []}) {
    this.ocjene = ocjene;
  }

  String toJson() {
    return jsonEncode({"naziv": naziv, "ocjene": ocjene});
  }

  factory Predmet.fromJson(String json) {
    final map = jsonDecode(json);
    return Predmet(naziv: map["naziv"], ocjene: List<int>.from(map["ocjene"]));
  }
}