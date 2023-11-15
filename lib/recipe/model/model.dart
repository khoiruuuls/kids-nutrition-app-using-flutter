class Recipe {
  final String image;
  final double calories;
  final List ingredientLines;
  final String label;
  final double protein;
  final double carbs;
  final double fat;

  Recipe({
    required this.image,
    required this.label,
    required this.ingredientLines,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
  });
}
