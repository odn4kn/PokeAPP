class PokemonStat {
  final List<Nature> decreaseNatures;
  final List<Nature> increaseNatures;

  PokemonStat({
    required this.decreaseNatures,
    required this.increaseNatures,
  });

  factory PokemonStat.fromJson(Map<String, dynamic> json) {
    List<dynamic> decreaseNaturesData = [];
    List<dynamic> increaseNaturesData = [];
    if (json['affecting_natures'] != null) {
      decreaseNaturesData = json['affecting_natures']['decrease'] ?? [];
      increaseNaturesData = json['affecting_natures']['increase'] ?? [];
    }

    List<Nature> decreaseNatures =
        decreaseNaturesData.map((data) => Nature.fromJson(data)).toList();

    List<Nature> increaseNatures =
        increaseNaturesData.map((data) => Nature.fromJson(data)).toList();

    return PokemonStat(
      decreaseNatures: decreaseNatures,
      increaseNatures: increaseNatures,
    );
  }
}

class Nature {
  final int maxChange;
  final String name;

  Nature({required this.maxChange, required this.name});

  factory Nature.fromJson(Map<String, dynamic> json) {
    return Nature(
      maxChange: json['max_change'] ?? 0,
      name: json['nature']['name'] ?? '',
    );
  }
}
