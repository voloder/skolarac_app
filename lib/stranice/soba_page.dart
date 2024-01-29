import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skolarac/backend.dart';
import 'package:skolarac/model/pitanje.dart';
import 'package:skolarac/model/postavke_sobe.dart';
import 'package:skolarac/model/soba.dart';
import 'package:skolarac/widgeti/skolarac_dugme.dart';

class SobaPage extends StatefulWidget {
  final bool novaIgra;
  final SobaPostavke? postakve;

  const SobaPage({super.key, this.novaIgra = false, this.postakve});

  @override
  State<SobaPage> createState() => _SobaPageState();
}

class _SobaPageState extends State<SobaPage> with TickerProviderStateMixin {
  int? odabir;
  String? prosloStanje;
  int prosliCountdown = 0;

  late Soba soba = Provider.of<Soba>(context);

  late AnimationController controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late AnimationController _countdownController = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  @override
  Widget build(BuildContext context) {
    progress();

    if (prosloStanje == "otkrij" && soba.stanje == "pitanje") {
      odabir = null;
    }

    if (prosloStanje == "pitanje" && soba.stanje == "otkrij") {
      if (odabir != null) {
        Backend().instance.posaljiOdabir(soba, odabir!);
      }
    }

    WidgetsBinding.instance
        .addPostFrameCallback((_) => prosloStanje = soba.stanje);

    return Scaffold(
        appBar: AppBar(
          title: Text("Kviz"),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AnimatedBuilder(
              animation: controller,
                builder: (context, _) {
                  return LinearProgressIndicator(
                    minHeight: 10,
                    value: controller.value,
                    semanticsLabel: 'Linear progress indicator',
                  );
                }),
            if (widget.novaIgra && soba.stanje == "cekanje") ...[
              Text(
                "KOD KVIZA: ${soba.kod}",
                textAlign: TextAlign.center,
              ),
              SkolaracDugme(
                  text: "ZAPOČNI KVIZ",
                  onPressed: () => Backend().instance.kreniIgru(soba, widget.postakve!))
            ],
            Expanded(child: buildSobu())
          ],
        ));
  }

  void progress() async {
    if (soba.countdown > prosliCountdown) {
      await controller.animateTo(1.0, duration: Duration(milliseconds: 100));
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
        controller.animateTo(
            (soba.countdown - 1) / soba.postavke.vrijemePitanja,
            duration: Duration(seconds: 1));
        break;
      case "otkrij":
        controller.animateTo(
            (soba.countdown - 1) / soba.postavke.vrijemeOtkrivanja,
            duration: Duration(seconds: 1));
        break;
      default:
        controller.animateTo(0);
    }
    prosliCountdown = soba.countdown;
  }

  Widget buildSobu() {
    switch (soba.stanje) {
      case "cekanje":
        return buildCekanje();
      case "countdown":
        return buildCountdown();
      case "pitanje":
        return buildPitanje(false);
      case "otkrij":
        return buildPitanje(true);
      default:
        return buildZavrseno();
    }
  }

  buildZavrseno() {
    soba.igraci.sort((a, b) => a.poeni.compareTo(b.poeni));

    return ListView(
      children: [
        Text(
          "Završeno",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline1,
        ),
        ...soba.igraci.map(
          (igrac) => ListTile(
              leading: Stack(
                children: [
                  Image.asset("assets/avatari/${igrac.avatar}.png"),
                  if (igrac == soba.igraci[0] && igrac.poeni != 0)
                    Transform.translate(
                        offset: Offset(-7, -28),
                        child: Image.asset("assets/slike/kruna.png")),
                ],
              ),
              title:
                  Text(igrac.ime, style: Theme.of(context).textTheme.headline4),
              subtitle: Text("${igrac.poeni} BODOVA",
                  style: TextStyle(
                      color: igrac.poeni > 0 ? Colors.green : Colors.red,
                      fontSize: 20))),
        )
      ],
    );
  }

  buildCekanje() {
    return ListView(
      children: [
        ...soba.igraci.map((igrac) => ListTile(
              leading: Image.asset("assets/avatari/${igrac.avatar}.png"),
              title:
                  Text(igrac.ime, style: Theme.of(context).textTheme.headline4),
            )),
      ],
    );
  }

  buildCountdown() {
    _countdownController.forward(from: 0);
    return ScaleTransition(
      scale: Tween(begin: 2.0, end: 1.0).animate(CurvedAnimation(
          parent: _countdownController, curve: Curves.elasticOut)),
      child: Center(
        child: Text(
          soba.countdown.toString(),
          style: TextStyle(fontSize: 150),
        ),
      ),
    );
  }

  buildPitanje(bool otkrij) {
    Pitanje pitanje = soba.pitanje!;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Spacer(),
      Expanded(
        flex: 2,
        child: AutoSizeText(
          pitanje.pitanje,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 60),
          maxLines: 2,
        )
      ),
      Spacer(),
      ...List.generate(
        4,
        (index) => AnimatedContainer(
          curve: Curves.elasticOut,
          duration: Duration(milliseconds: 500),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          foregroundDecoration: BoxDecoration(
            color: otkrij && pitanje.tacan != "abcd"[index]
                ? Colors.white60
                : null,
          ),
          transform: (Matrix4.identity()..scale(odabir == index ? 1.08 : 1.0)),
          transformAlignment: FractionalOffset.center,
          child: ListTile(
            dense: true,
            visualDensity: VisualDensity(vertical: 2),
            contentPadding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textColor:
                otkrij && pitanje.tacan == "abcd"[index] ? Colors.green : null,
            tileColor: [
              Color(0xFF1D2D60),
              Color(0xFFF65E5D),
              Color(0xFFFFBC47),
              Color(0xFF40CEE2)
            ][index],
            leading: SizedBox(
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xFF31A062),
                child: Text("ABCD"[index],
                    style: TextStyle(color: Colors.white, fontSize: 35)),
              ),
            ),
            trailing: otkrij && pitanje.tacan == "abcd"[index]
                ? Icon(Icons.check, color: Colors.green, size: 40)
                : otkrij && odabir == index
                    ? Icon(Icons.close, color: Colors.red, size: 40)
                    : null,
            title: Container(
              height: 50,
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                [pitanje.a, pitanje.b, pitanje.c, pitanje.d][index],
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  maxLines: 2,
              ),
            ),
            onTap: () {
              if (soba.stanje != "pitanje") return;
              setState(() {
                odabir = index;
              });
            },
          ),
        ),
      ),
      Spacer(),
      Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Color(0xFF108688),
          ),
          child: Text("${soba.trenutnoPitanje}/${soba.postavke.brojPitanja}",
              style: TextStyle(fontSize: 30, color: Colors.white)),
        ),
      ),
      Spacer(),
    ]);
  }

  @override
  void dispose() {
    Backend().instance.napustiSobu(soba);
    super.dispose();
  }
}
