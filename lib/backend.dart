import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:skolarac/model/korisnik.dart';
import 'package:skolarac/model/soba.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart';

class Backend {
  static String host = "localhost:8000";
  static String socketUrl = "http://localhost:8000/";

  static Backend? _instance;

  late IO.Socket socket;
  late Korisnik korisnik;

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
            body: jsonEncode(korisnik.toJson()));

    if (resp.statusCode != 200) {
      throw Exception("Greška pri ulasku u sobu, provjerite kôd");
    }

    Soba soba = Soba.fromJson(jsonDecode(resp.body));

    poveziSe(soba);

    return soba;
  }

  void poveziSe(Soba soba) {
    socket = IO.io(socketUrl, OptionBuilder()
        .setTransports(['websocket']).build());

    socket.connect();

    socket.onConnect((_) {
      socket.emit('msg', 'test');
    });

    socket.on(
        "soba_${soba.kod}",
        (data) {
              // kada dodju podaci, da se soba updatuje i obavijesti listenere
              print(data);
              soba.socketEvent(jsonDecode(data));
            });
  }

  void odaberiOdgovor(Soba soba, int odgovor) {
    socket.emit("odabir_${soba.kod}", {"odgovor": odgovor, "igrac": korisnik.toJson()});
  }
}
