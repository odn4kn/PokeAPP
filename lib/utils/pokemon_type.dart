import 'package:flutter/material.dart';

class PokemonType {
  final String type;

  static final Map<String, Color> typeColors = {
    'normal': Colors.grey,
    'fire': Colors.red,
    'water': Colors.blue,
    'electric': Colors.yellow,
    'grass': Colors.green,
    'ice': Colors.lightBlue,
    'fighting': Colors.orange,
    'poison': Colors.purple,
    'ground': Colors.brown,
    'flying': Colors.cyan,
    'psychic': Colors.pink,
    'bug': Colors.lime,
    'rock': Colors.amber,
    'ghost': Colors.indigo,
    'dragon': Colors.deepPurple,
    'dark': Colors.brown,
    'steel': Colors.blueGrey,
    'fairy': Colors.pinkAccent,
  };

  PokemonType({required this.type});

  Color getColor() {
    return typeColors.putIfAbsent(type, () => Colors.grey);
  }
}
