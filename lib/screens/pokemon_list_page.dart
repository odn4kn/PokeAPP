import 'package:flutter/material.dart';
import 'package:app/models/pokemon.dart';
import 'package:app/widgets/pokemon_card.dart';
import 'package:app/services/api_service.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({Key? key}) : super(key: key);

  @override
  _PokemonListPageState createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  late List<Pokemon> pokemonList;
  bool isLoading = false;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    pokemonList = [];
    fetchData();
  }

  Future<void> fetchData() async {
    if (!isLoading) {
      setState(() => isLoading = true);
      final List<Pokemon> fetchedPokemonList = await ApiService.fetchPokemonList(
        limit: 20,
        offset: currentPage * 20,
      );
      setState(() {
        pokemonList.addAll(fetchedPokemonList);
        isLoading = false;
        currentPage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poke list'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.0,
        ),
        itemCount: pokemonList.length + 1, // +1 для индикатора загрузки
        itemBuilder: (context, index) {
          if (index < pokemonList.length) {
            return PokemonCard(pokemon: pokemonList[index]);
          } else if (!isLoading) {
            fetchData(); // Загружаем новые данные при достижении конца списка
            return const SizedBox(height: 80.0, child: Center(child: CircularProgressIndicator()));
          } else {
            return const SizedBox(); // Пустой виджет для индикатора загрузки
          }
        },
      ),
    );
  }
}
