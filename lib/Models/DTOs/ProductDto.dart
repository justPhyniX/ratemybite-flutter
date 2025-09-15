import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:ratemybite/Models/Ingredient.dart';
part 'ProductDto.g.dart';

@HiveType(typeId: 0) // Assign a unique typeId
class ProductDto extends HiveObject{
  @HiveField(0)
  final String productTitle;

  @HiveField(1)
  final String brand;

  @HiveField(2)
  final String rating;

  @HiveField(3)
  final String productImage;

  @HiveField(4)
  final List<Ingredient> ingredients;

  @HiveField(5)
  final String description;

  ProductDto(
    this.productTitle,
    this.brand,
    this.rating,
    this.productImage,
    this.ingredients,
    this.description,
  );

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
      json['name'] as String,
      json['company']['name'] as String,
      json['nutritionScore'] as String,
      json['imagePath'] as String,
      (json['ingredients'] as List)
        .map((item) => Ingredient.fromJson(item)).toList(),
      (json['ingredients'] as List)
        .map((item) => item['description'] as String)
        .join(', '),
    );
  }
}