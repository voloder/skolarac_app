import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skolarac/model/korisnik.dart';
import 'package:skolarac/stranice/home.dart';

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
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: TextButton(
                  onPressed: () {
                    Provider.of<Korisnik>(context, listen: false).napravi(imeController.text, spol ?? true);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                    },
                  child: Text("DALJE"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    textStyle: MaterialStateProperty.all<TextStyle>(Theme.of(context).textTheme.headline6!.copyWith(

                        fontSize: 35,
                        color: Colors.white)),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(12)),
                  )),
            ),
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
