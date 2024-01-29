import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skolarac/dialozi/boja_dialog.dart';
import 'package:skolarac/dialozi/jezik_dialog.dart';
import 'package:skolarac/model/korisnik.dart';
import 'package:skolarac/stranice/uredi_profil.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Korisnik korisnik = Provider.of<Korisnik>(context);
    return Scaffold(
      //appBar: AppBar(title: const Text('Profil')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Spacer(flex: 2),
          Hero(
            tag: "profil",
            child: Image.asset(
              "assets/avatari/${korisnik.avatar}.png",
              height: 120,
            ),
          ),
          Hero(
            tag: korisnik.ime,
            child: Text(
              overflow: TextOverflow.ellipsis,
              korisnik.ime,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).colorScheme.onInverseSurface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: Offset(3, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                title: Text("PROFIL",
                    style: TextStyle(fontSize: 25, fontFamily: "RoadRage")),
                leading: Icon(Icons.edit_rounded),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UrediProfil()));
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).colorScheme.onInverseSurface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: Offset(3, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                enabled: true,
                  onTap: () {
                    // nismo stigli prevesti pa smo izbacili opciju, nemojte nam zamjeriti

                    /*showDialog(
                        context: context, builder: (context) => JezikDialog());*/

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Biti će dodato u idućoj verziji!"),
                    ));
                  },
                  title: Text("JEZIK",
                      style: TextStyle(fontSize: 25, fontFamily: "RoadRage")),
                  leading: Icon(Icons.language_rounded),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).colorScheme.onInverseSurface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: Offset(3, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                  onTap: () {
                    showDialog(context: context, builder:(context) => BojaDialog());
                  },
                  title: Text("TEMA",
                      style: TextStyle(fontSize: 25, fontFamily: "RoadRage")),
                  leading: Icon(Icons.color_lens_rounded),),
            ),
          ),
          Spacer(),
          Expanded(
            child: Image.asset("assets/slike/postavke.png"),
            flex: 8,
          ),
        ],
      ),
    );
  }
}
