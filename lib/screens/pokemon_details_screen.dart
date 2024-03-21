import 'package:app/models/pokemon_stat.dart';
import 'package:flutter/material.dart';

class PokemonDetailsScreen extends StatelessWidget {
  final String pokemonName;
  final String pokemonImageUrl;
  final PokemonStat pokemonStat;

  const PokemonDetailsScreen({
    super.key, 
    required this.pokemonName,
    required this.pokemonImageUrl,
    required this.pokemonStat,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemonName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(pokemonImageUrl),
          ],
        ),
      ),
    );
  }
}
