import 'package:hive_ce/hive.dart';
part 'Ingredient.g.dart';

@HiveType(typeId: 1)
class Ingredient extends HiveObject{
  @HiveField(0)
  final String name;

  @HiveField(1)
  final bool allergen;

  @HiveField(2)
  final int points;

  @HiveField(3)
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