import 'package:flutter/material.dart';
import 'screens/pokemon_details_screen.dart';
import 'screens/pokemon_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PokemonListScreen(),
        '/details': (context) => const PokemonDetailScreen(),
      },
    );
  }
}
