import 'package:app/pokemon.dart';
import 'package:flutter/material.dart';
import 'pokemon_list_page.dart';
import 'pokemon_details_screen.dart';

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
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PokemonListPage(),
        '/details': (context) => PokemonDetailsScreen(
              pokemonName: 'Speed',
              pokemonStat: PokemonStat(
                decreaseNatures: [],
                increaseNatures: [],
              ),
              pokemonImageUrl: '',
            ),
      },
    );
  }
}
