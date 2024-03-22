class PokemonDetail {
  final int id;
  final String name;
  final int baseExperience;
  final List<Ability> abilities;
  final int height;
  final int weight;
  final List<GameIndex> gameIndices;
  final List<Type> types;
  final List<Stat> stats;
  final List<Form> forms;

  PokemonDetail({
    required this.id,
    required this.name,
    required this.baseExperience,
    required this.abilities,
    required this.height,
    required this.weight,
    required this.gameIndices,
    required this.types,
    required this.stats,
    required this.forms,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    List<Ability> parseAbilities(List<dynamic> abilities) {
      return abilities.map((ability) {
        return Ability(
          name: ability['ability']['name'],
          isHidden: ability['is_hidden'],
          slot: ability['slot'],
        );
      }).toList();
    }

    List<GameIndex> parseGameIndices(List<dynamic> gameIndices) {
      return gameIndices.map((index) {
        return GameIndex(
          gameIndex: index['game_index'],
          version: Version(
            name: index['version']['name'],
            url: index['version']['url'],
          ),
        );
      }).toList();
    }

    List<Type> parseTypes(List<dynamic> types) {
      return types.map((type) {
        return Type(
          slot: type['slot'],
          typeName: type['type']['name'],
          typeUrl: type['type']['url'],
        );
      }).toList();
    }

    List<Stat> parseStats(List<dynamic> stats) {
      return stats.map((stat) {
        return Stat(
          baseStat: stat['base_stat'],
          effort: stat['effort'],
          statName: stat['stat']['name'],
          statUrl: stat['stat']['url'],
        );
      }).toList();
    }

    List<Form> parseForms(List<dynamic> forms) {
      return forms.map((form) {
        return Form(
          formName: form['name'],
          formUrl: form['url'],
        );
      }).toList();
    }

    return PokemonDetail(
      id: json['id'],
      name: json['name'],
      baseExperience: json['base_experience'],
      abilities: parseAbilities(json['abilities']),
      height: json['height'],
      weight: json['weight'],
      gameIndices: parseGameIndices(json['game_indices']),
      types: parseTypes(json['types']),
      stats: parseStats(json['stats']),
      forms: parseForms(json['forms']),
    );
  }
}

class Ability {
  final String name;
  final bool isHidden;
  final int slot;

  Ability({
    required this.name,
    required this.isHidden,
    required this.slot,
  });
}

class GameIndex {
  final int gameIndex;
  final Version version;

  GameIndex({
    required this.gameIndex,
    required this.version,
  });
}

class Version {
  final String name;
  final String url;

  Version({
    required this.name,
    required this.url,
  });
}

class Type {
  final int slot;
  final String typeName;
  final String typeUrl;

  Type({
    required this.slot,
    required this.typeName,
    required this.typeUrl,
  });
}

class Stat {
  final int baseStat;
  final int effort;
  final String statName;
  final String statUrl;

  Stat({
    required this.baseStat,
    required this.effort,
    required this.statName,
    required this.statUrl,
  });
}

class Form {
  final String formName;
  final String formUrl;

  Form({
    required this.formName,
    required this.formUrl,
  });
}
