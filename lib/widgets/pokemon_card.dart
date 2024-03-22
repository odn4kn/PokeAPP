import 'package:app/models/pokemon_details.dart';
import 'package:app/utils/capitalize_first_letter.dart';
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
              width: 120,
              height: 120,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 8.0),
            Text(
              capitalizeFirstLetter(pokemon.name),
              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchAndNavigate(BuildContext context) async {
    try {
      final pokemonDetails = await ApiService.fetchPokemonDetails(pokemon.id);
      _navigateToPokemonDetails(context, pokemonDetails);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error fetching pokemon stat :('),
        ),
      );
    }
  }

  void _navigateToPokemonDetails(BuildContext context, PokemonDetail pokemonDetails) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PokemonDetailScreen(
          pokemonDetail: pokemonDetails,
        ),
      ),
    );
  }
}
