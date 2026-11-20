import 'package:flutter/material.dart';
import 'package:meal_prep_app/root/app_shell.dart';
import 'package:meal_prep_app/shopping_list/viewmodels/listas_compras.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ListasCompras _listasComprasViewModel = ListasCompras();

  @override
  void dispose() {
    _listasComprasViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Prep & Shopping',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: AppShell(listasComprasViewModel: _listasComprasViewModel),
      debugShowCheckedModeBanner: false,
    );
  }
}