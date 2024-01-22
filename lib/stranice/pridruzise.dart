import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skolarac/backend.dart';
import 'package:skolarac/stranice/soba_page.dart';

class PridruziSe extends StatefulWidget {
  const PridruziSe({super.key});

  @override
  State<PridruziSe> createState() => _PridruziSeState();
}

class _PridruziSeState extends State<PridruziSe> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pridruži se"),
      ),
      body: Column(
        children: [
    Text("KVIZ",
            style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold)),
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Unesite kôd kviza',
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () async {
            Backend().instance.udjiUSobu(context, _controller.text).then((s) {
              // provider za sobu, tako da kada dodje do socket eventa, da se
              // widget tree rebuilduje i da se prikaze novo stanje sobe
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeNotifierProvider(
                create: (context) => s,
                child: const SobaPage(),
              )));
            });
          },
          child: const Text("Uđi u kviz"),
        ),
        Padding(
          padding: const EdgeInsets.all(100.0),
          child: Hero(
              tag: "pridruzise",
              child: Image.asset("assets/slike/pridruzise.png")),
        )
        ],
    ));
  }
}
