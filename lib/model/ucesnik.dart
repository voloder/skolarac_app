class Igrac {
  String ime;
  int avatar;
  int poeni;

  Igrac({
    required this.ime,
    required this.avatar,
    required this.poeni
});

  factory Igrac.fromJson(Map<String, dynamic> json) {
    return Igrac(ime: json["ime"], avatar: json["avatar"], poeni: json["poeni"]);
  }

  toJson() {
    return {
      "ime": ime,
      "avatar": avatar,
      "poeni": poeni
    };
  }
}