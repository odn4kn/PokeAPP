import 'package:app/models/pokemon_details.dart';
import 'package:app/utils/capitalize_first_letter.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/pokemon_details_screen.dart';
import 'package:app/services/api_service.dart';
import 'package:app/models/pokemon.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.network(
                  pokemon.imageUrl,
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 8),
                Text(
                  capitalizeFirstLetter(pokemon.name),
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  '#${pokemon.id.toString()}',
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
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

  void _navigateToPokemonDetails(
      BuildContext context, PokemonDetail pokemonDetails) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PokemonDetailScreen(
          initialPokemonId: pokemonDetails.id,
        ),
      ),
    );
  }
}
