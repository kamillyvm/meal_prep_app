import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:meal_prep_app/recipes/models/Ingrediente.dart';
import 'package:meal_prep_app/recipes/models/Receita.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultadoBuscaReceitas {
  final List<Recipe> receitas;
  final int totalDisponivel;
  final bool veioDoCache;
  final bool temMaisPaginas;
  final String? aviso;

  const ResultadoBuscaReceitas({
    required this.receitas,
    required this.totalDisponivel,
    required this.veioDoCache,
    required this.temMaisPaginas,
    this.aviso,
  });
}

class RecipeRepository {
  static const int tamanhoPagina = 20;
  static const String _chaveCache = 'meal_prep_cache_receitas_v1';
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  // Letras usadas para popular um catálogo amplo a partir da TheMealDB
  static const List<String> _letrasCatalogo = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'r',
    's',
    't',
    'v',
    'w',
  ];

  final http.Client _client;

  RecipeRepository({http.Client? client}) : _client = client ?? http.Client();

  /// Salva/mescla receitas no cache local sem duplicar por `id`.
  Future<void> salvarNoCache(List<Recipe> novasReceitas) async {
    if (novasReceitas.isEmpty) return;

    final atuais = await obterTodasDoCache();
    final Map<String, Recipe> porId = {
      for (final r in atuais) r.id: r,
    };

    for (final r in novasReceitas) {
      porId[r.id] = r;
    }

    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(
      porId.values.map((r) => r.toJson()).toList(),
    );
    await prefs.setString(_chaveCache, encoded);
  }

  /// Retorna todas as receitas salvas no cache local.
  Future<List<Recipe>> obterTodasDoCache() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_chaveCache);
    if (raw == null || raw.trim().isEmpty) return [];

    try {
      final List<dynamic> decoded = jsonDecode(raw) as List<dynamic>;
      return decoded
          .where((item) => item is Map<String, dynamic>)
          .map((item) => Recipe.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  /// Consulta um único termo na TheMealDB.
  Future<List<Recipe>> _buscarTermoNaApi(String termo) async {
    final uri = Uri.parse(
      '$_baseUrl/search.php?s=${Uri.encodeQueryComponent(termo)}',
    );
    final response = await _client.get(uri).timeout(const Duration(seconds: 8));

    if (response.statusCode != 200) {
      throw HttpException('Status ${response.statusCode}');
    }

    final Map<String, dynamic> body =
    jsonDecode(response.body) as Map<String, dynamic>;
    final List<dynamic>? meals = body['meals'] as List<dynamic>?;

    if (meals == null) return <Recipe>[];

    return meals
        .where((item) => item is Map<String, dynamic>)
        .map((item) => _converterMealParaRecipe(item as Map<String, dynamic>))
        .toList();
  }

  /// Coleta um lote maior de receitas na API varrendo letras do catálogo
  /// e salva no cache local para permitir paginação contínua de 20 em 20.
  Future<List<Recipe>> _coletarCatalogoAmploOnline({
    required int indiceLetraInicial,
    required int quantidadeLetras,
  }) async {
    final Map<String, Recipe> acumuladas = {};

    final limite = (indiceLetraInicial + quantidadeLetras)
        .clamp(0, _letrasCatalogo.length);

    for (int i = indiceLetraInicial; i < limite; i++) {
      final letra = _letrasCatalogo[i];
      final parciais = await _buscarTermoNaApi(letra);
      for (final r in parciais) {
        acumuladas[r.id] = r;
      }
    }

    final lista = acumuladas.values.toList();
    if (lista.isNotEmpty) {
      await salvarNoCache(lista);
    }
    return lista;
  }

  /// Busca online na TheMealDB se houver conexão; quando estiver offline
  /// (ou em falha de rede), busca exclusivamente no cache local em blocos de 20.
  Future<ResultadoBuscaReceitas> buscarReceitas({
    required String query,
    required int pagina, // começa em 0 (0 = itens 0..19, 1 = itens 20..39...)
  }) async {
    final termo = query.trim();

    try {
      List<Recipe> poolReceitas = [];

      if (termo.isEmpty) {
        // Garante que haja receitas suficientes para a página solicitada
        // varrendo letras da API e persistindo no cache.
        final cacheAtual = await obterTodasDoCache();
        final necessario = (pagina + 1) * tamanhoPagina;

        if (cacheAtual.length < necessario) {
          final letraStart = (pagina * 3) % _letrasCatalogo.length;
          await _coletarCatalogoAmploOnline(
            indiceLetraInicial: letraStart,
            quantidadeLetras: 4,
          );
          poolReceitas = await obterTodasDoCache();
        } else {
          // Atualiza também com a próxima fatia de letras em background leve
          final letraStart = (pagina * 2) % _letrasCatalogo.length;
          await _coletarCatalogoAmploOnline(
            indiceLetraInicial: letraStart,
            quantidadeLetras: 2,
          );
          poolReceitas = await obterTodasDoCache();
        }
      } else {
        // Busca direta pelo termo digitado + reforço por inicial se vier pouco
        final diretas = await _buscarTermoNaApi(termo);
        final Map<String, Recipe> unicas = {
          for (final r in diretas) r.id: r,
        };

        if (unicas.length < tamanhoPagina && termo.length > 1) {
          final inicial = termo[0].toLowerCase();
          final extras = await _buscarTermoNaApi(inicial);
          for (final r in extras) {
            final bateComTermo = r.title.toLowerCase().contains(termo.toLowerCase()) ||
                r.ingredients.any(
                      (ing) => ing.nome.toLowerCase().contains(termo.toLowerCase()),
                );
            if (bateComTermo) {
              unicas[r.id] = r;
            }
          }
        }

        poolReceitas = unicas.values.toList();
        await salvarNoCache(poolReceitas);
      }

      final inicio = (pagina * tamanhoPagina).clamp(0, poolReceitas.length);
      final fim = (inicio + tamanhoPagina).clamp(0, poolReceitas.length);
      final paginaAtual = poolReceitas.sublist(inicio, fim);

      final aindaHaLetrasCatalogo =
          termo.isEmpty && ((pagina + 1) * 3) < _letrasCatalogo.length;

      return ResultadoBuscaReceitas(
        receitas: paginaAtual,
        totalDisponivel: poolReceitas.length,
        veioDoCache: false,
        temMaisPaginas: fim < poolReceitas.length || aindaHaLetrasCatalogo,
      );
    } on SocketException {
      return _buscarApenasNoCachePaginado(
        termo: termo,
        pagina: pagina,
        aviso: 'Sem internet — buscando apenas no cache local (20 por página).',
      );
    } on TimeoutException {
      return _buscarApenasNoCachePaginado(
        termo: termo,
        pagina: pagina,
        aviso: 'Conexão lenta — buscando apenas no cache local (20 por página).',
      );
    } on HttpException {
      return _buscarApenasNoCachePaginado(
        termo: termo,
        pagina: pagina,
        aviso: 'API indisponível — buscando apenas no cache local (20 por página).',
      );
    } catch (_) {
      return _buscarApenasNoCachePaginado(
        termo: termo,
        pagina: pagina,
        aviso: 'Modo offline — exibindo receitas do cache local.',
      );
    }
  }

  /// Busca exclusivamente no cache local e fatia em blocos de 20 itens.
  Future<ResultadoBuscaReceitas> _buscarApenasNoCachePaginado({
    required String termo,
    required int pagina,
    String? aviso,
  }) async {
    final todas = await obterTodasDoCache();
    final termoLower = termo.toLowerCase();

    final filtradas = termoLower.isEmpty
        ? todas
        : todas.where((r) {
      final noTitulo = r.title.toLowerCase().contains(termoLower);
      final nosIngredientes = r.ingredients.any(
            (ing) => ing.nome.toLowerCase().contains(termoLower),
      );
      return noTitulo || nosIngredientes;
    }).toList();

    final inicio = (pagina * tamanhoPagina).clamp(0, filtradas.length);
    final fim = (inicio + tamanhoPagina).clamp(0, filtradas.length);
    final paginaAtual = filtradas.sublist(inicio, fim);

    return ResultadoBuscaReceitas(
      receitas: paginaAtual,
      totalDisponivel: filtradas.length,
      veioDoCache: true,
      temMaisPaginas: fim < filtradas.length,
      aviso: aviso,
    );
  }

  Recipe _converterMealParaRecipe(Map<String, dynamic> meal) {
    final List<Ingrediente> ingredientes = [];

    for (int i = 1; i <= 20; i++) {
      final nome = (meal['strIngredient$i'] as String?)?.trim() ?? '';
      final medida = (meal['strMeasure$i'] as String?)?.trim() ?? '';
      if (nome.isNotEmpty) {
        ingredientes.add(
          Ingrediente(
            nome: nome,
            quantidade: _extrairQuantidade(medida),
            unidade: _extrairUnidade(medida),
            setorMercado: _inferirSetor(nome),
          ),
        );
      }
    }

    final id = (meal['idMeal'] as String?)?.trim() ??
        DateTime.now().microsecondsSinceEpoch.toString();
    final titulo = (meal['strMeal'] as String?)?.trim() ?? 'Receita';
    final thumb = (meal['strMealThumb'] as String?)?.trim() ?? '';
    final instrucoes = (meal['strInstructions'] as String?)?.trim() ?? '';

    return Recipe(
      id: id,
      title: titulo,
      photoUrl: thumb,
      prepTimeMinutes: 25,
      difficulty: 'Médio',
      servings: 2,
      ingredients: ingredientes,
      instructions: instrucoes,
      calories: 350,
      protein: 22,
      carbs: 35,
      fats: 12,
    );
  }

  double _extrairQuantidade(String medida) {
    final match = RegExp(r'(\d+([.,]\d+)?)').firstMatch(medida);
    if (match == null) return 1.0;
    return double.tryParse(match.group(1)!.replaceAll(',', '.')) ?? 1.0;
  }

  String _extrairUnidade(String medida) {
    final semNumero = medida.replaceAll(RegExp(r'[\d.,/\s-]+'), ' ').trim();
    return semNumero.isEmpty ? 'un' : semNumero;
  }

  String _inferirSetor(String nomeIngrediente) {
    final n = nomeIngrediente.toLowerCase();
    if (n.contains('chicken') ||
        n.contains('beef') ||
        n.contains('pork') ||
        n.contains('fish') ||
        n.contains('salmon') ||
        n.contains('shrimp')) {
      return 'Açougue';
    }
    if (n.contains('milk') ||
        n.contains('cheese') ||
        n.contains('butter') ||
        n.contains('cream') ||
        n.contains('yogurt')) {
      return 'Laticínios';
    }
    if (n.contains('tomato') ||
        n.contains('onion') ||
        n.contains('garlic') ||
        n.contains('potato') ||
        n.contains('carrot') ||
        n.contains('lettuce') ||
        n.contains('banana') ||
        n.contains('lemon')) {
      return 'Hortifruti';
    }
    if (n.contains('bread') || n.contains('flour')) {
      return 'Padaria';
    }
    return 'Mercearia';
  }
}