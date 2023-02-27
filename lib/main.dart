import 'package:peliculas/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/pages/peliculas_detalle_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: 'home',
      routes: {
        'home': (context) => HomePage(),
        'detalle': (context) => PeliculaDetalle(),
      },
    );
  }
}
