import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skolarac/backend.dart';
import 'package:skolarac/model/postavke_sobe.dart';
import 'package:skolarac/stranice/soba_page.dart';
import 'package:skolarac/widgeti/skolarac_dugme.dart';

class NovaIgra extends StatefulWidget {
  const NovaIgra({super.key});

  @override
  State<NovaIgra> createState() => _NovaIgraState();
}

class _NovaIgraState extends State<NovaIgra> {
  SobaPostavke postavke = SobaPostavke();

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
                Backend().instance.kreirajSobu(context, postavke).then((s) {
                  // provider za sobu, tako da kada dodje do socket eventa, da se
                  // widget tree rebuilduje i da se prikaze novo stanje sobe
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                                create: (context) => s,
                                child: const SobaPage(
                                  novaIgra: true,
                                ),
                              )));
                });
              },
              text: "KREIRAJ KVIZ",
            ),
            Divider(),
            Text("KATEGORIJE", textAlign: TextAlign.center,),
            FutureBuilder(
                future: Backend().ucitajKategorije(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final kategorije = snapshot.data!["kategorije"];
                  return buildKategorije(kategorije);
                }),
            Divider(),
            Text("Vrijeme pitanja: ${postavke.vrijemePitanja} sekundi", textAlign: TextAlign.center,),
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
            Text("Vrijeme otkrivanja: ${postavke.vrijemeOtkrivanja} sekundi", textAlign: TextAlign.center,),
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
          ],
        ));
  }

  Widget buildKategorije(List<dynamic> kategorije) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var kategorija in kategorije) ...[
          Text(kategorija["naziv"]),
          Wrap(
            children: [
              for (var potkategorija in kategorija["potkategorije"])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          if (!postavke.kategorije.remove(potkategorija["naziv"])) {
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
        ]
      ],
    );
  }
}
