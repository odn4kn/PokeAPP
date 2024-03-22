import 'package:app/utils/capitalize_first_letter.dart';
import 'package:flutter/material.dart';
import '../utils/pokemon_type.dart';

class TypeChip extends StatelessWidget {
  final String type;

  const TypeChip({required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: PokemonType(type: type).getColor(),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Text(
            capitalizeFirstLetter(type),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
