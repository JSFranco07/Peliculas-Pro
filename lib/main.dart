import 'package:flutter/material.dart';
import 'package:peliculas_definitivo/src/pages/home_page.dart';
import 'package:peliculas_definitivo/src/pages/pelicula_detalle_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context ) => HomePage(),
        'detalle': (BuildContext context ) => PeliculaDetalle(),
      },     
    );
  }
}