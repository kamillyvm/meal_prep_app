import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meal_prep_app/recipes/models/Receita.dart';
import 'package:meal_prep_app/recipes/viewmodels/recipes_viewmodel.dart';

const _corFundo = Color(0xFFFBF9F4);
const _corBranco = Color(0xFFFFFFFF);
const _corCardClaro = Color(0xFFF5F3EE);
const _corCinzaClaro = Color(0xFFEAE8E3);
const _corCinzaFoto = Color(0xFFF0EEE9);
const _corCinzaIcone = Color(0xFF717973);
const _corTexto = Color(0xFF1B1C19);
const _corTextoSuave = Color(0xFF414943);
const _corVerde = Color(0xFF3E6751);
const _corVerdeChip = Color(0xFFC6EBD2);
const _corVerdeChipTexto = Color(0xFF002112);
const _corVerdeIcone = Color(0xFF4B6C57);
const _corMarrom = Color(0xFF85532E);
const _corMarromTexto = Color(0xFF522907);
const _corLaranja = Color(0xFFCC8F65);
const _corLaranjaClaro = Color(0xFFFFDCC6);
const _corErro = Color(0xFFBA1A1A);
const _corVerdeChip60 = Color(0x99C6EBD2);
const _corBranco90 = Color(0xE6FFFFFF);

const _iconesRestricoes = [Icons.spa, Icons.check, Icons.grain, Icons.bolt];

const _sombraCard = [
  BoxShadow(
    color: Color(0x0A1B2B20),
    blurRadius: 16,
    spreadRadius: -2,
    offset: Offset(0, 4),
  ),
];

TextStyle _estilo(
    double tamanho,
    FontWeight peso,
    Color cor, {
      double? altura,
      double? espaco,
    }) {
  return GoogleFonts.plusJakartaSans(
    fontSize: tamanho,
    fontWeight: peso,
    color: cor,
    height: altura,
    letterSpacing: espaco,
  );
}

class RecipesView extends StatefulWidget {
  final VoidCallback? onIrParaPlanejar;
  final RecipesViewModel? viewModel;
  final void Function(Recipe receita)? onAdicionarNaLista;

  const RecipesView({
    super.key,
    this.onIrParaPlanejar,
    this.viewModel,
    this.onAdicionarNaLista,
  });

  @override
  State<RecipesView> createState() => _RecipesViewState();
}

class _RecipesViewState extends State<RecipesView> {
  final TextEditingController _busca = TextEditingController();
  late final RecipesViewModel _vm;
  late final bool _vmExterno;

  @override
  void initState() {
    super.initState();
    _vmExterno = widget.viewModel != null;
    _vm = widget.viewModel ?? RecipesViewModel();
    _vm.buscarReceitas(reiniciarPagina: true);
  }

  @override
  void dispose() {
    _busca.dispose();
    if (!_vmExterno) _vm.dispose();
    super.dispose();
  }

  void _aoAdicionarIngredientes(Recipe receita) {
    _vm.adicionarIngredientesNaLista(receita);
    widget.onAdicionarNaLista?.call(receita);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Ingredientes de "${receita.title}" adicionados à lista!',
          style: _estilo(13, FontWeight.w600, Colors.white),
        ),
        backgroundColor: _corVerde,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _vm,
      builder: (context, _) {
        final filtradas = _vm.receitasFiltradas;

        return Scaffold(
          backgroundColor: _corFundo,
          appBar: _appBar(),
          body: ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              _titulo(),
              _campoBusca(),
              _linhaCategorias(),
              _linhaRestricoes(),
              if (_vm.avisoRede != null) _bannerAviso(),
              if (_vm.carregando && _vm.receitas.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 48),
                  child: Center(
                    child: CircularProgressIndicator(color: _corVerde),
                  ),
                )
              else if (_vm.receitas.isEmpty)
                _estadoVazioGeral()
              else ...[
                  _cabecalhoLista(filtradas.length),
                  if (filtradas.isEmpty)
                    _estadoVazioFiltros()
                  else
                    _grade(filtradas),
                  if (_vm.temMaisPaginas) _botaoCarregarMais(),
                ],
              _dica(),
            ],
          ),
        );
      },
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      toolbarHeight: 64,
      backgroundColor: _corFundo,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      titleSpacing: 20,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 42,
            errorBuilder: (_, __, ___) => const Icon(
              Icons.eco,
              size: 32,
              color: _corVerde,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'MEAL PREP',
                style: _estilo(11, FontWeight.w700, _corVerde, espaco: 0.44),
              ),
              Text(
                'Receitas',
                style: _estilo(18, FontWeight.w600, _corTexto),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _titulo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Receitas',
                  style: _estilo(22, FontWeight.w700, _corTexto, altura: 1.36),
                ),
                const SizedBox(height: 2),
                Text(
                  _vm.veioDoCache
                      ? 'Offline — cache local (20 em 20)'
                      : 'Encontre inspiração para suas refeições',
                  style: _estilo(
                    12,
                    FontWeight.w400,
                    _corTextoSuave,
                    altura: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: _corVerdeChip,
              shape: BoxShape.circle,
            ),
            child: Icon(
              _vm.veioDoCache ? Icons.wifi_off : Icons.eco,
              size: 20,
              color: _corVerdeChipTexto,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bannerAviso() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: _corVerdeChip60,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            const Icon(Icons.offline_pin, size: 18, color: _corVerdeChipTexto),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _vm.avisoRede!,
                style: _estilo(12, FontWeight.w600, _corVerdeChipTexto),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _campoBusca() {
    final temFiltro = _vm.tempoMax != null || _vm.dificuldade != null;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: _corBranco,
                borderRadius: BorderRadius.circular(999),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: TextField(
                controller: _busca,
                onChanged: _vm.aoAlterarBusca,
                onSubmitted: (_) => _vm.buscarReceitas(reiniciarPagina: true),
                style: _estilo(14, FontWeight.w400, _corTexto),
                decoration: InputDecoration(
                  hintText: 'Buscar receitas...',
                  hintStyle: _estilo(14, FontWeight.w400, _corCinzaIcone),
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 20,
                    color: _corCinzaIcone,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: _abrirFiltros,
            borderRadius: BorderRadius.circular(999),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _corBranco,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.tune, size: 22, color: _corVerde),
                  if (temFiltro)
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: _corLaranja,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _linhaCategorias() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            for (int i = 0; i < categoriasReceita.length; i++) ...[
              GestureDetector(
                onTap: () => _vm.selecionarCategoria(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: i == _vm.categoriaSelecionada ? _corVerde : _corBranco,
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0D000000),
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Text(
                    categoriasReceita[i],
                    style: _estilo(
                      12,
                      FontWeight.w600,
                      i == _vm.categoriaSelecionada
                          ? Colors.white
                          : _corTextoSuave,
                      espaco: 0.24,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
            ],
          ],
        ),
      ),
    );
  }

  Widget _linhaRestricoes() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            for (int i = 0; i < restricoesReceita.length; i++) ...[
              _chipRestricao(i),
              const SizedBox(width: 6),
            ],
          ],
        ),
      ),
    );
  }

  Widget _chipRestricao(int i) {
    final nome = restricoesReceita[i];
    final ativo = _vm.restricoesAtivas.contains(nome);

    return GestureDetector(
      onTap: () => _vm.alternarRestricao(nome),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: ativo ? _corVerdeChip : _corBranco,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _iconesRestricoes[i],
              size: 15,
              color: ativo ? _corVerdeChipTexto : _corTextoSuave,
            ),
            const SizedBox(width: 6),
            Text(
              nome,
              style: _estilo(
                11,
                FontWeight.w700,
                ativo ? _corVerdeChipTexto : _corTextoSuave,
                espaco: 0.44,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cabecalhoLista(int quantidadeFiltrada) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Row(
        children: [
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    'Sugestões da semana',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _estilo(18, FontWeight.w700, _corTexto),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _corCinzaClaro,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '${_vm.receitas.length} · $quantidadeFiltrada',
                    maxLines: 1,
                    softWrap: false,
                    style: _estilo(11, FontWeight.w700, _corTextoSuave),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          PopupMenuButton<String>(
            onSelected: _vm.alterarOrdem,
            color: _corBranco,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            itemBuilder: (_) => [
              for (final op in opcoesOrdemReceita)
                PopupMenuItem(
                  value: op,
                  child: Text(
                    op,
                    style: _estilo(
                      14,
                      op == _vm.ordem ? FontWeight.w700 : FontWeight.w400,
                      op == _vm.ordem ? _corVerde : _corTexto,
                    ),
                  ),
                ),
            ],
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _vm.ordem,
                  maxLines: 1,
                  softWrap: false,
                  style: _estilo(12, FontWeight.w600, _corVerde),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.swap_vert, size: 18, color: _corVerde),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _grade(List<Recipe> lista) {
    final linhas = <Widget>[];
    for (int i = 0; i < lista.length; i += 2) {
      final segundo =
      i + 1 < lista.length ? _cardReceita(lista[i + 1]) : const SizedBox();
      linhas.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _cardReceita(lista[i])),
              const SizedBox(width: 14),
              Expanded(child: segundo),
            ],
          ),
        ),
      );
      linhas.add(const SizedBox(height: 14));
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: linhas),
    );
  }

  Widget _cardReceita(Recipe r) {
    final favorita = _vm.favoritas.contains(r.id);
    final refeicoes = _vm.refeicoesDaReceita(r);

    Color corDificuldade = _corVerde;
    if (r.difficulty == 'Médio') corDificuldade = _corMarrom;
    if (r.difficulty == 'Difícil') corDificuldade = _corErro;

    return GestureDetector(
      onTap: () => _abrirDetalhesReceita(r),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          decoration: const BoxDecoration(
            color: _corBranco,
            boxShadow: _sombraCard,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      color: _corCinzaFoto,
                      child: r.photoUrl.isNotEmpty
                          ? Image.network(
                        r.photoUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.restaurant,
                          color: _corCinzaIcone,
                          size: 32,
                        ),
                      )
                          : const Icon(
                        Icons.restaurant,
                        color: _corCinzaIcone,
                        size: 32,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () => _vm.alternarFavorita(r.id),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: _corBranco90,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            favorita ? Icons.favorite : Icons.favorite_border,
                            size: 18,
                            color: favorita ? _corLaranja : _corTextoSuave,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _corBranco90,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          r.difficulty,
                          style: _estilo(11, FontWeight.w700, corDificuldade),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            refeicoes.join(' / '),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: _estilo(11, FontWeight.w700, _corVerde),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            r.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: _estilo(
                              14,
                              FontWeight.w600,
                              _corTexto,
                              altura: 1.4,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.schedule,
                                size: 14,
                                color: _corTextoSuave,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${r.prepTimeMinutes} min',
                                style: _estilo(
                                  11,
                                  FontWeight.w700,
                                  _corTextoSuave,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _corVerdeChip60,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '${r.calories.round()} kcal',
                              style: _estilo(
                                10,
                                FontWeight.w700,
                                _corVerdeChipTexto,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _botaoCarregarMais() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: _vm.carregando ? null : _vm.carregarMais20,
          style: OutlinedButton.styleFrom(
            foregroundColor: _corVerde,
            side: const BorderSide(color: _corVerde, width: 1.5),
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          child: Text(
            _vm.carregando ? 'Carregando...' : 'Carregar mais 20',
            style: _estilo(13, FontWeight.w700, _corVerde),
          ),
        ),
      ),
    );
  }

  Widget _estadoVazioGeral() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 28),
        decoration: BoxDecoration(
          color: _corBranco,
          borderRadius: BorderRadius.circular(32),
          boxShadow: _sombraCard,
        ),
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: _corVerdeChip60,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.menu_book,
                size: 30,
                color: _corVerdeIcone,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Nenhuma receita por aqui',
              textAlign: TextAlign.center,
              style: _estilo(18, FontWeight.w600, _corTexto),
            ),
            const SizedBox(height: 4),
            Text(
              'Busque receitas ou conecte a internet para carregar do catálogo.',
              textAlign: TextAlign.center,
              style: _estilo(14, FontWeight.w400, _corTextoSuave, altura: 1.4),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () => _vm.buscarReceitas(reiniciarPagina: true),
              borderRadius: BorderRadius.circular(999),
              child: Container(
                height: 48,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _corVerde,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'Buscar receitas',
                  style: _estilo(14, FontWeight.w600, Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _estadoVazioFiltros() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
        decoration: BoxDecoration(
          color: _corBranco,
          borderRadius: BorderRadius.circular(32),
          boxShadow: _sombraCard,
        ),
        child: Column(
          children: [
            const Icon(Icons.search_off, size: 36, color: _corCinzaIcone),
            const SizedBox(height: 12),
            Text(
              'Nenhuma receita encontrada',
              textAlign: TextAlign.center,
              style: _estilo(18, FontWeight.w600, _corTexto),
            ),
            const SizedBox(height: 4),
            Text(
              'Tente mudar a busca ou remover alguns filtros.',
              textAlign: TextAlign.center,
              style: _estilo(14, FontWeight.w400, _corTextoSuave, altura: 1.4),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                _busca.clear();
                _vm.limparFiltros();
              },
              borderRadius: BorderRadius.circular(999),
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _corVerde,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'Limpar filtros',
                  style: _estilo(14, FontWeight.w600, Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dica() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _corCardClaro,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: _corLaranjaClaro,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.lightbulb_outline,
                size: 20,
                color: _corMarromTexto,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dica de preparo eficiente',
                    style: _estilo(14, FontWeight.w700, _corTexto),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Cozinhe os legumes e o frango juntos na mesma assadeira com azeite e ervas para economizar até 25 minutos de limpeza!',
                    style: _estilo(
                      12,
                      FontWeight.w400,
                      _corTextoSuave,
                      altura: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _opcaoFiltro(String rotulo, bool selecionado, VoidCallback aoTocar) {
    return GestureDetector(
      onTap: aoTocar,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selecionado ? _corVerde : _corBranco,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: selecionado ? _corVerde : _corCinzaClaro),
        ),
        child: Text(
          rotulo,
          style: _estilo(
            12,
            FontWeight.w600,
            selecionado ? Colors.white : _corTextoSuave,
          ),
        ),
      ),
    );
  }

  void _abrirDetalhesReceita(Recipe r) {
    final refeicoes = _vm.refeicoesDaReceita(r);
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: _corFundo,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.85,
        builder: (_, controller) => ListView(
          controller: controller,
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: AspectRatio(
                aspectRatio: 16 / 10,
                child: r.photoUrl.isNotEmpty
                    ? Image.network(r.photoUrl, fit: BoxFit.cover)
                    : Container(
                  color: _corCinzaFoto,
                  child: const Icon(Icons.restaurant, size: 42),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              refeicoes.join(' / '),
              style: _estilo(12, FontWeight.w700, _corVerde),
            ),
            const SizedBox(height: 4),
            Text(
              r.title,
              style: _estilo(22, FontWeight.w700, _corTexto),
            ),
            const SizedBox(height: 12),
            Text(
              '${r.prepTimeMinutes} min · ${r.servings} porções · ${r.calories.round()} kcal',
              style: _estilo(13, FontWeight.w600, _corTextoSuave),
            ),
            const SizedBox(height: 16),
            Text(
              'Ingredientes',
              style: _estilo(16, FontWeight.w700, _corTexto),
            ),
            const SizedBox(height: 8),
            for (final ing in r.ingredients)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  '• ${ing.nome} (${ing.quantidade} ${ing.unidade})',
                  style: _estilo(13, FontWeight.w500, _corTexto),
                ),
              ),
            if (r.ingredients.isNotEmpty) ...[
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () => _aoAdicionarIngredientes(r),
                  icon: const Icon(Icons.add_shopping_cart, size: 18),
                  label: Text(
                    'Adicionar na lista',
                    style: _estilo(14, FontWeight.w600, Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _corVerde,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            Text(
              'Modo de preparo',
              style: _estilo(16, FontWeight.w700, _corTexto),
            ),
            const SizedBox(height: 8),
            Text(
              r.instructions.isNotEmpty
                  ? r.instructions
                  : 'Sem instruções.',
              style: _estilo(
                13,
                FontWeight.w400,
                _corTextoSuave,
                altura: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _abrirFiltros() {
    int? tempoTemp = _vm.tempoMax;
    String? difTemp = _vm.dificuldade;

    showModalBottomSheet(
      context: context,
      backgroundColor: _corFundo,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (sheetContext) => StatefulBuilder(
        builder: (sheetContext, setModalState) => Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filtros avançados',
                style: _estilo(18, FontWeight.w700, _corTexto),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final op in opcoesTempoReceita)
                    _opcaoFiltro(
                      op == null ? 'Qualquer tempo' : 'Até $op min',
                      tempoTemp == op,
                          () => setModalState(() => tempoTemp = op),
                    ),
                ],
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final op in opcoesDificuldadeReceita)
                    _opcaoFiltro(
                      op ?? 'Qualquer dif.',
                      difTemp == op,
                          () => setModalState(() => difTemp = op),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    _vm.aplicarFiltrosAvancados(
                      novoTempoMax: tempoTemp,
                      novaDificuldade: difTemp,
                    );
                    Navigator.pop(sheetContext);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _corVerde,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Aplicar filtros'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}