import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skolarac/dialozi/biljeska_dialog.dart';
import 'package:skolarac/model/biljeska.dart';

class Biljeske extends StatefulWidget {
  const Biljeske({super.key});

  @override
  State<Biljeske> createState() => _BiljeskeState();
}

class _BiljeskeState extends State<Biljeske> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bilješke"),
      ),
      body: FutureBuilder(
          future: ucitajBiljeske(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );

            List<Biljeska> biljeske = snapshot.data as List<Biljeska>;

            return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final biljeska = await showDialog(
                          context: context,
                          builder: (context) => BiljeskaDialog());

                      if (biljeska != null) {
                        setState(() {
                          biljeske.add(biljeska as Biljeska);
                          sacuvajBiljeske(biljeske);
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
                            child:
                                Icon(Icons.add, color: Colors.white, size: 40),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("NOVA BILJEŠKA",
                              style: TextStyle(fontSize: 50)),
                        ),
                      ],
                    ),
                  ),
                  for (Biljeska biljeska in biljeske)
                    Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 1,
                            color: Theme.of(context).colorScheme.onBackground),
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () async {
                                final novaBiljeska = await showDialog(
                                    context: context,
                                    builder: (context) => BiljeskaDialog(
                                          biljeska: biljeska,
                                        ));

                                if (novaBiljeska != null) {
                                  if (novaBiljeska.naslov == "" &&
                                      novaBiljeska.tekst == "") {
                                    setState(() {
                                      biljeske.remove(biljeska);
                                      sacuvajBiljeske(biljeske);
                                    });
                                    return;
                                  }
                                  setState(() {
                                    int i = biljeske.indexOf(biljeska);
                                    biljeske.remove(biljeska);
                                    biljeske.insert(
                                        i, novaBiljeska as Biljeska);
                                    sacuvajBiljeske(biljeske);
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
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  biljeska.naslov,
                                  style: TextStyle(fontSize: 36),
                                ),
                                Text(biljeska.tekst,
                                    style: TextStyle(fontSize: 26)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                ]);
          }),
    );
  }

  Future<List<Biljeska>> ucitajBiljeske() async {
    final prefs = await SharedPreferences.getInstance();

    final biljeske = prefs.getStringList("biljeske") ?? [];

    return biljeske.map((e) => Biljeska.fromJson(e)).toList();
  }

  Future<void> sacuvajBiljeske(List<Biljeska> biljeske) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setStringList("biljeske", biljeske.map((e) => e.toJson()).toList());
  }

  Future<void> dodajBiljesku(Biljeska biljeska) async {
    final prefs = await SharedPreferences.getInstance();

    final biljeske = prefs.getStringList("biljeske") ?? [];

    biljeske.add(biljeska.toJson());

    prefs.setStringList("biljeske", biljeske);
  }
}
