import 'package:flutter/foundation.dart';
import 'package:meal_prep_app/recipes/models/Receita.dart';

const List<String> refeicoesSemana = [
  'Café da Manhã',
  'Almoço',
  'Lanche',
  'Jantar',
];

class PlannerViewModel extends ChangeNotifier {
  /// Chave da semana: segunda-feira daquela semana (ano-mês-dia zerado).
  DateTime _semanaAtual = _inicioDaSemana(DateTime.now());

  /// Mapa: chaveSemana -> { 'segunda_Almoço': Recipe }
  final Map<String, Map<String, Recipe>> _gradePorSemana = {};

  DateTime get semanaAtual => _semanaAtual;

  String get chaveSemanaAtual => _chaveSemana(_semanaAtual);

  Map<String, Recipe> get alocacoesDaSemana {
    final mapa = _gradePorSemana[chaveSemanaAtual];
    return mapa == null ? const {} : Map.unmodifiable(mapa);
  }

  /// Todas as receitas alocadas na semana atual (prontas para `gerarListaDaSemana`).
  List<Recipe> get receitasDaSemana => alocacoesDaSemana.values.toList();

  static DateTime _inicioDaSemana(DateTime data) {
    final semHora = DateTime(data.year, data.month, data.day);
    final diferencaDias = semHora.weekday - DateTime.monday;
    return semHora.subtract(Duration(days: diferencaDias));
  }

  static String _chaveSemana(DateTime inicioSemana) {
    final d = _inicioDaSemana(inicioSemana);
    final mes = d.month.toString().padLeft(2, '0');
    final dia = d.day.toString().padLeft(2, '0');
    return '${d.year}-$mes-$dia';
  }

  String chaveSlot(int indiceDia, String refeicao) => '${indiceDia}_$refeicao';

  Recipe? receitaEm(int indiceDia, String refeicao) {
    return _gradePorSemana[chaveSemanaAtual]?[chaveSlot(indiceDia, refeicao)];
  }

  void mudarSemana(int deslocamentoSemanas) {
    _semanaAtual = _inicioDaSemana(
      _semanaAtual.add(Duration(days: deslocamentoSemanas * 7)),
    );
    notifyListeners();
  }

  void alocarReceita(int indiceDia, String refeicao, Recipe receita) {
    final mapa = _gradePorSemana.putIfAbsent(
      chaveSemanaAtual,
          () => <String, Recipe>{},
    );
    mapa[chaveSlot(indiceDia, refeicao)] = receita;
    notifyListeners();
  }

  void removerReceita(int indiceDia, String refeicao) {
    final mapa = _gradePorSemana[chaveSemanaAtual];
    if (mapa == null) return;
    mapa.remove(chaveSlot(indiceDia, refeicao));
    if (mapa.isEmpty) {
      _gradePorSemana.remove(chaveSemanaAtual);
    }
    notifyListeners();
  }

  /// Duplica o cardápio de uma semana anterior para a `_semanaAtual`.
  /// Retorna `false` se a semana de origem não tiver receitas.
  bool duplicarSemanaAnterior({int semanasAtras = 1}) {
    final origemData = _semanaAtual.subtract(Duration(days: semanasAtras * 7));
    final origemChave = _chaveSemana(origemData);
    final origemMapa = _gradePorSemana[origemChave];

    if (origemMapa == null || origemMapa.isEmpty) {
      return false;
    }

    _gradePorSemana[chaveSemanaAtual] = Map<String, Recipe>.from(origemMapa);
    notifyListeners();
    return true;
  }

  /// Lista de semanas anteriores que possuem cardápio salvo (mais recente primeiro).
  List<DateTime> semanasDisponiveisParaDuplicar() {
    final atualChave = chaveSemanaAtual;
    final datas = <DateTime>[];

    for (final chave in _gradePorSemana.keys) {
      if (chave == atualChave) continue;
      final mapa = _gradePorSemana[chave];
      if (mapa == null || mapa.isEmpty) continue;

      final partes = chave.split('-');
      if (partes.length == 3) {
        final ano = int.tryParse(partes[0]);
        final mes = int.tryParse(partes[1]);
        final dia = int.tryParse(partes[2]);
        if (ano != null && mes != null && dia != null) {
          datas.add(DateTime(ano, mes, dia));
        }
      }
    }

    datas.sort((a, b) => b.compareTo(a));
    return datas;
  }

  void duplicarDeSemanaEspecifica(DateTime semanaOrigem) {
    final origemChave = _chaveSemana(semanaOrigem);
    final origemMapa = _gradePorSemana[origemChave];
    if (origemMapa == null || origemMapa.isEmpty) return;

    _gradePorSemana[chaveSemanaAtual] = Map<String, Recipe>.from(origemMapa);
    notifyListeners();
  }
}