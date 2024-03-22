import 'package:flutter/material.dart';
import 'package:app/models/pokemon_details.dart';
import 'package:app/utils/pokemon_type.dart';
import 'package:app/utils/capitalize_first_letter.dart';
import 'package:app/utils/pokemon_stat.dart';
import 'package:app/widgets/type_chip.dart';

class PokemonDetailScreen extends StatelessWidget {
  final PokemonDetail? pokemonDetail;

  const PokemonDetailScreen({this.pokemonDetail, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(capitalizeFirstLetter(pokemonDetail!.name)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: PokemonType(type: pokemonDetail!.types[0].typeName)
                  .getColor()
                  .withOpacity(0.7),
              height: 200,
              child: Center(
                child: Image.network(
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemonDetail!.id}.png',
                  fit: BoxFit.fill,
                  height: 150,
                  width: 150,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: pokemonDetail!.types.map((type) {
                  return Padding(
                    padding: const EdgeInsets.all(4),
                    child: TypeChip(type: type.typeName),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Center(
                    child: Text(
                      'About:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.monitor_weight_outlined, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            'Weight: ${(pokemonDetail!.weight / 10).toStringAsFixed(1)}kg',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.height_rounded, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            'Height: ${(pokemonDetail!.height / 10).toStringAsFixed(1)}m',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Abilities:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: pokemonDetail!.abilities.map((ability) {
                      return Row(
                        children: [
                          const Icon(Icons.star,
                              size: 16,
                              color: Colors
                                  .amber), // Иконка или другой символ для навыка
                          const SizedBox(width: 8),
                          Text(
                            capitalizeFirstLetter(ability.name),
                            style: TextStyle(
                              fontSize: 16,
                              color: PokemonType(type: pokemonDetail!.types[0].typeName).getColor(), // Цвет текста навыка
                              fontWeight: FontWeight
                                  .bold, // Жирный стиль для некоторых навыков
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Base Stats:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: pokemonDetail!.stats.map((stat) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 80,
                              child: Text(
                                statNameMapping[stat.statName] ?? '',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: LinearProgressIndicator(
                                value: stat.baseStat / 100,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  PokemonType(
                                          type:
                                              pokemonDetail!.types[0].typeName)
                                      .getColor(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              stat.baseStat.toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
