import 'package:flutter/material.dart';
import 'package:skolarac/stranice/biljeske.dart';
import 'package:skolarac/stranice/kutak.dart';
import 'package:skolarac/stranice/ocjene.dart';
import 'package:skolarac/stranice/raspored_page.dart';
import 'package:skolarac/widgeti/gradient_dugme.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 25,),
          GradientDugme(
              flex: 2,
              boja1: Color(0xFF93E3AA),
              boja2: Color(0xFF2B8954),
              naslov: "RASPORED ČASOVA",
              slika: "assets/slike/raspored.png",
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RasporedPage()));
              }),
          GradientDugme(
              flex: 2,
              boja1: Color(0xFF93D5E3),
              boja2: Color(0xFF2B5C89),
              naslov: "OCJENE",
              slika: "assets/slike/ocjene.png",
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const OcjenePage()));
              }),
          GradientDugme(
              flex: 2,
              boja1: Color(0xFFE393A1),
              boja2: Color(0xFF892B42),
              naslov: "BILJEŠKE",
              slika: "assets/slike/biljeske.png",
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Biljeske()));
              }),
          GradientDugme(
            flex: 2,
              boja1: Color(0xFFC994FF),
              boja2: Color(0xFF75009E),
              naslov: "KUTAK ZA UČENJE",
              slika: "assets/slike/kutak.png",
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Kutak()));
              }),
          Expanded(flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset("assets/slike/amico.png"),
              )),
        ],
      ),
    );
  }
}
