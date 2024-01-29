import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:skolarac/backend.dart';
import 'package:skolarac/model/korisnik.dart';
import 'package:skolarac/model/tema.dart';
import 'package:skolarac/stranice/novaigra.dart';
import 'package:skolarac/stranice/pridruzise.dart';
import 'package:skolarac/stranice/soba_page.dart';
import 'package:skolarac/widgeti/gradient_dugme.dart';

class GlavnaStrana extends StatefulWidget {
  const GlavnaStrana({super.key});

  @override
  State<GlavnaStrana> createState() => _GlavnaStranaState();
}

class _GlavnaStranaState extends State<GlavnaStrana>
    with TickerProviderStateMixin {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child:
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/slike/banner_${Provider.of<Tema>(context).getBrightness() == Brightness.light ? "dark" : "light"}.png"),
          )
          ),
          GradientDugme(
            // nova igra
            boja1: Color(0xFF92E3A9),
            boja2: Color(0xFF2B8854),
            naslov: "NOVA IGRA",
            slika: "assets/slike/novaigra.png",
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const NovaIgra()));
            },
            naslovHero: "novaigra_naslov",
            slikaHero: "novaigra",
      
          ),
          GradientDugme(
            boja1: Color(0xFF263238),
            boja2: Color(0xFF00BEBE),
            naslov: "PRIDRUŽI SE",
            slika: "assets/slike/pridruzise.png",
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const PridruziSe()));
            },
            naslovHero: "pridruzise_naslov",
            slikaHero: "pridruzise",
          ),
          Expanded(
            flex: 2,
            child: Image.asset("assets/slike/kviz.png"),
      
          )
        ],
      ),
    );
  }
}
