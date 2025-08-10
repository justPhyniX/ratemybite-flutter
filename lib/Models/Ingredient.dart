class Ingredient {
  final String name;
  final bool allergen;
  final int points;
  final String description;

  Ingredient(
    this.name,
    this.allergen,
    this.points,
    this.description
  );

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      json['name'] as String,
      json['allergen'] as bool,
      json['points'] as int,
      json['description'] as String,
    );
  }
}