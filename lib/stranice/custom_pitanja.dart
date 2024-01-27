import 'package:flutter/material.dart';
import 'package:skolarac/model/pitanje.dart';
import 'package:skolarac/model/postavke_sobe.dart';

class CustomPitanja extends StatefulWidget {
  final SobaPostavke postavke;

  const CustomPitanja({super.key, required this.postavke});

  @override
  State<CustomPitanja> createState() => _CustomPitanjaState();
}

class _CustomPitanjaState extends State<CustomPitanja> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Custom pitanja"),
        ),
        body: ListView(padding: EdgeInsets.all(20), children: [
Row(
  children: [
    CircleAvatar(
      radius: 25,
      backgroundColor: Colors.green,
      child: IconButton(
        icon: Icon(Icons.add, color: Colors.white,),
        onPressed: () {
          setState(() {
            widget.postavke.customPitanja.add(Pitanje(
              a: "",
              b: "",
              c: "",
              d: "",
              pitanje: "",
              tacan: "a",
            ));
          });
        },
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("DODAJ PITANJE"),
    )
  ],
),
          ...widget.postavke.customPitanja
              .map((e) => Column(
                    children: [
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          minLines: 2,
                          maxLines: 5,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            labelText: "Pitanje",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                          ),
                          controller: TextEditingController(text: e.pitanje),
                          onChanged: (s) {
                            e.pitanje = s;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            labelText: "Odgovor A",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                          ),
                          controller: TextEditingController(text: e.a),
                          onChanged: (s) {
                            e.a = s;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            labelText: "Odgovor B",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                          ),
                          controller: TextEditingController(text: e.b),
                          onChanged: (s) {
                            e.b = s;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            labelText: "Odgovor C",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                          ),
                          controller: TextEditingController(text: e.c),
                          onChanged: (s) {
                            e.c = s;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            labelText: "Odgovor D",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                          ),
                          controller: TextEditingController(text: e.d),
                          onChanged: (s) {
                            e.d = s;
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(4, (index) =>                           Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  e.tacan = "abcd"[index];
                                });
                              },
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor:
                                e.tacan == "abcd"[index] ? Colors.green : Colors.grey,
                                child: Text("ABCD"[index], style: TextStyle(color: Colors.white, fontSize: 35),),
                              ),
                            ),
                          ),),
                          Spacer(),
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.red,
                            child: IconButton(
                              icon: Icon(Icons.delete, color: Colors.white,),
                              onPressed: () {
                                setState(() {
                                  widget.postavke.customPitanja.remove(e);
                                });
                              },
                            ),)
                        ],
                      )
                    ],
                  ))
              .toList(),
        ]));
  }
}
