import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skolarac/model/tema.dart';

class BojaDialog extends StatelessWidget {
  const BojaDialog({super.key});

  @override
  Widget build(BuildContext context) {
    Tema tema = Provider.of<Tema>(context);
    return Dialog(
        child: Container(
          padding: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("ODABERI TEMU"),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  tema.boja = TemaBoja.svijetla;
                  Navigator.of(context).pop();
                },
                leading: Icon(
                  Icons.sunny,
                  size: 40,
                ),
                title: Text(
                  "SVIJETLA",
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              ListTile(
                onTap: () {
                  tema.boja = TemaBoja.tamna;
                  Navigator.of(context).pop();
                },
                leading: Icon(Icons.dark_mode, size: 40),
                title: Text("TAMNA",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center),
              ),
              ListTile(
                onTap: () {
                  tema.boja = TemaBoja.auto;
                  Navigator.of(context).pop();
                },
                leading: Icon(Icons.brightness_medium_outlined, size: 40),
                title: Text("AUTOMATSKA",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
