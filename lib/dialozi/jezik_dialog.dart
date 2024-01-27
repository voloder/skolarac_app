import 'package:flutter/material.dart';

class JezikDialog extends StatefulWidget {
  const JezikDialog({super.key});

  @override
  State<JezikDialog> createState() => _JezikDialogState();
}

class _JezikDialogState extends State<JezikDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
    padding: EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Odaberite jezik", style: TextStyle(fontSize: 40, fontFamily: "RoadRage"),),
           ListTile(
             leading: Image.asset("assets/zastave/rs.png"),
             title: Text("Српски"),
             onTap: () {
               Navigator.of(context).pop("sr");
             },
           ),
            ListTile(
              leading: Image.asset("assets/zastave/ba.png"),
              title: Text("Bosanski"),
              onTap: () {
                Navigator.of(context).pop("en");
              },
            ),
            ListTile(
              leading: Image.asset("assets/zastave/gb.png"),
              title: Text("English"),
              onTap: () {
                Navigator.of(context).pop("en");
              },
            ),
        ]),
      )
    );
  }
}
