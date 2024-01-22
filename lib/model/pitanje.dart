class Pitanje {
  final String pitanje;
  final String a;
  final String b;
  final String c;
  final String d;
  final String tacan;

  const Pitanje({
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
}