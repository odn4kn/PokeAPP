import 'package:app/pokemon_details_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:app/pokemon.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
    try {
      final response = await Dio().get('https://pokeapi.co/api/v2/pokemon');
      final results = response.data['results'] as List<dynamic>;
      setState(() {
        pokemonList = results
            .map((pokemon) => Pokemon(
                  id: getIdFromUrl(pokemon['url']),
                  name: pokemon['name'],
                  imageUrl:
                      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${getIdFromUrl(pokemon['url'])}.png',
                ))
            .toList();
      });
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching data: $error');
      }
    }
  }

  int getIdFromUrl(String url) {
    final uri = Uri.parse(url);
    return int.parse(uri.pathSegments[uri.pathSegments.length - 2]);
  }

  void navigateToPokemonDetails(BuildContext context, Pokemon pokemon) async {
    _fetchPokemonStat(pokemon).then((pokemonStat) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PokemonDetailsScreen(
            pokemonName: pokemon.name,
            pokemonStat: pokemonStat,
            pokemonImageUrl: pokemon.imageUrl,
          ),
        ),
      );
    }).catchError((error) {
      if (kDebugMode) {
        print('Error fetching pokemon stat: $error');
      }
    });
  }

  Future<PokemonStat> _fetchPokemonStat(Pokemon pokemon) async {
    final response =
        await Dio().get('https://pokeapi.co/api/v2/pokemon/${pokemon.id}');
    final pokemonStatData = response.data;
    if (pokemonStatData != null) {
      final pokemonStat = PokemonStat.fromJson(pokemonStatData);
      return pokemonStat;
    } else {
      throw 'Error: Pokemon stat data is empty or null.';
    }
  }

  Widget buildPokemonCard(Pokemon pokemon) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          navigateToPokemonDetails(context, pokemon);
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
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
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
                return buildPokemonCard(pokemonList[index]);
              },
            ),
    );
  }
}
