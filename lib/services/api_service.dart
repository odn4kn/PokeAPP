import 'package:app/models/pokemon_details.dart';
import 'package:dio/dio.dart';
import 'package:app/models/pokemon.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  static final Dio _dio = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2/', receiveTimeout: 10000));

  static Future<List<Pokemon>> fetchPokemonList({required int limit, required int offset}) async {
    try {
      final response = await _dio.get('pokemon', queryParameters: {
        'limit': limit,
        'offset': offset,
      });

      final results = response.data['results'] as List<dynamic>;
      final pokemonList = results.map((pokemon) {
        return Pokemon(
          id: getIdFromUrl(pokemon['url']),
          name: pokemon['name'],
          imageUrl:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/${getIdFromUrl(pokemon['url'])}.svg',
        );
      }).toList();

      return pokemonList;
    } catch (error) {
      throw 'Error fetching pokemon list: $error';
    }
  }

  static int getIdFromUrl(String url) {
    final uri = Uri.parse(url);
    return int.parse(uri.pathSegments[uri.pathSegments.length - 2]);
  }

  // Метод для получения подробной информации о покемоне по его идентификатору
  static Future<PokemonDetail> fetchPokemonDetails(int pokemonId) async {
    try {
      final response = await _dio.get('pokemon/$pokemonId');
      final pokemonDetailData = response.data;
      return PokemonDetail.fromJson(pokemonDetailData);
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching pokemon details: $error');
      }
      throw 'Error fetching pokemon details: $error';
    }
  }
}
