import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skolarac/dialozi/promijeni_raspored.dart';

class RasporedPage extends StatefulWidget {
  const RasporedPage({super.key});

  @override
  State<RasporedPage> createState() => _RasporedPageState();
}

const dani = ["PONEDJELJAK", "UTORAK", "SRIJEDA", "ČETVRTAK", "PETAK"];

class _RasporedPageState extends State<RasporedPage> {
  SharedPreferences? prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.chevron_left, size: 40),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: FutureBuilder(
          future: ucitajRaspored(),
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Center(child: Text(snapshot.error.toString()));
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());

            final raspored = snapshot.data as List<List<String>>;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  for (int dan = 0; dan < 5; dan++) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(dani[dan]),
                        GestureDetector(
                            onTap: () async {
                              final value = await showDialog(
                                  context: context,
                                  builder: (context) => PromijeniRaspored(
                                        dan: dan,
                                        casovi: raspored[dan],
                                      ));

                              if (value != null) {
                                setState(() {
                                  raspored[dan] = value as List<String>;
                                });
                                sacuvajRaspored(raspored);
                              }
                            },
                            child: Text("PROMIJENI",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary))),
                      ],
                    ),
                    Expanded(
                        child: Row(
                      children: [
                        for (int cas = 0; cas < 6; cas++)
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: cas == 0
                                    ? BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10))
                                    : cas == 5
                                        ? BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10))
                                        : null,
                                border: Border.all(color: Theme.of(context).colorScheme.onBackground),
                              ),
                              child: raspored[dan][cas] != ""
                                  ? Center(
                                      child: FittedBox(
                                          fit: BoxFit.cover,
                                          child: Text(
                                            raspored[dan][cas],
                                            style: TextStyle(fontSize: 50),
                                          )))
                                  : null,
                            ),
                          )
                      ],
                    )),
                  ]
                ],
              ),
            );
          }),
    );
  }

  Future<List<List<String>>> ucitajRaspored() async {
    prefs ??= await SharedPreferences.getInstance();
    final json = prefs!.getString("raspored");

    if (json == null) {
      return List.generate(5, (index) => List.generate(6, (index) => ""));
    }

    return (jsonDecode(json) as List<dynamic>)
        .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
        .toList();
  }

  Future<void> sacuvajRaspored(List<List<String>> raspored) async {
    prefs ??= await SharedPreferences.getInstance();

    prefs!.setString("raspored", jsonEncode(raspored));
  }
}
