import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skolarac/backend.dart';
import 'package:skolarac/model/pitanje.dart';
import 'package:skolarac/model/soba.dart';

class SobaPage extends StatefulWidget {
  const SobaPage({super.key});

  @override
  State<SobaPage> createState() => _SobaPageState();
}

class _SobaPageState extends State<SobaPage> with TickerProviderStateMixin {
  int? odabir;

  late AnimationController controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    Soba soba = Provider.of<Soba>(context);
    progress(soba);
    return Scaffold(
        appBar: AppBar(
          title: Text("Soba"),
        ),
        body: Column(
          children: [
            AnimatedBuilder(
                animation: controller,
                builder: (context, _) {
                  return LinearProgressIndicator(
                    value: controller.value,
                    semanticsLabel: 'Linear progress indicator',
                  );
                }),
            buildSobu(soba)
          ],
        ));
  }
  String? prosloStanje;

  void progress(Soba soba) async {
    int vrijeme;
    if(soba.stanje != prosloStanje && soba.stanje != "cekanje" && soba.stanje != "zavrseno") {
      await controller.animateTo(1.0,
          duration: Duration(milliseconds: 100));
    }
    switch (soba.stanje) {
      case "cekanje":
        controller.animateTo(0);
        break;
      case "countdown":
        controller.animateTo((soba.countdown - 1) / 3,
            duration: Duration(seconds: 1));
        break;
      case "pitanje":
        controller.animateTo((soba.countdown - 1) / soba.vrijemePitanja,
            duration: Duration(seconds: 1));
        break;
      case "otkrij":
        controller.animateTo((soba.countdown - 1) / soba.vrijemeOtkrivanja,
            duration: Duration(seconds: 1));
        break;
      default:
        controller.animateTo(0);
    }
    prosloStanje = soba.stanje;
  }

  Widget buildSobu(Soba soba) {
    switch (soba.stanje) {
      case "cekanje":
        return buildCekanje(soba);
      case "countdown":
        return buildCountdown(soba);
      case "pitanje":
        return buildPitanje(soba, false);
      case "otkrij":
        return buildPitanje(soba, true);
      default:
        return buildZavrseno(soba);
    }
  }

  buildZavrseno(Soba soba) {
    return Column(
      children: [
        Text("Završeno"),
        ...soba.igraci.map((ucesnik) => ListTile(
              title: Text(ucesnik.ime),
              subtitle: Text(ucesnik.poeni.toString()),
            ))
      ],
    );
  }

  buildCekanje(Soba soba) {
    return Center(
      child: Text("Čekanje na igrače"),
    );
  }

  buildCountdown(Soba soba) {
    return Center(
      child: Text(soba.countdown.toString()),
    );
  }

  buildPitanje(Soba soba, bool otkrij) {
    Pitanje pitanje = soba.pitanje!;
    return Column(
      children: [
        Text(pitanje.pitanje),
        ListTile(
          textColor: otkrij && pitanje.tacan == "a" ? Colors.green : null,
          tileColor: odabir == 0 ? Colors.blue : null,
          title: Text("A) " + pitanje.a),
          onTap: () {
            setState(() {
              odabir = 0;
              Backend().instance.odaberiOdgovor(soba, 0);
            });
          },
        ),
        ListTile(
          textColor: otkrij && pitanje.tacan == "b" ? Colors.green : null,
          tileColor: odabir == 1 ? Colors.blue : null,
          title: Text("B) " + pitanje.b),
          onTap: () {
            setState(() {
              odabir = 1;
              Backend().instance.odaberiOdgovor(soba, 1);
            });
          },
        ),
        ListTile(
          textColor: otkrij && pitanje.tacan == "c" ? Colors.green : null,
          tileColor: odabir == 2 ? Colors.blue : null,
          title: Text("C) " + pitanje.c),
          onTap: () {
            setState(() {
              odabir = 2;
              Backend().instance.odaberiOdgovor(soba, 2);
            });
          },
        ),
        ListTile(
          textColor: otkrij && pitanje.tacan == "d" ? Colors.green : null,
          tileColor: odabir == 3 ? Colors.blue : null,
          title: Text("D) " + pitanje.d),
          onTap: () {
            setState(() {
              odabir = 3;
              Backend().instance.odaberiOdgovor( soba, 3);
            });
          },
        ),
      ],
    );
  }
}
