class Recipe {
  final String image;
  final double energy;
  final List ingredientLines;
  final String label;
  final double protein;
  final double carbohydrates;
  final double fat;
  final double water;
  final double fiber;

  Recipe({
    required this.image,
    required this.label,
    required this.ingredientLines,
    required this.energy,
    required this.protein,
    required this.carbohydrates,
    required this.fat,
    required this.water,
    required this.fiber,
  });
}
