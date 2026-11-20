import 'package:flutter/foundation.dart';
import 'package:meal_prep_app/recipes/models/Ingrediente.dart';
import 'package:meal_prep_app/recipes/models/Receita.dart';
import 'package:meal_prep_app/shopping_list/models/ListaCompras.dart';

class ListasCompras extends ChangeNotifier {
  final List<ListaCompras> _itens = [];

  List<ListaCompras> get itens => List.unmodifiable(_itens);

  int get totalItens => _itens.length;

  int get totalComprados => _itens.where((item) => item.comprado).length;

  int get totalPendentes => _itens.where((item) => !item.comprado).length;

  String _normalizarUnidade(String unidade) {
    final u = unidade.trim().toLowerCase();
    if (u == 'g' || u == 'grama' || u == 'gramas') return 'g';
    if (u == 'kg' || u == 'quilo' || u == 'quilos') return 'kg';
    if (u == 'ml' || u == 'mililitro' || u == 'mililitros') return 'ml';
    if (u == 'l' || u == 'litro' || u == 'litros') return 'l';
    if (u == 'un' || u == 'unid' || u == 'unidade' || u == 'unidades') {
      return 'un';
    }
    return u;
  }

  /// Adiciona os ingredientes de uma única receita na lista atual sem apagar
  /// os itens já existentes, somando quantidades quando nome e unidade batem.
  void adicionarIngredientesDeReceita(Recipe receita) {
    var alterou = false;

    for (final Ingrediente ingrediente in receita.ingredients) {
      final nomeLimpo = ingrediente.nome.trim();
      final unidadeLimpa = ingrediente.unidade.trim();
      if (nomeLimpo.isEmpty) continue;

      final unidadeNorm = _normalizarUnidade(unidadeLimpa);
      final chaveUnica = '${nomeLimpo.toLowerCase()}_$unidadeNorm';

      final indiceExistente = _itens.indexWhere(
            (item) =>
        !item.comprado &&
            '${item.nome.trim().toLowerCase()}_${_normalizarUnidade(item.unidade)}' ==
                chaveUnica,
      );

      if (indiceExistente != -1) {
        final itemExistente = _itens[indiceExistente];
        _itens[indiceExistente] = itemExistente.copyWith(
          quantidade: itemExistente.quantidade + ingrediente.quantidade,
        );
        alterou = true;
      } else {
        _itens.add(
          ListaCompras(
            id: '${DateTime.now().microsecondsSinceEpoch}_$chaveUnica',
            nome: nomeLimpo,
            quantidade: ingrediente.quantidade,
            unidade: unidadeLimpa,
            setorMercado: ingrediente.setorMercado.trim().isEmpty
                ? 'Mercearia'
                : ingrediente.setorMercado.trim(),
            comprado: false,
            isAvulso: false,
          ),
        );
        alterou = true;
      }
    }

    if (alterou) {
      notifyListeners();
    }
  }

  /// Consolida os ingredientes de todas as receitas planejadas na semana,
  /// somando quantidades quando nome e unidade coincidem, e preserva itens avulsos.
  void gerarListaDaSemana(List<Recipe> receitasDoCardapio) {
    final itensAvulsos = _itens.where((item) => item.isAvulso).toList();
    final Map<String, ListaCompras> mapaConsolidado = {};

    for (final recipe in receitasDoCardapio) {
      for (final Ingrediente ingrediente in recipe.ingredients) {
        final nomeLimpo = ingrediente.nome.trim();
        final unidadeLimpa = ingrediente.unidade.trim();
        if (nomeLimpo.isEmpty) continue;

        final unidadeNorm = _normalizarUnidade(unidadeLimpa);
        final chaveUnica = '${nomeLimpo.toLowerCase()}_$unidadeNorm';

        if (mapaConsolidado.containsKey(chaveUnica)) {
          final itemExistente = mapaConsolidado[chaveUnica]!;
          final novaQuantidade = itemExistente.quantidade + ingrediente.quantidade;

          mapaConsolidado[chaveUnica] = itemExistente.copyWith(
            quantidade: novaQuantidade,
          );
        } else {
          mapaConsolidado[chaveUnica] = ListaCompras(
            id: '${DateTime.now().microsecondsSinceEpoch}_$chaveUnica',
            nome: nomeLimpo,
            quantidade: ingrediente.quantidade,
            unidade: unidadeLimpa,
            setorMercado: ingrediente.setorMercado.trim().isEmpty
                ? 'Mercearia'
                : ingrediente.setorMercado.trim(),
            comprado: false,
            isAvulso: false,
          );
        }
      }
    }

    _itens
      ..clear()
      ..addAll(itensAvulsos)
      ..addAll(mapaConsolidado.values);

    notifyListeners();
  }

  void alternarStatusComprado(String id) {
    final index = _itens.indexWhere((item) => item.id == id);
    if (index != -1) {
      _itens[index] = _itens[index].copyWith(comprado: !_itens[index].comprado);
      notifyListeners();
    }
  }

  void adicionarItemAvulso({
    required String nome,
    required double quantidade,
    required String unidade,
    required String setorMercado,
  }) {
    final nomeLimpo = nome.trim();
    if (nomeLimpo.isEmpty) return;

    _itens.add(
      ListaCompras(
        id: '${DateTime.now().microsecondsSinceEpoch}_avulso',
        nome: nomeLimpo,
        quantidade: quantidade,
        unidade: unidade.trim(),
        setorMercado: setorMercado.trim().isEmpty
            ? 'Mercearia'
            : setorMercado.trim(),
        comprado: false,
        isAvulso: true,
      ),
    );
    notifyListeners();
  }

  void removerItem(String id) {
    _itens.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void desmarcarTodos() {
    var alterou = false;
    for (var i = 0; i < _itens.length; i++) {
      if (_itens[i].comprado) {
        _itens[i] = _itens[i].copyWith(comprado: false);
        alterou = true;
      }
    }
    if (alterou) notifyListeners();
  }

  void removerComprados() {
    final tamanhoAntes = _itens.length;
    _itens.removeWhere((item) => item.comprado);
    if (_itens.length != tamanhoAntes) notifyListeners();
  }

  void limparLista() {
    if (_itens.isEmpty) return;
    _itens.clear();
    notifyListeners();
  }
}