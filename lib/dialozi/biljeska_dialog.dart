import 'package:flutter/material.dart';
import 'package:skolarac/model/biljeska.dart';
import 'package:skolarac/widgeti/skolarac_dugme.dart';

class BiljeskaDialog extends StatefulWidget {
  final Biljeska? biljeska;

  const BiljeskaDialog({super.key, this.biljeska});

  @override
  State<BiljeskaDialog> createState() => _BiljeskaDialogState();
}

class _BiljeskaDialogState extends State<BiljeskaDialog> {
  late TextEditingController naslovController = TextEditingController(text: widget.biljeska?.naslov);
  late TextEditingController tekstController = TextEditingController(text: widget.biljeska?.tekst);

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
                Text(widget.biljeska == null ? "Nova bilješka" : "Uredi bilješku"),
                Spacer(),
                if(widget.biljeska != null) IconButton(
                    onPressed: () {
                      Navigator.of(context).pop(Biljeska(naslov: "", tekst: ""));
                    },
                    icon: Icon(Icons.delete, color: Colors.red, size: 30,))
              ],
            ),
            TextField(
              controller: naslovController,
              decoration: InputDecoration(hintText: "Naslov"),
              style: TextStyle(fontSize: 25),
            ),
            TextField(
              controller: tekstController,
              minLines: 2,
              maxLines: 10,
              decoration: InputDecoration(hintText: "Tekst"),
              style: TextStyle(fontSize: 25),
            ),
            SkolaracDugme(text: "SAČUVAJ", onPressed: () {
              Navigator.of(context).pop(Biljeska(naslov: naslovController.text, tekst: tekstController.text));
            })
          ],
        ),
      ),
    );
  }
}
