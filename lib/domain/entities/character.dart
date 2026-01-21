class Character {
  final String name;
  final String apiName;
  final String weakSide;

  const Character({
    required this.name,
    required this.apiName,
    required this.weakSide,
  });

  Character copyWith({
    String? name,
    String? apiName,
    String? weakSide,
  }) {
    return Character(
      name: name ?? this.name,
      apiName: apiName ?? this.apiName,
      weakSide: weakSide ?? this.weakSide,
    );
  }
}