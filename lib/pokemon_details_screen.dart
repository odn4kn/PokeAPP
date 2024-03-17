import 'package:app/pokemon.dart';
import 'package:flutter/material.dart';

class PokemonDetailsScreen extends StatelessWidget {
  final String pokemonName;
  final PokemonStat pokemonStat;
  final String pokemonImageUrl;

  const PokemonDetailsScreen({
    super.key,
    required this.pokemonName,
    required this.pokemonStat,
    required this.pokemonImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$pokemonName's details"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pokemon Name: $pokemonName',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Image.network(
              pokemonImageUrl,
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            Text(
              'Pokemon decreaseNatures: ${pokemonStat.decreaseNatures}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Pokemon increaseNatures: ${pokemonStat.increaseNatures}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
