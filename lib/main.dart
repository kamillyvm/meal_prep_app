import 'package:flutter/material.dart';
import 'package:meal_prep_app/src/features/shopping_list/viewmodels/listas_compras.dart';
import 'package:meal_prep_app/src/features/shopping_list/views/shopping_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final listasComprasViewModel = Listas_Compras();

    return MaterialApp(
      title: 'Meal Prep & Shopping',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const ShoppingListView(),
      debugShowCheckedModeBanner: false,
    );
  }
}