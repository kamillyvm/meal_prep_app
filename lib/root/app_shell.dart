import 'package:flutter/material.dart';
import 'package:meal_prep_app/home/views/home_view.dart';
import 'package:meal_prep_app/planner/views/planner_view.dart';
import 'package:meal_prep_app/recipes/data/receitas_exemplo.dart';
import 'package:meal_prep_app/recipes/models/Receita.dart';
import 'package:meal_prep_app/recipes/viewmodels/recipes_viewmodel.dart';
import 'package:meal_prep_app/recipes/views/recipes_view.dart';
import 'package:meal_prep_app/shopping_list/viewmodels/listas_compras.dart';
import 'package:meal_prep_app/shopping_list/views/shopping_list_view.dart';

class AppShell extends StatefulWidget {
  final ListasCompras listasComprasViewModel;
  final int initialIndex;

  const AppShell({
    super.key,
    required this.listasComprasViewModel,
    this.initialIndex = 0,
  });

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late int _selectedIndex;
  late final RecipesViewModel _recipesViewModel;
  final List<Recipe> _receitasAdicionadasNaLista = [];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _recipesViewModel = RecipesViewModel();
  }

  @override
  void dispose() {
    _recipesViewModel.dispose();
    super.dispose();
  }

  void _aoAdicionarReceitaNaLista(Recipe receita) {
    widget.listasComprasViewModel.adicionarIngredientesDeReceita(receita);

    final jaExiste = _receitasAdicionadasNaLista.any((r) => r.id == receita.id);
    if (!jaExiste) {
      setState(() {
        _receitasAdicionadasNaLista.add(receita);
      });
    }
  }

  void _gerarListaDaSemana(List<Recipe> receitas) {
    widget.listasComprasViewModel.gerarListaDaSemana(receitas);
  }

  List<Recipe> _receitasParaPlanejar() {
    if (_receitasAdicionadasNaLista.isNotEmpty) {
      return _receitasAdicionadasNaLista;
    }

    final carregadas = _recipesViewModel.receitas;
    if (carregadas.isNotEmpty) return carregadas;

    return receitasExemploPlanner;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _recipesViewModel,
      builder: (context, _) {
        final pages = [
          HomeView(
            onIrParaPlanejar: () => _onDestinationSelected(1),
            onIrParaCompras: () => _onDestinationSelected(2),
            onIrParaReceitas: () => _onDestinationSelected(3),
          ),
          PlannerView(
            receitasDisponiveis: _receitasParaPlanejar(),
            onGerarListaCompras: _gerarListaDaSemana,
            onIrParaCompras: () => _onDestinationSelected(2),
            onIrParaReceitas: () => _onDestinationSelected(3),
          ),
          ShoppingListView(
            viewModel: widget.listasComprasViewModel,
            onSelecionarNavegacao: _onDestinationSelected,
          ),
          RecipesView(
            viewModel: _recipesViewModel,
            onAdicionarNaLista: _aoAdicionarReceitaNaLista,
            onIrParaPlanejar: () => _onDestinationSelected(1),
          ),
        ];

        return Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: pages,
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onDestinationSelected,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Início',
              ),
              NavigationDestination(
                icon: Icon(Icons.calendar_today_outlined),
                selectedIcon: Icon(Icons.calendar_today),
                label: 'Planejar',
              ),
              NavigationDestination(
                icon: Icon(Icons.shopping_bag_outlined),
                selectedIcon: Icon(Icons.shopping_bag),
                label: 'Compras',
              ),
              NavigationDestination(
                icon: Icon(Icons.menu_book_outlined),
                selectedIcon: Icon(Icons.menu_book),
                label: 'Receitas',
              ),
            ],
          ),
        );
      },
    );
  }

  void _onDestinationSelected(int index) {
    if (index == _selectedIndex) return;
    setState(() {
      _selectedIndex = index;
    });
  }
}