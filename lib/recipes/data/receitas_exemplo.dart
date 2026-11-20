import 'package:meal_prep_app/recipes/models/Ingrediente.dart';
import 'package:meal_prep_app/recipes/models/Receita.dart';

final List<Recipe> receitasExemploPlanner = [
  Recipe(
    id: '1',
    title: 'Panqueca de Banana com Aveia',
    photoUrl: '',
    prepTimeMinutes: 15,
    difficulty: 'Fácil',
    servings: 1,
    calories: 280,
    protein: 12,
    carbs: 38,
    fats: 8,
    instructions: 'Misture tudo e leve à frigideira antiaderente.',
    ingredients: [
      Ingrediente(
        nome: 'Banana nanica',
        quantidade: 1,
        unidade: 'un',
        setorMercado: 'Hortifruti',
      ),
      Ingrediente(
        nome: 'Aveia em flocos',
        quantidade: 40,
        unidade: 'g',
        setorMercado: 'Mercearia',
      ),
      Ingrediente(
        nome: 'Ovo',
        quantidade: 1,
        unidade: 'un',
        setorMercado: 'Laticínios',
      ),
    ],
  ),
  Recipe(
    id: '2',
    title: 'Frango Grelhado com Legumes',
    photoUrl: '',
    prepTimeMinutes: 30,
    difficulty: 'Fácil',
    servings: 2,
    calories: 420,
    protein: 38,
    carbs: 22,
    fats: 14,
    instructions: 'Tempere o frango, grelhe e sirva com legumes cozidos.',
    ingredients: [
      Ingrediente(
        nome: 'Peito de frango',
        quantidade: 300,
        unidade: 'g',
        setorMercado: 'Açougue',
      ),
      Ingrediente(
        nome: 'Brócolis',
        quantidade: 150,
        unidade: 'g',
        setorMercado: 'Hortifruti',
      ),
      Ingrediente(
        nome: 'Cenoura',
        quantidade: 1,
        unidade: 'un',
        setorMercado: 'Hortifruti',
      ),
    ],
  ),
  Recipe(
    id: '3',
    title: 'Omelete de Vegetais & Queijo',
    photoUrl: '',
    prepTimeMinutes: 12,
    difficulty: 'Fácil',
    servings: 1,
    calories: 260,
    protein: 18,
    carbs: 6,
    fats: 17,
    instructions: 'Bata os ovos, junte os vegetais e cozinhe em fogo baixo.',
    ingredients: [
      Ingrediente(
        nome: 'Ovos',
        quantidade: 2,
        unidade: 'un',
        setorMercado: 'Laticínios',
      ),
      Ingrediente(
        nome: 'Tomate',
        quantidade: 0.5,
        unidade: 'un',
        setorMercado: 'Hortifruti',
      ),
      Ingrediente(
        nome: 'Queijo muçarela',
        quantidade: 30,
        unidade: 'g',
        setorMercado: 'Laticínios',
      ),
    ],
  ),
];