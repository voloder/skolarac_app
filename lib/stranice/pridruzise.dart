import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skolarac/backend.dart';
import 'package:skolarac/stranice/soba_page.dart';
import 'package:skolarac/widgeti/skolarac_dugme.dart';

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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Hero(
            tag: "pridruzise_naslov",
            child: Text("PRIDRUŽI SE",
                style: Theme.of(context).textTheme.headline6),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(),
            Expanded(
              flex: 4,
              child: Image.asset("assets/slike/quiztime.png"),
            ),
            Spacer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  labelText: "UNESITE KÔD KVIZA",
                  labelStyle: TextStyle(fontSize: 25),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1000)),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
              child: SkolaracDugme(
                onPressed: () {
                  Backend()
                      .instance
                      .udjiUSobu(context, _controller.text)
                      .then((s) {
                    // provider za sobu, tako da kada dodje do socket eventa, da se
                    // widget tree rebuilduje i da se prikaze novo stanje sobe
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                  create: (context) => s,
                                  child: const SobaPage(),
                                )));
                  });
                },
                text: "DALJE",
              ),
            ),
            Spacer(),
            Expanded(
              flex: 5,
              child: Hero(
                  tag: "pridruzise",
                  child: Image.asset("assets/slike/pridruzise.png")),
            ),
            Spacer()
          ],
        ));
  }
}
