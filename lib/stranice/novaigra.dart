import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skolarac/backend.dart';
import 'package:skolarac/stranice/soba_page.dart';

class NovaIgra extends StatefulWidget {
  const NovaIgra({super.key});

  @override
  State<NovaIgra> createState() => _NovaIgraState();
}

class _NovaIgraState extends State<NovaIgra> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nova igra"),
      ),
      body: TextButton(
        onPressed: () {
          Backend().instance.kreirajSobu(context).then((s) {
            // provider za sobu, tako da kada dodje do socket eventa, da se
            // widget tree rebuilduje i da se prikaze novo stanje sobe
            Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeNotifierProvider(
              create: (context) => s,
              child: const SobaPage(novaIgra: true,),
            )));
          });
        },
        child: Text("Započni igru"),
      )
    );
  }
}
