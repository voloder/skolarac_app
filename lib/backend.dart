import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:skolarac/model/korisnik.dart';
import 'package:skolarac/model/postavke_sobe.dart';
import 'package:skolarac/model/soba.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart';

class Backend {
  //static String host = "localhost:8000";
  //static String socketUrl = "http://localhost:8000/";

  // AKO SAMI HOSTUJETE, PROMIJENITI HOST OVDJE!
  static String host = "xudev.io:8000";
  static String socketUrl = "http://$host/";

  static Backend? _instance;

  late IO.Socket socket;
  late Korisnik korisnik;
  Map<String, dynamic>? kategorije;

  // singleton
  Backend get instance {
    _instance ??= Backend();
    return _instance!;
  }

  Future<Soba> udjiUSobu(BuildContext context, String kod) async {
    korisnik = Provider.of<Korisnik>(context, listen: false);

    Map<String, dynamic> parametri = {
      "kod": kod,
    };

    http.Response resp =
        await http.post(Uri.http(host, "sobe/udji/", parametri),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(korisnik.toIgrac().toJson()));

    if (resp.statusCode != 200) {
      // todo prikazi popup
      throw Exception("Greška pri ulasku u sobu, provjerite kôd");
    }

    Soba soba = Soba.fromJson(jsonDecode(resp.body));

    poveziSe(soba);

    return soba;
  }

  void poveziSe(Soba soba, [VoidCallback? onConnect]) {
    socket = IO.io(socketUrl, OptionBuilder()
        .setTransports(['websocket']).build());

    socket.connect();

    socket.onConnect((data) {
      onConnect?.call();
    });

    socket.on(
        "soba_${soba.kod}",
        (data) {
              // kada dodju podaci, da se soba updatuje i obavijesti listenere
              print(data);
              soba.socketEvent(jsonDecode(data));
            });
  }

  void posaljiOdabir(Soba soba, int odgovor) {
    socket.emit("odabir_${soba.kod}", {"odgovor": odgovor, "igrac": korisnik.toJson()});
  }

  Future<Soba> kreirajSobu(BuildContext context) async {
    korisnik = Provider.of<Korisnik>(context, listen: false);

    http.Response resp = await http.post(Uri.http(host, "sobe/kreiraj/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },);

    if (resp.statusCode != 200) {
      throw Exception("Greška pri kreiranju sobe");
    }
    final kod = resp.body.replaceAll('"', '');

    Soba soba = Soba(kod: kod, igraci: [korisnik.toIgrac()]);

    await udjiUSobu(context, kod);
    poveziSe(soba);

    return soba;
  }

  Future<void> kreniIgru(Soba soba, SobaPostavke postavke) async {
    Map<String, dynamic> parametri = {
      "kod": soba.kod
    };

    http.Response resp = await http.post(Uri.http(host, "sobe/zapocni/", parametri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(postavke.toJson()));

    if (resp.statusCode != 200) {
      throw Exception("Greška pri kretanju");
    }
  }

  Future<void> napustiSobu(Soba soba) async {
    socket.disconnect();
    await http.post(Uri.http(host, "sobe/napusti/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(korisnik.toIgrac().toJson()));
  }

  Future<Map<String, dynamic>> ucitajKategorije() async {
    // kesiraj kategorije da ne moramo stalno ucitavati
    if(kategorije == null) {
      http.Response resp = await http.get(Uri.http(host, "kategorije/"));

      if (resp.statusCode != 200) {
        throw Exception("Greška pri ucitavanju kategorija");
      }
      kategorije = jsonDecode(utf8.decode(resp.bodyBytes));

    }

    return kategorije!;
  }
}
