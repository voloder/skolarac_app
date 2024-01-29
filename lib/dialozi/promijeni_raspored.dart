import 'package:flutter/material.dart';
import 'package:skolarac/widgeti/skolarac_dugme.dart';

class PromijeniRaspored extends StatefulWidget {
  final int dan;
  final List<String> casovi;

  const PromijeniRaspored({super.key, required this.dan, required this.casovi});

  @override
  State<PromijeniRaspored> createState() => _PromijeniRasporedState();
}

class _PromijeniRasporedState extends State<PromijeniRaspored> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Promijeni raspored"),
            for (int cas = 0; cas < 6; cas++)
              Row(
                children: [
                  Text("${cas + 1}. "),
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(text: widget.casovi[cas]),
                      onChanged: (value) {
                        widget.casovi[cas] = value;
                      },
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            SkolaracDugme(
              text: "SAČUVAJ",
                onPressed: () {
                  Navigator.of(context).pop(widget.casovi);
                },)
          ],
        ),
      ),
    );
  }
}
