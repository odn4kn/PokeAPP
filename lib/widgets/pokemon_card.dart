import 'package:app/models/pokemon_stat.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/pokemon_details_screen.dart';
import 'package:app/services/api_service.dart';
import 'package:app/models/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({required this.pokemon, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          _fetchAndNavigate(context);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              pokemon.imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8.0),
            Text(
              pokemon.name,
              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchAndNavigate(BuildContext context) async {
    try {
      final pokemonStat = await ApiService.fetchPokemonStat(pokemon.id);
      _navigateToPokemonDetails(context, pokemonStat);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error fetching pokemon stat :('),
        ),
      );
    }
  }

  void _navigateToPokemonDetails(BuildContext context, PokemonStat pokemonStat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PokemonDetailsScreen(
          pokemonName: pokemon.name,
          pokemonImageUrl: pokemon.imageUrl,
          pokemonStat: pokemonStat,
        ),
      ),
    );
  }
}
