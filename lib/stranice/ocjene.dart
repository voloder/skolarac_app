import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skolarac/dialozi/predmet_dialog.dart';
import 'package:skolarac/model/predmet.dart';

class OcjenePage extends StatefulWidget {
  const OcjenePage({super.key});

  @override
  State<OcjenePage> createState() => _OcjenePageState();
}

class _OcjenePageState extends State<OcjenePage> {
  SharedPreferences? prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ocjene"),
      ),
      body: Center(
          child: FutureBuilder(
              future: ucitajPredmete(),
              builder: (context, snapshot) {
                if (snapshot.hasError)
                  return Center(child: Text(snapshot.error.toString()));
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());

                final predmeti = snapshot.data as List<Predmet>;

                return Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final noviPredmet = await showDialog(
                            context: context,
                            builder: (context) => PredmetDialog());

                        if (noviPredmet != null) {
                          setState(() {
                            predmeti.add(noviPredmet as Predmet);
                            sacuvajPredmete(predmeti);
                          });
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              child: Icon(Icons.add,
                                  color: Colors.white, size: 40),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("NOVI PREDMET",
                                style: TextStyle(fontSize: 50)),
                          ),
                        ],
                      ),
                    ),
                    for (Predmet predmet in predmeti)
                      Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 1,
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () async {
                                  Predmet? noviPredmet = await showDialog(
                                      context: context,
                                      builder: (context) => PredmetDialog(
                                            predmet: predmet,
                                          ));
                                  if (noviPredmet != null) {
                                    print(noviPredmet.naziv);
                                    if (noviPredmet.naziv == "" &&
                                        noviPredmet.ocjene.isEmpty) {

                                      setState(() {
                                        predmeti.remove(predmet);
                                        sacuvajPredmete(predmeti);
                                      });
                                      return;
                                    }
                                    setState(() {
                                      predmeti[predmeti.indexOf(predmet)] =
                                          noviPredmet as Predmet;
                                      sacuvajPredmete(predmeti);
                                    });
                                  }

                                },
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  child: Icon(Icons.edit,
                                      color: Colors.white, size: 25),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    predmet.naziv,
                                    style: TextStyle(fontSize: 36),
                                  ),
                                  Text(predmet.ocjene.join(", "),
                                      style: TextStyle(fontSize: 26)),
                                ],
                              ),
                            ),
                            Text(
                              predmet.prosjek.toStringAsFixed(2),
                              style: TextStyle(fontSize: 70),)
                          ],
                        ),
                      ),
                  ],
                );
              })),
    );
  }

  Future<List<Predmet>> ucitajPredmete() async {
    prefs ??= await SharedPreferences.getInstance();

    final predmeti = prefs!.getStringList("predmeti");

    if (predmeti == null) {
      return [];
    }

    return predmeti.map((e) => Predmet.fromJson(e)).toList();
  }

  Future<void> sacuvajPredmete(List<Predmet> predmeti) async {
    prefs ??= await SharedPreferences.getInstance();

    prefs!.setStringList("predmeti", predmeti.map((e) => e.toJson()).toList());
  }
}
