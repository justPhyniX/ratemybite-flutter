class ProductPostDto {
  final String barcode;
  final String foodCategory;
  final String brand;
  final String rating;
  final String productTitle;
  final List<String> ingredients;

  ProductPostDto(
    this.barcode,
    this.foodCategory,
    this.brand,
    this.rating,
    this.productTitle,
    this.ingredients
  );

  Map<String, dynamic> toJson() {
    return {
      'barcode': barcode,
      'foodCategoryName': foodCategory,
      'companyName': brand,
      'nutritionScore': rating,
      'name': productTitle,
      'ingredientNames': ingredients
    };
  }
}

String rate(List<int> ingredientScores) {
  int sum = 0;
  // Get each ingredient score and calculate the average
  for (final score in ingredientScores) {
    sum += score;
  }
  double average = sum / ingredientScores.length;

  // Pick a letter depending on the average price
  if (average > 0 && average <= 20) {
    return 'E';
  } else if (average > 20 && average <= 40) {
    return 'D';
  } else if (average > 40 && average <= 60) {
    return 'C';
  } else if (average > 60 && average <= 80) {
    return 'B';
  } else {
    return 'A';
  }
}