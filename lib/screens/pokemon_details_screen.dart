// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:app/models/pokemon_details.dart';
import 'package:app/utils/pokemon_type.dart';
import 'package:app/utils/capitalize_first_letter.dart';
import 'package:app/utils/pokemon_stat.dart';
import 'package:app/widgets/type_chip.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PokemonDetailScreen extends StatefulWidget {
  final int? initialPokemonId;

  const PokemonDetailScreen({this.initialPokemonId, super.key});

  @override
  _PokemonDetailScreenState createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  late Future<PokemonDetail> futurePokemonDetail;
  late int _currentPokemonId;
  Color pokemonTypeColor = Colors.blue.shade700;

  @override
  void initState() {
    super.initState();
    _currentPokemonId = widget.initialPokemonId!;
    _fetchPokemonDetails();
  }

  void _fetchPokemonDetails() {
    futurePokemonDetail = ApiService.fetchPokemonDetails(_currentPokemonId);
    futurePokemonDetail.then((pokemonDetail) {
      setState(() {
        pokemonTypeColor = PokemonType(type: pokemonDetail.types[0].typeName).getColor();
      });
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error fetching pokemon details :(')),
      );
    });
  }

  Future<void> _loadNextPokemon() async {
    if (_currentPokemonId < 100) {
      setState(() {
        _currentPokemonId++;
        _fetchPokemonDetails();
      });
    }
  }

  Future<void> _loadPreviousPokemon() async {
    if (_currentPokemonId > 1) {
      setState(() {
        _currentPokemonId--;
        _fetchPokemonDetails();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: FutureBuilder<PokemonDetail>(
            future: futurePokemonDetail,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return const Text('Loading...');
              if (snapshot.hasError)
                return const Text('Error');

              final pokemonDetail = snapshot.data!;

              return Text(
                '${capitalizeFirstLetter(pokemonDetail.name)} #${pokemonDetail.id}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              );
            },
          ),
          backgroundColor: pokemonTypeColor.withOpacity(0.7),
          elevation: 0,
          centerTitle: true,
        ),
        body: FutureBuilder<PokemonDetail>(
            future: futurePokemonDetail,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return const Center(child: CircularProgressIndicator());
              if (snapshot.hasError)
                return const Center(child: Text('Error fetching data'));

              final pokemonDetail = snapshot.data!;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      color: pokemonTypeColor.withOpacity(0.7),
                      height: 200,
                      child: Stack(
                        children: [
                          Center(
                            child: SvgPicture.network(
                              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/${pokemonDetail.id}.svg',
                              width: 180,
                              height: 180,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Positioned(
                            left: 16,
                            top: 80,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back_ios),
                              onPressed: _loadPreviousPokemon,
                            ),
                          ),
                          Positioned(
                            right: 16,
                            top: 80,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_forward_ios),
                              onPressed: _loadNextPokemon,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: pokemonDetail.types.map((type) {
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
                          const Divider(height: 1, color: Colors.grey),
                          const SizedBox(height: 16),
                          const Center(
                            child: Text(
                              'About:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.monitor_weight_outlined,
                                      size: 20),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Weight: ${(pokemonDetail.weight / 10).toStringAsFixed(1)}kg',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.height_rounded, size: 20),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Height: ${(pokemonDetail.height / 10).toStringAsFixed(1)}m',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Divider(height: 1, color: Colors.grey),
                          const SizedBox(height: 8),
                          const Center(
                            child: Text(
                              'Abilities:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: pokemonDetail.abilities.map((ability) {
                              return Row(
                                children: [
                                  const Icon(Icons.star, size: 16, color: Colors.amber),
                                  const SizedBox(width: 8),
                                  Text(
                                    capitalizeFirstLetter(ability.name),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: pokemonTypeColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 15),
                          const Divider(height: 1, color: Colors.grey),
                          const SizedBox(height: 20),
                          const Center(
                            child: Text(
                              'Base Stats:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: pokemonDetail.stats.map((stat) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      child: Text(
                                        statNameMapping[stat.statName] ?? '',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      child: LinearProgressIndicator(
                                        value: stat.baseStat / 100,
                                        valueColor: AlwaysStoppedAnimation<Color>(pokemonTypeColor),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(stat.baseStat.toString(), style: const TextStyle(fontSize: 16)),
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
              );
            }));
  }
}
