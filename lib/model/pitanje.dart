import 'dart:convert';

class Pitanje {
   String pitanje;
   String a;
   String b;
   String c;
   String d;
   String tacan;

   Pitanje({
    required this.pitanje,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.tacan
  });

  factory Pitanje.fromJson(Map<String, dynamic> json) {
    return Pitanje(
      pitanje: json["pitanje"],
      a: json["a"],
      b: json["b"],
      c: json["c"],
      d: json["d"],
      tacan: json["tacan"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "pitanje": pitanje,
      "a": a,
      "b": b,
      "c": c,
      "d": d,
      "tacan": tacan,
    };
  }
}