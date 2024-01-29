import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:skolarac/model/korisnik.dart';
import 'package:skolarac/model/tema.dart';
import 'package:skolarac/stranice/home.dart';
import 'package:skolarac/widgeti/skolarac_dugme.dart';

class NapraviRacun extends StatefulWidget {
  const NapraviRacun({super.key});

  @override
  State<NapraviRacun> createState() => _NapraviRacunState();
}

class _NapraviRacunState extends State<NapraviRacun> {
  TextEditingController imeController = TextEditingController();
  String? ime;
  bool? spol;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(flex: 4),
            Text(
              "NAPRAVI RAČUN",
              style: TextStyle( fontSize: 50),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: TextField(
                controller: imeController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  labelText: "IME",
                  labelStyle: TextStyle( fontSize: 25),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1000)),
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    spol = true;
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.female,
                      size: 80,
                      color: spol ?? false ? Colors.pink : Colors.black,),
                    Text(
                      "Ž",
                      style: TextStyle( fontSize: 30, color: spol ?? false ? Colors.pink : Colors.black,),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    spol = false;
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.male,
                      size: 80,
                      color: spol ?? true ? Colors.black : Colors.blue,
                    ),
                    Text(
                      "M",
                      style: TextStyle( fontSize: 30, color: spol ?? true ? Colors.black : Colors.blue,),
                    )
                  ],
                ),
              ),
            ]),
            Spacer(),
            SkolaracDugme(text: "DALJE",     onPressed: () {
      Provider.of<Korisnik>(context, listen: false).napravi(imeController.text, spol ?? true);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      Provider.of<Tema>(context, listen: false).setBoja(TemaBoja.auto);
      },),

            Expanded(
              flex: 12,
              child: Image.asset("assets/slike/education.png"),
            )
          ],
        ),
      ),
    );
  }
}
