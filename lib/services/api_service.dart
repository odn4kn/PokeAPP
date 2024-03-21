import 'package:app/models/pokemon_stat.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:app/models/pokemon.dart';

class ApiService {
  static final Dio _dio = Dio();

  static Future<List<Pokemon>> fetchPokemonList() async {
    try {
      final response = await _dio.get('https://pokeapi.co/api/v2/pokemon');
      final results = response.data['results'] as List<dynamic>;
      return results.map((pokemon) {
        return Pokemon(
          id: getIdFromUrl(pokemon['url']),
          name: pokemon['name'],
          imageUrl:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${getIdFromUrl(pokemon['url'])}.png',
        );
      }).toList();
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching data: $error');
      }
      return [];
    }
  }

  static int getIdFromUrl(String url) {
    final uri = Uri.parse(url);
    return int.parse(uri.pathSegments[uri.pathSegments.length - 2]);
  }

  static Future<PokemonStat> fetchPokemonStat(int pokemonId) async {
    try {
      final response = await _dio.get('https://pokeapi.co/api/v2/pokemon/$pokemonId');
      final pokemonStatData = response.data;
      return PokemonStat.fromJson(pokemonStatData);
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching pokemon stat: $error');
      }
      throw 'Error fetching pokemon stat: $error';
    }
  }
}
