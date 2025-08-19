class IngredientDto {
  final String name;

  IngredientDto(
    this.name,
  );

  factory IngredientDto.fromJson(Map<String, dynamic> json) {
    return IngredientDto(
      json['name'] as String
    );
  }
}