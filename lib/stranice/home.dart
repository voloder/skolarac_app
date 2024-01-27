import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:skolarac/model/korisnik.dart';
import 'package:skolarac/stranice/glavna_strana.dart';
import 'package:skolarac/stranice/napravi_racun.dart';
import 'package:skolarac/stranice/predmeti.dart';
import 'package:skolarac/stranice/profil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    Korisnik korisnik = Provider.of<Korisnik>(context, listen: false);

    return FutureBuilder(
        future: korisnik.getPrefs(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Material(
                child: Center(
                  child: CircularProgressIndicator(),
                )
            );
          }

          if (!korisnik.sacuvan()) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => NapraviRacun()));
            });
            return Material(
                child: Center(
                  child: CircularProgressIndicator(),
                )
            );
          }

          return Scaffold(
              body: TabBarView(
                controller: _tabController,
                children: const [PredmetiPage(), GlavnaStrana(), ProfilePage()],
              ),
              bottomNavigationBar: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(
                      icon: Icon(
                    Icons.school_rounded,
                    size: 30,
                  )),
                  Tab(icon: Icon(Icons.home_rounded, size: 40)),
                  Tab(icon: Icon(Icons.person_rounded, size: 30)),
                ],
              ));
        });
  }
}
