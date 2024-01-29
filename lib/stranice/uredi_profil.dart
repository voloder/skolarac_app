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
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.chevron_left, size: 40)),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Spacer(flex: 2),
          Hero(
            tag: "profil",
            child: Image.asset(
              "assets/avatari/${korisnik.avatar}.png",
              height: 125,
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
          DefaultTabController(
            initialIndex: korisnik.avatar > 5 ? 1 : 0,
            length: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const TabBar(
                  tabs: [
                    Tab(
                      child: Text(
                        "ŽENSKI",
                        style:
                            TextStyle(color: Color(0xFFA53D8E), fontSize: 20),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "MUŠKI",
                        style:
                            TextStyle(color: Color(0xFF0080C8), fontSize: 20),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  height: 80,
                  child: TabBarView(
                    children: List.generate(2, (spol) {
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(5, (index) {
                            index = index + spol * 5 + 1;
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
                          }));
                    }),
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
