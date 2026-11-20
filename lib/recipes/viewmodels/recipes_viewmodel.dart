import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:meal_prep_app/recipes/models/Ingrediente.dart';
import 'package:meal_prep_app/recipes/models/Receita.dart';
import 'package:meal_prep_app/recipes/services/recipe_repository.dart';

const categoriasReceita = ['Todas', 'Café da manhã', 'Almoço', 'Lanche', 'Jantar'];
const restricoesReceita = ['Vegetariana', 'Sem lactose', 'Sem glúten', 'Low carb'];
const opcoesOrdemReceita = ['Relevância', 'Menor tempo', 'Menos calorias'];
const opcoesTempoReceita = [null, 15, 30, 45, 60];
const opcoesDificuldadeReceita = [null, 'Fácil', 'Médio', 'Difícil'];

class RecipesViewModel extends ChangeNotifier {
  final RecipeRepository _repository;

  RecipesViewModel({RecipeRepository? repository})
      : _repository = repository ?? RecipeRepository();

  Timer? _debounce;

  String _termoBusca = '';
  List<Recipe> _receitas = [];
  int _paginaAtual = 0;
  bool _temMaisPaginas = false;
  bool _carregando = false;
  bool _veioDoCache = false;
  String? _avisoRede;

  int _categoriaSelecionada = 0;
  final Set<String> _restricoesAtivas = {};
  int? _tempoMax;
  String? _dificuldade;
  String _ordem = 'Relevância';
  final Set<String> _favoritas = {};
  final List<Ingrediente> _itensListaCompras = [];

  String get termoBusca => _termoBusca;
  List<Recipe> get receitas => List.unmodifiable(_receitas);
  bool get temMaisPaginas => _temMaisPaginas;
  bool get carregando => _carregando;
  bool get veioDoCache => _veioDoCache;
  String? get avisoRede => _avisoRede;
  int get categoriaSelecionada => _categoriaSelecionada;
  Set<String> get restricoesAtivas => Set.unmodifiable(_restricoesAtivas);
  int? get tempoMax => _tempoMax;
  String? get dificuldade => _dificuldade;
  String get ordem => _ordem;
  Set<String> get favoritas => Set.unmodifiable(_favoritas);
  List<Ingrediente> get itensListaCompras => List.unmodifiable(_itensListaCompras);

  List<Recipe> get receitasFiltradas {
    final texto = _termoBusca.trim().toLowerCase();

    final lista = _receitas.where((r) {
      final refeicoes = refeicoesDaReceita(r);
      final restricoes = restricoesDaReceita(r);

      if (_categoriaSelecionada != 0 &&
          !refeicoes.contains(categoriasReceita[_categoriaSelecionada])) {
        return false;
      }
      if (texto.isNotEmpty) {
        final noTitulo = r.title.toLowerCase().contains(texto);
        final nosIngredientes = r.ingredients.any(
              (ing) => ing.nome.toLowerCase().contains(texto),
        );
        if (!noTitulo && !nosIngredientes) return false;
      }
      for (final restricao in _restricoesAtivas) {
        if (!restricoes.contains(restricao)) return false;
      }
      if (_tempoMax != null && r.prepTimeMinutes > _tempoMax!) return false;
      if (_dificuldade != null && r.difficulty != _dificuldade) return false;
      return true;
    }).toList();

    if (_ordem == 'Menor tempo') {
      lista.sort((a, b) => a.prepTimeMinutes.compareTo(b.prepTimeMinutes));
    } else if (_ordem == 'Menos calorias') {
      lista.sort((a, b) => a.calories.compareTo(b.calories));
    }
    return lista;
  }

  void aoAlterarBusca(String valor) {
    _termoBusca = valor;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 450), () {
      buscarReceitas(reiniciarPagina: true);
    });
  }

  Future<void> buscarReceitas({required bool reiniciarPagina}) async {
    if (reiniciarPagina) _paginaAtual = 0;

    _carregando = true;
    _avisoRede = null;
    notifyListeners();

    final resultado = await _repository.buscarReceitas(
      query: _termoBusca,
      pagina: _paginaAtual,
    );

    if (reiniciarPagina) {
      _receitas = resultado.receitas;
    } else {
      final idsExistentes = _receitas.map((r) => r.id).toSet();
      final novos = resultado.receitas
          .where((r) => !idsExistentes.contains(r.id))
          .toList();
      _receitas = [..._receitas, ...novos];
    }

    _temMaisPaginas = resultado.temMaisPaginas;
    _veioDoCache = resultado.veioDoCache;
    _avisoRede = resultado.aviso;
    _carregando = false;
    notifyListeners();
  }

  Future<void> carregarMais20() async {
    if (_carregando || !_temMaisPaginas) return;
    _paginaAtual += 1;
    await buscarReceitas(reiniciarPagina: false);
  }

  void selecionarCategoria(int indice) {
    _categoriaSelecionada = indice;
    notifyListeners();
  }

  void alternarRestricao(String restricao) {
    _restricoesAtivas.contains(restricao)
        ? _restricoesAtivas.remove(restricao)
        : _restricoesAtivas.add(restricao);
    notifyListeners();
  }

  void alterarOrdem(String novaOrdem) {
    _ordem = novaOrdem;
    notifyListeners();
  }

  void aplicarFiltrosAvancados({int? novoTempoMax, String? novaDificuldade}) {
    _tempoMax = novoTempoMax;
    _dificuldade = novaDificuldade;
    notifyListeners();
  }

  void alternarFavorita(String idReceita) {
    _favoritas.contains(idReceita)
        ? _favoritas.remove(idReceita)
        : _favoritas.add(idReceita);
    notifyListeners();
  }

  void adicionarIngredientesNaLista(Recipe receita) {
    for (final novoIng in receita.ingredients) {
      final indiceExistente = _itensListaCompras.indexWhere(
            (item) =>
        item.nome.toLowerCase() == novoIng.nome.toLowerCase() &&
            item.unidade.toLowerCase() == novoIng.unidade.toLowerCase(),
      );

      if (indiceExistente >= 0) {
        final atual = _itensListaCompras[indiceExistente];
        _itensListaCompras[indiceExistente] = Ingrediente(
          nome: atual.nome,
          quantidade: atual.quantidade + novoIng.quantidade,
          unidade: atual.unidade,
          setorMercado: atual.setorMercado,
        );
      } else {
        _itensListaCompras.add(
          Ingrediente(
            nome: novoIng.nome,
            quantidade: novoIng.quantidade,
            unidade: novoIng.unidade,
            setorMercado: novoIng.setorMercado,
          ),
        );
      }
    }
    notifyListeners();
  }

  void limparFiltros() {
    _termoBusca = '';
    _categoriaSelecionada = 0;
    _restricoesAtivas.clear();
    _tempoMax = null;
    _dificuldade = null;
    notifyListeners();
    buscarReceitas(reiniciarPagina: true);
  }

  List<String> refeicoesDaReceita(Recipe r) {
    final texto = '${r.title} ${r.instructions}'.toLowerCase();
    final lista = <String>[];
    if (texto.contains('breakfast') ||
        texto.contains('pancake') ||
        texto.contains('egg')) {
      lista.add('Café da manhã');
    }
    if (texto.contains('snack') ||
        texto.contains('muffin') ||
        texto.contains('cookie')) {
      lista.add('Lanche');
    }
    if (texto.contains('dinner') ||
        texto.contains('soup') ||
        texto.contains('salad')) {
      lista.add('Jantar');
    }
    if (lista.isEmpty) lista.add('Almoço');
    return lista;
  }

  List<String> restricoesDaReceita(Recipe r) {
    final ingTexto = r.ingredients
        .map((i) => '${i.nome} ${i.setorMercado}')
        .join(' ')
        .toLowerCase();
    final tags = <String>[];

    final temCarne = ingTexto.contains('chicken') ||
        ingTexto.contains('beef') ||
        ingTexto.contains('pork') ||
        ingTexto.contains('fish') ||
        ingTexto.contains('salmon') ||
        ingTexto.contains('shrimp') ||
        ingTexto.contains('açougue');

    final temLactose = ingTexto.contains('milk') ||
        ingTexto.contains('cheese') ||
        ingTexto.contains('butter') ||
        ingTexto.contains('cream') ||
        ingTexto.contains('yogurt') ||
        ingTexto.contains('laticínios');

    final temGluten = ingTexto.contains('flour') ||
        ingTexto.contains('bread') ||
        ingTexto.contains('pasta') ||
        ingTexto.contains('wheat') ||
        ingTexto.contains('padaria');

    if (!temCarne) tags.add('Vegetariana');
    if (!temLactose) tags.add('Sem lactose');
    if (!temGluten) tags.add('Sem glúten');
    if (r.carbs <= 25) tags.add('Low carb');

    return tags;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}