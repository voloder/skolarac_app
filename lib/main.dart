import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skolarac/model/korisnik.dart';
import 'package:skolarac/model/tema.dart';
import 'package:skolarac/stranice/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<Korisnik>(create: (_) => Korisnik()),
          ChangeNotifierProvider<Tema>(create: (_) => Tema())
        ],
        builder: (context, widget) =>
          MaterialApp(
            title: 'Mobilni školarac',
            theme: ThemeData(
              colorScheme: Provider.of<Tema>(context).getColorScheme(),

              fontFamily: "RoadRage",
              fontFamilyFallback: ["Oswald"],
              useMaterial3: true,
              textTheme: TextTheme(
                displayLarge: const TextStyle(
                  fontSize: 72,
                ),
                // ···
                titleLarge: const TextStyle(
                  fontSize: 36,
                ),
                bodyMedium: const TextStyle(
                  fontSize: 36,
                ),
              ),
            ),
            home: HomePage(),
          )
        );

  }


}
