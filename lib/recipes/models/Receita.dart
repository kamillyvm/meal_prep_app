import 'package:meal_prep_app/recipes/models/Ingrediente.dart';

class Recipe {
  final String id;
  final String title;
  final String photoUrl;
  final int prepTimeMinutes;
  final String difficulty;
  final int servings;
  final List<Ingrediente> ingredients;
  final String instructions;

  final double calories;
  final double protein;
  final double carbs;
  final double fats;

  Recipe({
    required this.id,
    required this.title,
    required this.photoUrl,
    required this.prepTimeMinutes,
    required this.difficulty,
    required this.servings,
    required this.ingredients,
    required this.instructions,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      prepTimeMinutes: json['prepTimeMinutes'] ?? 0,
      difficulty: json['difficulty'] ?? 'Fácil',
      servings: json['servings'] ?? 1,
      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((item) => Ingrediente.fromJson(item))
          .toList() ??
          [],
      instructions: json['instructions'] ?? '',
      calories: (json['calories'] ?? 0.0).toDouble(),
      protein: (json['protein'] ?? 0.0).toDouble(),
      carbs: (json['carbs'] ?? 0.0).toDouble(),
      fats: (json['fats'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'photoUrl': photoUrl,
      'prepTimeMinutes': prepTimeMinutes,
      'difficulty': difficulty,
      'servings': servings,
      'ingredients': ingredients.map((i) => i.toJson()).toList(),
      'instructions': instructions,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fats': fats,
    };
  }
}