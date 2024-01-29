import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skolarac/backend.dart';
import 'package:skolarac/model/postavke_sobe.dart';
import 'package:skolarac/stranice/custom_pitanja.dart';
import 'package:skolarac/stranice/soba_page.dart';
import 'package:skolarac/widgeti/skolarac_dugme.dart';

class NovaIgra extends StatefulWidget {
  const NovaIgra({super.key});

  @override
  State<NovaIgra> createState() => _NovaIgraState();
}

class _NovaIgraState extends State<NovaIgra> {
  SobaPostavke postavke = SobaPostavke();
  int maxPitanja = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Hero(
            tag: "novaigra_naslov",
            child: Text("NOVA IGRA",
                style: Theme.of(context).textTheme.headline6!),
          ),
        ),
        body: ListView(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SkolaracDugme(
              onPressed: () {
                Backend().instance.kreirajSobu(context).then((s) {
                  // provider za sobu, tako da kada dodje do socket eventa, da se
                  // widget tree rebuilduje i da se prikaze novo stanje sobe
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                                create: (context) => s,
                                child: SobaPage(
                                  novaIgra: true,
                                  postakve: postavke,
                                ),
                              )));
                });
              },
              text: "KREIRAJ KVIZ",
            ),
            Divider(),
            Text(
              "KATEGORIJE",
              textAlign: TextAlign.center,
            ),
            FutureBuilder(
                future: Backend().instance.ucitajKategorije(),
                builder: (context, snapshot) {
                  if(snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final kategorije = snapshot.data!["kategorije"];

                  return buildKategorije([
                    ...kategorije,
                    {
                      "naziv": "Custom Pitanja",
                      "potkategorije": [
                        {
                          "naziv": "Custom Pitanja",
                          "broj": postavke.customPitanja.length
                        }
                      ]
                    }
                  ]);
                }),

            Divider(),
            Text(
              "Vrijeme pitanja: ${postavke.vrijemePitanja}s",
              textAlign: TextAlign.center,
            ),
            Slider(
              value: postavke.vrijemePitanja.toDouble(),
              max: 60,
              min: 5,
              divisions: 11,
              label: postavke.vrijemePitanja.toString(),
              onChanged: (double value) {
                setState(() {
                  postavke.vrijemePitanja = value.toInt();
                });
              },
            ),
            Divider(),
            Text(
              "Vrijeme otkrivanja: ${postavke.vrijemeOtkrivanja}s",
              textAlign: TextAlign.center,
            ),
            Slider(
              value: postavke.vrijemeOtkrivanja.toDouble(),
              max: 10,
              min: 1,
              divisions: 9,
              label: postavke.vrijemeOtkrivanja.toString(),
              onChanged: (double value) {
                setState(() {
                  postavke.vrijemeOtkrivanja = value.toInt();
                });
              },
            ),
            SkolaracDugme(
                text: "CUSTOM PITANJA",
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CustomPitanja(
                              postavke: postavke,
                            )))),
          ],
        ));
  }

  Widget buildKategorije(List<dynamic> kategorije) {
    maxPitanja = 0;
    for (var kategorija in kategorije) {
      for (var potkategorija in kategorija["potkategorije"]) {
        if(postavke.kategorije.contains(potkategorija["naziv"])) {
          maxPitanja += potkategorija["broj"] as int;
        }
      }
    }
    if(maxPitanja > 25) {
      maxPitanja = 25;
    }
    if(postavke.brojPitanja > maxPitanja) {
      postavke.brojPitanja = maxPitanja;
    }
    if(postavke.brojPitanja == 0) {
      postavke.brojPitanja = maxPitanja < 10 ? maxPitanja : 10;
    }
    if(maxPitanja == 0) {
      postavke.brojPitanja = 0;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var kategorija in kategorije) ...[
          Text(kategorija["naziv"]),
          Wrap(
            children: [
              for (var potkategorija in kategorija["potkategorije"])
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          if (!postavke.kategorije
                              .remove(potkategorija["naziv"])) {
                            postavke.kategorije.add(potkategorija["naziv"]);
                          }
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            postavke.kategorije.contains(potkategorija["naziv"])
                                ? Colors.green
                                : Colors.blueGrey),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      child: Text(
                        potkategorija["naziv"],
                        style: TextStyle(fontSize: 20),
                      )),
                )
            ],
          )
        ],
        Divider(),
        Text(
          "Broj pitanja: ${postavke.brojPitanja}",
          textAlign: TextAlign.center,
        ),
        Slider(
          value: postavke.brojPitanja.toDouble(),
          max: maxPitanja.toDouble(),
          min: maxPitanja > 1 ? 1 : maxPitanja.toDouble(),
          divisions: maxPitanja > 1 ? maxPitanja - 1 : 1,
          label: postavke.brojPitanja.toString(),
          onChanged: (double value) {
            setState(() {
              postavke.brojPitanja = value.toInt();
            });
          },
        ),
      ],
    );
  }
}
