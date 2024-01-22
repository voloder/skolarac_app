import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skolarac/model/korisnik.dart';
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
        ],
        child: MaterialApp(
          title: 'Mobilni školarac',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF31a062), primary: Color(0xFF31a062)),
            useMaterial3: true,
          ),
          home: HomePage(),
        ));
  }
}
