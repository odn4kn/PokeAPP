import 'package:app/models/pokemon.dart';
import 'package:app/models/pokemon_details.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // Импортируйте модели, если необходимо

class ApiService {
  static final Dio _dio = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2/', receiveTimeout: 10000));

  // Метод для получения списка покемонов
  static Future<List<Pokemon>> fetchPokemonList() async {
    try {
      final response = await _dio.get('pokemon');
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

  // Вспомогательный метод для извлечения ID из URL
  static int getIdFromUrl(String url) {
    final uri = Uri.parse(url);
    return int.parse(uri.pathSegments[uri.pathSegments.length - 2]);
  }
}
