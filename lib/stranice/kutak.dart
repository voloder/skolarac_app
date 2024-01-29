import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skolarac/stranice/kutak_fokus.dart';
import 'package:skolarac/widgeti/skolarac_dugme.dart';

class Kutak extends StatefulWidget {
  const Kutak({super.key});

  @override
  State<Kutak> createState() => _KutakState();
}

class _KutakState extends State<Kutak> {
  Duration trajanje = Duration(hours: 0, minutes: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.chevron_left, size: 40)),
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("KUTAK ZA UČENJE", textAlign: TextAlign.center, style: TextStyle(fontSize: 45, color: Theme.of(context).colorScheme.primary),),
            Expanded(
              flex: 2,
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hm,
                minuteInterval: 1,
                secondInterval: 1,
                initialTimerDuration: trajanje,
                onTimerDurationChanged: (Duration changedtimer) {
                  setState(() {
                    trajanje = changedtimer;
                  });
                },
              ),
            ),
            SkolaracDugme(text: "ZAPOČNI", onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => KutakFokus(trajanje: trajanje)));
            }),

            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(63.0),
                child: Image.asset(
                  "assets/slike/ucenje.png",
                ),
              ),
            ),
          ],
        ));
  }
}
