import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app/models/pokemon.dart';
import 'package:app/services/api_service.dart';
import 'package:app/widgets/pokemon_card.dart';

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  late List<Pokemon> pokemonList = [];
  int limit = 20;
  int offset = 0;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    fetchData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final List<Pokemon> fetchedPokemonList =
          await ApiService.fetchPokemonList(
        limit: limit,
        offset: offset,
      );
      setState(() {
        pokemonList.addAll(fetchedPokemonList);
        isLoading = false;
      });
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching data: $error');
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  void _scrollListener() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        !isLoading) {
      setState(() {
        offset += limit;
      });
      fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Poke list',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
        centerTitle: true,
      ),
      body: pokemonList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1.0,
              ),
              itemCount: pokemonList.length + 1,
              itemBuilder: (context, index) {
                if (index == pokemonList.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                return PokemonCard(pokemon: pokemonList[index]);
              },
            ),
    );
  }
}
