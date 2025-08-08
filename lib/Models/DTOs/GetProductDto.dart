import 'package:ratemybite/Models/Ingredient.dart';

class GetProductDto {
  final String productTitle;
  final String brand;
  final String rating;
  final List<Ingredient> ingredients;
  final String description;

  GetProductDto(
    {
      required this.productTitle,
      required this.brand,
      required this.rating,
      required this.ingredients,
      required this.description
    }
  );
}