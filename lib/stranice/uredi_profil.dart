import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skolarac/model/korisnik.dart';

class UrediProfil extends StatefulWidget {
  const UrediProfil({super.key});

  @override
  State<UrediProfil> createState() => _UrediProfilState();
}

class _UrediProfilState extends State<UrediProfil> {
  TextEditingController _imeController = TextEditingController();

  @override
  void initState() {
    Korisnik korisnik = Provider.of<Korisnik>(context, listen: false);
    _imeController.text = korisnik.ime;
    _imeController.addListener(() {
      korisnik.ime = _imeController.text;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Korisnik korisnik = Provider.of<Korisnik>(context);
    return Scaffold(
      backgroundColor: Color(0xFFf6f6f9),
      appBar: AppBar(
        title: Text("Uredi profil"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
Spacer(),
 Hero(
              tag: "profil",
              child: Image.asset(
                "assets/avatari/${korisnik.avatar}.png",
                height: 150,
              ),
            ),

          Hero(
            tag: korisnik.ime,
            child: Text(
              korisnik.ime,
              style: Theme.of(context).textTheme.headline6!,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: TextField(
              controller: _imeController,
              style: TextStyle(fontSize: 30),
              decoration: InputDecoration(
                labelText: "IME",
                labelStyle: TextStyle(fontSize: 25),
                hintStyle: TextStyle(fontSize: 10),
              ),
            ),
          ),
          Spacer(),
          Text("AVATAR", style: TextStyle(fontSize: 25), textAlign: TextAlign.start,),
          DefaultTabController(
            length: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TabBar(
                  tabs: [
                    Tab(
                      text: "ŽENSKI",
                    ),
                    Tab(
                      text: "MUŠKI",
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                  child: TabBarView(children: List.generate(2, (spol) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(4, (index) {
                          index = index + spol * 4 + 1;
                          return GestureDetector(
                            onTap: () {
                              korisnik.avatar = index;
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Opacity(
                                  opacity: korisnik.avatar == index ? 1 : 0.5,
                                  child: Image.asset(
                                        "assets/avatari/${index}.png"),

                                ),
                                if (korisnik.avatar == index)
                                  Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 40,
                                  )
                              ],
                            ),
                          );
                        })
                    );}),
                  ),
                )
              ],
            ),
          ),
          /*Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              children: List.generate(8, (index) {
                return Center(
                  child: GestureDetector(
                    onTap: () {
                      print(korisnik.avatar);
                      korisnik.avatar = index + 1;
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Opacity(
                          opacity: korisnik.avatar == index + 1 ? 1 : 0.5,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Hero(
                                tag: index + 1,
                                child: Image.asset(
                                    "assets/avatari/${index + 1}.png")),
                          ),
                        ),
                        if (korisnik.avatar == index + 1)
                          Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 40,
                          )
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),*/
          Expanded(
            flex: 12,
              child: Image.asset("assets/slike/profil.png"),
          ),
        ],
      ),
    );
  }
}
