import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
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

class _GlavnaStranaState extends State<GlavnaStrana>
    with TickerProviderStateMixin {
  TextEditingController _controller = TextEditingController();

  late GifController _gifController = GifController(vsync: this);

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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, left: 25),
                    child: Hero(
                      tag: "novaigra_naslov",
                      child: Text("NOVA IGRA",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8, right: 30),
                  child: Hero(
                      tag: "novaigra",
                      child: Image.asset("assets/slike/novaigra.png")),
                )
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, left: 25),
                    child: Hero(
                      tag: "pridruzise_naslov",
                      child: Text("PRIDRUŽI SE",
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8, right: 30),
                  child: Hero(
                      tag: "pridruzise",
                      child: Image.asset("assets/slike/pridruzise.png")),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Gif(
            image: AssetImage("assets/slike/animacija.gif"),
            controller:
                _gifController, // if duration and fps is null, original gif fps will be used.
            autostart: Autostart.no,
            onFetchCompleted: () {
              _gifController.reset();
              _gifController.forward();
            },
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _gifController.dispose();
    super.dispose();
  }
}
