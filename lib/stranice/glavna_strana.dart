import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skolarac/backend.dart';
import 'package:skolarac/model/korisnik.dart';
import 'package:skolarac/stranice/novaigra.dart';
import 'package:skolarac/stranice/pridruzise.dart';
import 'package:skolarac/stranice/soba_page.dart';

class GlavnaStrana extends StatefulWidget {
  const GlavnaStrana({super.key});

  @override
  State<GlavnaStrana> createState() => _GlavnaStranaState();
}

class _GlavnaStranaState extends State<GlavnaStrana> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const NovaIgra()));
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 140,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF92E3A9),
                    Color(0xFF2B8854),
                  ],
                )),
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 25,
                  child: Text("NOVA IGRA",
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: "RoadRage",
                          color: Colors.white)),
                ),
                Positioned(
                    right: 40,
                    top: 10,
                    bottom: 10,
                    child: Image.asset("assets/slike/novaigra.png"))
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const PridruziSe()));
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 140,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF263238),
                    Color(0xFF00BEBE),
                  ],
                )),
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 25,
                  child: Text("PRIDRUŽI SE",
                      style: TextStyle(
                          fontSize: 40,
                          fontFamily: "RoadRage",
                          color: Colors.white)),
                ),
                Positioned(
                    right: 40,
                    top: 10,
                    bottom: 10,
                    child: Hero(
                        tag: "pridruzise",
                        child: Image.asset("assets/slike/pridruzise.png")))
              ],
            ),
          ),
        ),
        Spacer(
          flex: 2,
        )
      ],
    );
  }
}
