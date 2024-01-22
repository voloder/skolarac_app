import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      backgroundColor: Color(0xFFf6f6f9),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Spacer(flex: 2),
          Hero(
            tag: korisnik.avatar,
            child: Image.asset(
              "assets/avatari/${korisnik.avatar}.png",
              height: 120,
            ),
          ),
          Text(
            korisnik.ime,
            style: TextStyle(fontSize: 40, fontFamily: "RoadRage"),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: Offset(3, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                title: Text('PROFIL',
                    style: TextStyle(fontSize: 25, fontFamily: "RoadRage")),
                leading: Icon(Icons.edit_rounded),
                tileColor: Colors.white,
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
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: Offset(3, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                  onTap: () {},
                  title: Text('JEZIK',
                      style: TextStyle(fontSize: 25, fontFamily: "RoadRage")),
                  leading: Icon(Icons.language_rounded),
                  tileColor: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: Offset(3, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                  onTap: () {},
                  title: Text('BOJA',
                      style: TextStyle(fontSize: 25, fontFamily: "RoadRage")),
                  leading: Icon(Icons.color_lens_rounded),
                  tileColor: Colors.white),
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
