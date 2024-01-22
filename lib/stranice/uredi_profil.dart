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
    _imeController.addListener(() {korisnik.ime = _imeController.text;});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Korisnik korisnik = Provider.of<Korisnik>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Uredi profil"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(
            controller: _imeController,
            decoration: InputDecoration(
              labelText: "Vaše ime i prezime",
            ),
          ),
          GridView.count(
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
                              child: Hero(tag: index + 1,
                                  child: Image.asset("assets/avatari/${index + 1}.png")),
                            ),
                          ),
                          if(korisnik.avatar == index + 1) Icon(Icons.check, color: Colors.white, size: 40,)
                        ],
                      ),
                    ),
              );
            }),
          ),
        ],

      ),
    );
  }
}
