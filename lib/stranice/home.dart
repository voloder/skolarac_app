import 'package:flutter/material.dart';
import 'package:skolarac/stranice/glavna_strana.dart';
import 'package:skolarac/stranice/predmeti.dart';
import 'package:skolarac/stranice/profil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: TabBarView(
          controller: _tabController,
            children: const [
                PredmetiPage(),
                GlavnaStrana(),
                ProfilePage()
            ],
          ),

        bottomNavigationBar: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.school_rounded, size: 30,)),
            Tab(icon: Icon(Icons.home_rounded, size: 40)),
            Tab(icon: Icon(Icons.person_rounded, size: 30)),
          ],
        )

    );
  }
}
