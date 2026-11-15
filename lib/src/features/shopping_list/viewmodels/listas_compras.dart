import 'package:flutter/foundation.dart';
import '../../recipes/models/receita.dart'; // Ajuste o caminho do seu import
import '../../recipes/models/ingrediente.dart'; // Ajuste o caminho do seu import
import '../models/ListaCompras.dart'; // Nome do arquivo onde está a classe ListaCompras

class Listas_Compras extends ChangeNotifier {
  final List<ListaCompras> _itens = [];

  List<ListaCompras> get itens => _itens;

  // Motor de consolidação e soma de ingredientes
  void gerarListaDaSemana(List<Recipe> receitasDoCardapio) {
    _itens.clear();
    final Map<String, ListaCompras> mapaConsolidado = {};

    for (var receita in receitasDoCardapio) {
      for (var ingrediente in receita.ingredients) {
        String nomeNormalizado = ingrediente.nome.trim().toLowerCase();
        String unidadeNormalizada = ingrediente.unidade.trim().toLowerCase();
        String chaveUnica = '${nomeNormalizado}_$unidadeNormalizada';

        if (mapaConsolidado.containsKey(chaveUnica)) {
          var itemExistente = mapaConsolidado[chaveUnica]!;
          double novaQuantidade = itemExistente.quantidade + ingrediente.quantidade;

          mapaConsolidado[chaveUnica] = itemExistente.copyWith(
            quantidade: novaQuantidade,
          );
        } else {
          mapaConsolidado[chaveUnica] = ListaCompras(
            id: DateTime.now().microsecondsSinceEpoch.toString() + nomeNormalizado,
            nome: ingrediente.nome.trim(),
            quantidade: ingrediente.quantidade,
            unidade: ingrediente.unidade.trim(),
            setorMercado: ingrediente.setorMercado,
            comprado: false,
            isAvulso: false,
          );
        }
      }
    }

    _itens.addAll(mapaConsolidado.values);
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
    _itens.add(ListaCompras(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      nome: nome.trim(),
      quantidade: quantidade,
      unidade: unidade.trim(),
      setorMercado: setorMercado.trim().isEmpty ? 'Mercearia' : setorMercado,
      comprado: false,
      isAvulso: true,
    ));
    notifyListeners();
  }

  void removerItem(String id) {
    _itens.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}