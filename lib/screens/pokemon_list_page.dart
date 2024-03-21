import 'package:app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:app/models/pokemon.dart';
import 'package:app/widgets/pokemon_card.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  _PokemonListPageState createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  late List<Pokemon> pokemonList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final List<Pokemon> fetchedPokemonList =
        await ApiService.fetchPokemonList();
    setState(() {
      pokemonList = fetchedPokemonList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poke list'),
      ),
      body: pokemonList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1.0,
              ),
              itemCount: pokemonList.length,
              itemBuilder: (context, index) {
                return PokemonCard(pokemon: pokemonList[index]);
              },
            ),
    );
  }
}
