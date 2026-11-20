import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meal_prep_app/recipes/models/Receita.dart';
import 'package:meal_prep_app/shopping_list/models/ListaCompras.dart';
import 'package:meal_prep_app/shopping_list/viewmodels/listas_compras.dart';

// Cores
const _corFundo = Color(0xFFFBF9F4);
const _corBranco = Color(0xFFFFFFFF);
const _corCardClaro = Color(0xFFF5F3EE);
const _corCinzaMedio = Color(0xFFF0EEE9);
const _corCinzaClaro = Color(0xFFEAE8E3);
const _corCinzaIcone = Color(0xFF717973);
const _corBordaSuave = Color(0xFFC1C8C1);
const _corTexto = Color(0xFF1B1C19);
const _corTextoSuave = Color(0xFF414943);

const _corVerde = Color(0xFF3E6751);
const _corVerdeBarra = Color(0xFF7BA68D);
const _corVerdeChip = Color(0xFFC6EBD2);
const _corVerdeChipTexto = Color(0xFF002112);
const _corVerdeIcone = Color(0xFF4B6C57);

const _corMarrom = Color(0xFF85532E);
const _corMarromEscuro = Color(0xFF693C19);
const _corLaranja = Color(0xFFCC8F65);
const _corLaranjaClaro = Color(0xFFFFDCC6);

// Cores com transparência
const _corVerdeChip60 = Color(0x99C6EBD2);

TextStyle _estilo(
    double tamanho,
    FontWeight peso,
    Color cor, {
      double? altura,
      double? espaco,
      TextDecoration? decoracao,
    }) {
  return GoogleFonts.plusJakartaSans(
    fontSize: tamanho,
    fontWeight: peso,
    color: cor,
    height: altura,
    letterSpacing: espaco,
    decoration: decoracao,
  );
}

const _sombraCard = [
  BoxShadow(
    color: Color(0x0A1B2B20),
    blurRadius: 16,
    spreadRadius: -2,
    offset: Offset(0, 4),
  ),
];

class _Setor {
  final String nome;
  final String curto;
  final String descricao;
  final IconData icone;
  final Color fundo;
  final Color corIcone;

  const _Setor({
    required this.nome,
    required this.curto,
    required this.descricao,
    required this.icone,
    required this.fundo,
    required this.corIcone,
  });
}

const _setores = [
  _Setor(
    nome: 'Hortifruti',
    curto: 'Hortifruti',
    descricao: 'Frutas, legumes e ervas frescas',
    icone: Icons.eco,
    fundo: _corVerdeChip,
    corIcone: _corVerdeIcone,
  ),
  _Setor(
    nome: 'Açougue & Peixaria',
    curto: 'Açougue',
    descricao: 'Proteínas limpas e frescas',
    icone: Icons.set_meal,
    fundo: Color(0x4DCC8F65),
    corIcone: _corMarrom,
  ),
  _Setor(
    nome: 'Laticínios & Refrigerados',
    curto: 'Laticínios',
    descricao: 'Bases probióticas e queijos leves',
    icone: Icons.egg_alt,
    fundo: _corVerdeChip,
    corIcone: _corVerdeIcone,
  ),
  _Setor(
    nome: 'Mercearia & Grãos',
    curto: 'Mercearia',
    descricao: 'Fibras e temperos da despensa',
    icone: Icons.grain,
    fundo: Color(0x337BA68D),
    corIcone: _corVerde,
  ),
  _Setor(
    nome: 'Padaria & Congelados',
    curto: 'Padaria',
    descricao: 'Pães de longa fermentação',
    icone: Icons.bakery_dining,
    fundo: _corLaranjaClaro,
    corIcone: _corMarromEscuro,
  ),
  _Setor(
    nome: 'Limpeza & Utilidades',
    curto: 'Limpeza',
    descricao: 'Potes herméticos e conservação',
    icone: Icons.cleaning_services,
    fundo: _corCinzaClaro,
    corIcone: _corTexto,
  ),
];

int _indiceSetor(String setorMercado) {
  final s = setorMercado.trim().toLowerCase();
  if (s.contains('horti') || s.contains('fruta') || s.contains('legume')) {
    return 0;
  }
  if (s.contains('açougue') || s.contains('acougue') || s.contains('carne') || s.contains('peixe') || s.contains('frango')) {
    return 1;
  }
  if (s.contains('latic') || s.contains('leite') || s.contains('queijo') || s.contains('ovo')) {
    return 2;
  }
  if (s.contains('padaria') || s.contains('pão') || s.contains('pao') || s.contains('congel')) {
    return 4;
  }
  if (s.contains('limpeza') || s.contains('utilid')) {
    return 5;
  }
  return 3;
}

String _formatarQuantidade(double valor, String unidade) {
  final textoNumero = valor % 1 == 0
      ? valor.toInt().toString()
      : valor.toStringAsFixed(1).replaceAll('.', ',');
  final un = unidade.trim();
  return un.isEmpty ? textoNumero : '$textoNumero $un';
}

class ShoppingListView extends StatefulWidget {
  final ListasCompras? viewModel;
  final List<Recipe> receitasPlanejadas;
  final int indiceNavegacao;
  final ValueChanged<int>? onSelecionarNavegacao;

  const ShoppingListView({
    super.key,
    this.viewModel,
    this.receitasPlanejadas = const [],
    this.indiceNavegacao = 2,
    this.onSelecionarNavegacao,
  });

  @override
  State<ShoppingListView> createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {
  late final ListasCompras _vm;
  late final bool _vmExterno;
  int _filtro = 0; // 0 = todos, 1 = pendentes, 2 = comprados

  @override
  void initState() {
    super.initState();
    _vmExterno = widget.viewModel != null;
    _vm = widget.viewModel ?? ListasCompras();
  }

  @override
  void dispose() {
    if (!_vmExterno) _vm.dispose();
    super.dispose();
  }

  void _gerarDaSemana() {
    if (widget.receitasPlanejadas.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nenhuma receita alocada no planejamento.'),
        ),
      );
      return;
    }
    _vm.gerarListaDaSemana(widget.receitasPlanejadas);
  }

  Widget _campo(
      String rotulo,
      ValueChanged<String> onChanged, {
        bool autofocus = false,
        TextInputType? keyboardType,
      }) {
    return TextField(
      autofocus: autofocus,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: rotulo,
        filled: true,
        fillColor: _corBranco,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: _corBordaSuave),
        ),
      ),
    );
  }

  Future<void> _abrirAdicionar() async {
    String nome = '';
    String qtdTexto = '';
    String unidade = '';
    int setorSelecionado = 3;

    final salvou = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: _corFundo,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                20,
                20,
                MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Novo item',
                    style: _estilo(18, FontWeight.w700, _corTexto),
                  ),
                  const SizedBox(height: 14),
                  _campo(
                    'Nome do item',
                        (v) => nome = v,
                    autofocus: true,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: _campo(
                          'Quantidade',
                              (v) => qtdTexto = v,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _campo(
                          'Unidade (ex.: kg, un)',
                              (v) => unidade = v,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<int>(
                    value: setorSelecionado,
                    decoration: InputDecoration(
                      labelText: 'Setor',
                      filled: true,
                      fillColor: _corBranco,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: _corBordaSuave),
                      ),
                    ),
                    items: [
                      for (int i = 0; i < _setores.length; i++)
                        DropdownMenuItem(
                          value: i,
                          child: Text(_setores[i].nome),
                        ),
                    ],
                    onChanged: (v) {
                      if (v != null) setModalState(() => setorSelecionado = v);
                    },
                  ),
                  const SizedBox(height: 18),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: _corVerde,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    onPressed: () {
                      if (nome.trim().isEmpty) return;
                      Navigator.pop(context, true);
                    },
                    child: const Text('Adicionar à lista'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    if (salvou == true && nome.trim().isNotEmpty) {
      final qtdLimpa = qtdTexto.trim().replaceAll(',', '.');
      final qtd = double.tryParse(qtdLimpa) ?? 1.0;
      _vm.adicionarItemAvulso(
        nome: nome.trim(),
        quantidade: qtd,
        unidade: unidade.trim(),
        setorMercado: _setores[setorSelecionado].curto,
      );
    }
  }

  Widget _botaoAdicionar() {
    return FloatingActionButton.extended(
      onPressed: _abrirAdicionar,
      backgroundColor: _corVerde,
      foregroundColor: Colors.white,
      icon: const Icon(Icons.add),
      label: Text(
        'Adicionar item',
        style: _estilo(14, FontWeight.w600, Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _vm,
      builder: (context, _) {
        final itens = _vm.itens;
        final total = _vm.totalItens;
        final comprados = _vm.totalComprados;
        final pendentes = _vm.totalPendentes;
        final progresso = total == 0 ? 0.0 : comprados / total;

        return Scaffold(
          backgroundColor: _corFundo,
          appBar: _appBar(),
          floatingActionButton: _botaoAdicionar(),
          body: ListView(
            padding: const EdgeInsets.only(bottom: 100),
            children: [
              _cabecalho(),
              const SizedBox(height: 4),
              _cardProgresso(
                progresso: progresso,
                total: total,
                comprados: comprados,
                pendentes: pendentes,
              ),
              _bannerPlanejamento(),
              if (itens.isEmpty)
                _estadoVazio()
              else
                ..._secoes(itens),
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
                'Compras',
                style: _estilo(18, FontWeight.w600, _corTexto),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cabecalho() {
    final filtroAtivo = _filtro != 0;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.spa, size: 18, color: _corVerde),
                    const SizedBox(width: 4),
                    Text(
                      'DESPENSA VIVA',
                      style: _estilo(11, FontWeight.w700, _corVerde, espaco: 0.44),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Lista de compras',
                  style: _estilo(22, FontWeight.w700, _corTexto, altura: 1.36),
                ),
                Text(
                  'Tudo organizado para suas compras da semana',
                  style: _estilo(12, FontWeight.w400, _corTextoSuave, altura: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                PopupMenuButton<int>(
                  onSelected: (valor) => setState(() => _filtro = valor),
                  color: _corBranco,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  itemBuilder: (_) => [
                    _opcaoMenu(0, 'Todos os itens', _filtro == 0),
                    _opcaoMenu(1, 'Só pendentes', _filtro == 1),
                    _opcaoMenu(2, 'Só comprados', _filtro == 2),
                  ],
                  child: _botaoRedondo(Icons.tune, ativo: filtroAtivo),
                ),
                const SizedBox(width: 4),
                PopupMenuButton<String>(
                  onSelected: _acaoMenuMais,
                  color: _corBranco,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      value: 'desmarcar',
                      child: Text(
                        'Desmarcar todos',
                        style: _estilo(14, FontWeight.w400, _corTexto),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'limparComprados',
                      child: Text(
                        'Remover comprados',
                        style: _estilo(14, FontWeight.w400, _corTexto),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'limparTudo',
                      child: Text(
                        'Limpar lista',
                        style: _estilo(14, FontWeight.w400, _corTexto),
                      ),
                    ),
                  ],
                  child: _botaoRedondo(Icons.more_vert),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _botaoRedondo(IconData icone, {bool ativo = false}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: ativo ? _corVerdeChip : _corCinzaMedio,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icone,
        size: 20,
        color: ativo ? _corVerde : _corTextoSuave,
      ),
    );
  }

  PopupMenuItem<int> _opcaoMenu(int valor, String texto, bool selecionado) {
    return PopupMenuItem(
      value: valor,
      child: Text(
        texto,
        style: _estilo(
          14,
          selecionado ? FontWeight.w700 : FontWeight.w400,
          selecionado ? _corVerde : _corTexto,
        ),
      ),
    );
  }

  void _acaoMenuMais(String acao) {
    if (acao == 'desmarcar') {
      _vm.desmarcarTodos();
    } else if (acao == 'limparComprados') {
      _vm.removerComprados();
    } else if (acao == 'limparTudo') {
      _vm.limparLista();
      setState(() => _filtro = 0);
    }
  }

  Widget _cardProgresso({
    required double progresso,
    required int total,
    required int comprados,
    required int pendentes,
  }) {
    final porcentagem = (progresso * 100).round();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _corBranco,
          borderRadius: BorderRadius.circular(32),
          boxShadow: _sombraCard,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'STATUS GERAL',
                        style: _estilo(
                          11,
                          FontWeight.w700,
                          _corTextoSuave,
                          espaco: 0.44,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '$comprados de $total ',
                              style: _estilo(22, FontWeight.w700, _corTexto),
                            ),
                            TextSpan(
                              text: 'itens reunidos',
                              style: _estilo(12, FontWeight.w400, _corTextoSuave),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _corVerdeChip,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        size: 16,
                        color: _corVerdeChipTexto,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '$porcentagem% concluído',
                        style: _estilo(11, FontWeight.w700, _corVerdeChipTexto),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: progresso,
                minHeight: 10,
                backgroundColor: _corCinzaMedio,
                color: _corVerdeBarra,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _bolinha(_corLaranja),
                    const SizedBox(width: 4),
                    Text(
                      '$pendentes pendentes',
                      style: _estilo(11, FontWeight.w700, _corTextoSuave),
                    ),
                  ],
                ),
                Row(
                  children: [
                    _bolinha(_corVerde),
                    const SizedBox(width: 4),
                    Text(
                      '$comprados comprados',
                      style: _estilo(11, FontWeight.w700, _corVerde),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: _gerarDaSemana,
              borderRadius: BorderRadius.circular(999),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: _corCardClaro,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.auto_fix_high, size: 18, color: _corMarrom),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Gerar lista a partir do planejamento',
                        overflow: TextOverflow.ellipsis,
                        style: _estilo(11, FontWeight.w700, _corTexto),
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: _corTextoSuave,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bolinha(Color cor) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: cor, shape: BoxShape.circle),
    );
  }

  Widget _bannerPlanejamento() {
    final count = widget.receitasPlanejadas.length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _corCardClaro,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: _corVerdeChip60,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.sync, size: 18, color: _corVerde),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Planejamento da Semana',
                    style: _estilo(12, FontWeight.w600, _corTexto),
                  ),
                  Text(
                    count == 0
                        ? 'Nenhuma receita planejada'
                        : '$count receitas ativas calculadas',
                    style: _estilo(12, FontWeight.w400, _corTextoSuave),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: _gerarDaSemana,
              borderRadius: BorderRadius.circular(999),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _corBranco,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'Atualizar',
                  style: _estilo(11, FontWeight.w700, _corVerde),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _estadoVazio() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
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
                Icons.shopping_basket,
                size: 30,
                color: _corVerdeIcone,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Sua lista está vazia',
              textAlign: TextAlign.center,
              style: _estilo(18, FontWeight.w600, _corTexto),
            ),
            const SizedBox(height: 4),
            Text(
              'Adicione itens avulsos ou gere a lista a partir das receitas que você planejar para a semana.',
              textAlign: TextAlign.center,
              style: _estilo(14, FontWeight.w400, _corTextoSuave, altura: 1.4),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: _abrirAdicionar,
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
                  'Adicionar item',
                  style: _estilo(14, FontWeight.w600, Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: _gerarDaSemana,
              borderRadius: BorderRadius.circular(999),
              child: Container(
                height: 48,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: _corVerde, width: 1.5),
                ),
                child: Text(
                  'Gerar do planejamento',
                  style: _estilo(14, FontWeight.w600, _corVerde),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _secoes(List<ListaCompras> itens) {
    final widgets = <Widget>[];

    for (int s = 0; s < _setores.length; s++) {
      final doSetor =
      itens.where((i) => _indiceSetor(i.setorMercado) == s).toList();
      if (doSetor.isEmpty) continue;

      final visiveis = doSetor.where((i) {
        if (_filtro == 1) return !i.comprado;
        if (_filtro == 2) return i.comprado;
        return true;
      }).toList();
      if (visiveis.isEmpty) continue;

      widgets.add(_cardSetor(s, doSetor, visiveis));
    }

    if (widgets.isEmpty) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: Text(
            _filtro == 1
                ? 'Nenhum item pendente. Tudo comprado!'
                : 'Nenhum item comprado ainda.',
            textAlign: TextAlign.center,
            style: _estilo(14, FontWeight.w400, _corTextoSuave),
          ),
        ),
      );
    }
    return widgets;
  }

  Widget _cardSetor(
      int indice,
      List<ListaCompras> todos,
      List<ListaCompras> visiveis,
      ) {
    final setor = _setores[indice];
    final pendentes = todos.where((i) => !i.comprado).length;
    final tudoComprado = pendentes == 0;

    final resumo = tudoComprado
        ? 'Tudo comprado ✓'
        : '${todos.length} ${todos.length == 1 ? 'item' : 'itens'} • '
        '$pendentes ${pendentes == 1 ? 'pendente' : 'pendentes'}';

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _corBranco,
          borderRadius: BorderRadius.circular(32),
          boxShadow: _sombraCard,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: setor.fundo,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(setor.icone, size: 18, color: setor.corIcone),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          setor.nome,
                          overflow: TextOverflow.ellipsis,
                          style: _estilo(18, FontWeight.w600, _corTexto),
                        ),
                        Text(
                          setor.descricao,
                          overflow: TextOverflow.ellipsis,
                          style: _estilo(12, FontWeight.w400, _corTextoSuave),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(top: 6, bottom: 4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: tudoComprado ? _corVerdeChip : _corCinzaMedio,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  resumo,
                  style: _estilo(
                    11,
                    FontWeight.w700,
                    tudoComprado ? _corVerdeChipTexto : _corTextoSuave,
                  ),
                ),
              ),
            ),
            for (final item in visiveis) _linhaItem(item),
          ],
        ),
      ),
    );
  }

  Widget _linhaItem(ListaCompras item) {
    final comprado = item.comprado;
    final qtdTexto = _formatarQuantidade(item.quantidade, item.unidade);

    return InkWell(
      onTap: () => _vm.alternarStatusComprado(item.id),
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: comprado ? _corVerde : _corCinzaClaro,
                shape: BoxShape.circle,
              ),
              child: comprado
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.nome,
                    overflow: TextOverflow.ellipsis,
                    style: _estilo(
                      14,
                      FontWeight.w400,
                      comprado ? _corCinzaIcone : _corTexto,
                      decoracao:
                      comprado ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  if (qtdTexto.isNotEmpty)
                    Text(
                      qtdTexto,
                      overflow: TextOverflow.ellipsis,
                      style: _estilo(11, FontWeight.w600, _corTextoSuave),
                    ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => _vm.removerItem(item.id),
              icon: const Icon(
                Icons.close,
                size: 18,
                color: _corCinzaIcone,
              ),
              tooltip: 'Remover',
            ),
          ],
        ),
      ),
    );
  }
}