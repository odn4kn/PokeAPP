import 'package:app/models/pokemon_stat.dart';

class PokemonDetailsArguments {
  final String pokemonName;
  final PokemonStat pokemonStat;

  PokemonDetailsArguments({required this.pokemonName, required this.pokemonStat});
}
