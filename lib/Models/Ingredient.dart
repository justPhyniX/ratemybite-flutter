class Ingredient {
  final String name;
  final bool allergen;
  final int points;
  final String description;

  Ingredient(
    {
      required this.name,
      required this.allergen,
      required this.points,
      required this.description
    }
  );
}