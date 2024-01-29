import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skolarac/model/korisnik.dart';
import 'package:skolarac/model/tema.dart';
import 'package:skolarac/stranice/home.dart';

/*

Kod radio: Admir Voloder

Nastaviti dalje uz naročitu opreznost

 */

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Tema.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
              fontFamilyFallback: ["Oswald"], // cirilica fallback font
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
