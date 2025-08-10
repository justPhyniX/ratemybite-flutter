import 'package:ratemybite/Models/Ingredient.dart';

class ProductDto {
  final String productTitle;
  final String brand;
  final String rating;
  final List<Ingredient> ingredients;
  final String description;

  ProductDto(
    this.productTitle,
    this.brand,
    this.rating,
    this.ingredients,
    this.description,
  );

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
      json['name'] as String,
      json['company']['name'] as String,
      json['nutritionScore'] as String,
      (json['ingredients'] as List)
        .map((item) => Ingredient.fromJson(item)).toList(),
      (json['ingredients'] as List)
        .map((item) => item['description'] as String)
        .join(', '),
    );
  }
}