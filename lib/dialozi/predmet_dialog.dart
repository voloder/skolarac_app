import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skolarac/model/predmet.dart';
import 'package:skolarac/widgeti/skolarac_dugme.dart';

class PredmetDialog extends StatefulWidget {
  final Predmet? predmet;

   const PredmetDialog({super.key , this.predmet});

  @override
  State<PredmetDialog> createState() => _PredmetDialogState();
}

class _PredmetDialogState extends State<PredmetDialog> {
  late TextEditingController naslovController = TextEditingController(text: widget.predmet?.naziv);
  late TextEditingController tekstController = TextEditingController( text: widget.predmet?.ocjene.join(""));

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(widget.predmet == null ? "Novi predmet" : "Uredi predmet"),
                Spacer(),
                if(widget.predmet != null) IconButton(
                    onPressed: () {
                      Navigator.of(context).pop(Predmet(naziv: "", ocjene: []));
                    },
                    icon: Icon(Icons.delete, color: Colors.red, size: 30,))
              ],
            ),
            TextField(
              controller: naslovController,
              decoration: InputDecoration(hintText: "NAZIV PREDMETA"),
              style: TextStyle(fontSize: 25),
            ),
            TextField(
              controller: tekstController,
              decoration: InputDecoration(hintText: "OCJENE"),
              style: TextStyle(fontSize: 25,               letterSpacing: 5.0,),
                keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[1-5]')),
                FilteringTextInputFormatter.digitsOnly
              ],

            ),
            SkolaracDugme(text: "DODAJ", onPressed: () {
              Navigator.of(context).pop(Predmet(naziv: naslovController.text, ocjene: tekstController.text.split("").map((e) => int.parse(e)).toList()));
            })
          ],
        ),
      ),
    );
  }
}
