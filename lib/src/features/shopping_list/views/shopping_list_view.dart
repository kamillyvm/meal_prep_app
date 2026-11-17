import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//cores
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

//cores com transparência
const _corVerdeChip60 = Color(0x99C6EBD2);
const _corBrilho = Color(0x333E6751);

//estilo de texto simples
TextStyle _estilo(double tamanho, FontWeight peso, Color cor,
    {double? altura, double? espaco, TextDecoration? decoracao}) {
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

//dados
//primeiro acesso: a lista começa vazia
//depois, os itens virão do ViewModel (e do planejamento da semana)

//troque para true só para testar como o layout fica com itens.
bool _usarDadosDeExemplo = false;

//receitas ativas no planejamento da semana (virá do planner)
int _receitasPlanejadas = 0;

//setores (corredores) do mercado
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

class _Item {
  String nome;
  String quantidade;
  int setor; //índice em _setores
  bool comprado;
  String? origem; //ex.: "Meal Prep Almoço"

  _Item({
    required this.nome,
    required this.quantidade,
    required this.setor,
    this.comprado = false,
    this.origem,
  });
}

//só para testar o layout
List<_Item> _itensExemplo() {
  return [
    _Item(nome: 'Abobrinha média', quantidade: '2 unid', setor: 0),
    _Item(nome: 'Brócolis frescos', quantidade: '2 maços', setor: 0),
    _Item(
        nome: 'Tomates-cereja',
        quantidade: '2 cx / 500g',
        setor: 0,
        comprado: true),
    _Item(nome: 'Limão siciliano', quantidade: '4 unid', setor: 0, comprado: true),
    _Item(
        nome: 'Filé de peito de frango',
        quantidade: '1.2 kg',
        setor: 1,
        origem: 'Meal Prep Almoço'),
    _Item(
        nome: 'Salmão fresco em postas',
        quantidade: '600g',
        setor: 1,
        comprado: true),
    _Item(nome: 'Iogurte natural desnatado', quantidade: '2 potes 500g', setor: 2),
    _Item(nome: 'Queijo minas frescal', quantidade: '400g', setor: 2, comprado: true),
    _Item(nome: 'Aveia em flocos grossos', quantidade: '500g', setor: 3),
    _Item(nome: 'Sementes de Chia', quantidade: '200g', setor: 3),
    _Item(
        nome: 'Azeite de oliva extravirgem',
        quantidade: '500ml',
        setor: 3,
        comprado: true),
    _Item(nome: 'Pão fermentação natural', quantidade: '1 unid', setor: 4),
    _Item(nome: 'Mirtilos congelados', quantidade: '400g', setor: 4, comprado: true),
    _Item(
        nome: 'Potes de vidro 500ml',
        quantidade: 'kit 4 un',
        setor: 5,
        comprado: true),
  ];
}

//tela
class ShoppingListView extends StatefulWidget {
  const ShoppingListView({super.key});

  @override
  State<ShoppingListView> createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {
  late final List<_Item> _itens =
      _usarDadosDeExemplo ? _itensExemplo() : <_Item>[];

  int _filtro = 0; //0 = todos, 1 = pendentes, 2 = comprados

  int get _total => _itens.length;
  int get _comprados => _itens.where((i) => i.comprado).length;
  int get _pendentes => _total - _comprados;

  @override
  Widget build(BuildContext context) {
    final progresso = _total == 0 ? 0.0 : _comprados / _total;

    return Scaffold(
      backgroundColor: _corFundo,
      appBar: _appBar(),
      bottomNavigationBar: _menuInferior(),
      floatingActionButton: _botaoAdicionar(),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 100),
        children: [
          _cabecalho(),
          const SizedBox(height: 4),
          _cardProgresso(progresso),
          _bannerPlanejamento(),
          if (_itens.isEmpty)
            _estadoVazio()
          else
            ..._secoes(),
        ],
      ),
    );
  }

  //topo
  PreferredSizeWidget _appBar() {
    return AppBar(
      toolbarHeight: 64,
      backgroundColor: _corFundo,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      titleSpacing: 20,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('MEAL PREP',
              style: _estilo(11, FontWeight.w700, _corVerde, espaco: 0.44)),
          Text('Compras', style: _estilo(18, FontWeight.w600, _corTexto)),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_outlined,
              size: 22, color: _corTextoSuave),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 20),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _corVerdeChip60,
              shape: BoxShape.circle,
              border: Border.all(color: _corBrilho, width: 2),
            ),
            child: const Icon(Icons.person_outline,
                size: 20, color: _corVerdeIcone),
          ),
        ),
      ],
    );
  }

  //título + botões de filtro e mais opções
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
                    Text('DESPENSA VIVA',
                        style: _estilo(11, FontWeight.w700, _corVerde,
                            espaco: 0.44)),
                  ],
                ),
                const SizedBox(height: 4),
                Text('Lista de compras',
                    style: _estilo(22, FontWeight.w700, _corTexto, altura: 1.36)),
                Text('Tudo organizado para suas compras da semana',
                    style: _estilo(12, FontWeight.w400, _corTextoSuave,
                        altura: 1.5)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                // filtro: todos / pendentes / comprados
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
                // mais opções
                PopupMenuButton<String>(
                  onSelected: _acaoMenuMais,
                  color: _corBranco,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      value: 'desmarcar',
                      child: Text('Desmarcar todos',
                          style: _estilo(14, FontWeight.w400, _corTexto)),
                    ),
                    PopupMenuItem(
                      value: 'limparComprados',
                      child: Text('Remover comprados',
                          style: _estilo(14, FontWeight.w400, _corTexto)),
                    ),
                    PopupMenuItem(
                      value: 'limparTudo',
                      child: Text('Limpar lista',
                          style: _estilo(14, FontWeight.w400, _corTexto)),
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
      child: Icon(icone,
          size: 20, color: ativo ? _corVerde : _corTextoSuave),
    );
  }

  PopupMenuItem<int> _opcaoMenu(int valor, String texto, bool selecionado) {
    return PopupMenuItem(
      value: valor,
      child: Text(
        texto,
        style: _estilo(14, selecionado ? FontWeight.w700 : FontWeight.w400,
            selecionado ? _corVerde : _corTexto),
      ),
    );
  }

  void _acaoMenuMais(String acao) {
    setState(() {
      if (acao == 'desmarcar') {
        for (final item in _itens) {
          item.comprado = false;
        }
      } else if (acao == 'limparComprados') {
        _itens.removeWhere((i) => i.comprado);
      } else if (acao == 'limparTudo') {
        _itens.clear();
        _filtro = 0;
      }
    });
  }

  //card de progresso
  Widget _cardProgresso(double progresso) {
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
                      Text('STATUS GERAL',
                          style: _estilo(11, FontWeight.w700, _corTextoSuave,
                              espaco: 0.44)),
                      const SizedBox(height: 2),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '$_comprados de $_total ',
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: _corVerdeChip,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle,
                          size: 16, color: _corVerdeChipTexto),
                      const SizedBox(width: 6),
                      Text('$porcentagem% concluído',
                          style: _estilo(11, FontWeight.w700, _corVerdeChipTexto)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // barra de progresso
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
                    Text('$_pendentes pendentes',
                        style: _estilo(11, FontWeight.w700, _corTextoSuave)),
                  ],
                ),
                Row(
                  children: [
                    _bolinha(_corVerde),
                    const SizedBox(width: 4),
                    Text('$_comprados comprados',
                        style: _estilo(11, FontWeight.w700, _corVerde)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            //atalho para gerar a lista a partir do planejamento
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(999),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                    const Icon(Icons.chevron_right,
                        size: 18, color: _corTextoSuave),
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

  //banner do planejamento
  Widget _bannerPlanejamento() {
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
                  Text('Planejamento da Semana',
                      style: _estilo(12, FontWeight.w600, _corTexto)),
                  Text(
                    _receitasPlanejadas == 0
                        ? 'Nenhuma receita planejada'
                        : '$_receitasPlanejadas receitas ativas calculadas',
                    style: _estilo(12, FontWeight.w400, _corTextoSuave),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(999),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _corBranco,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text('Atualizar',
                    style: _estilo(11, FontWeight.w700, _corVerde)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //estado vazio
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
              child: const Icon(Icons.shopping_basket,
                  size: 30, color: _corVerdeIcone),
            ),
            const SizedBox(height: 16),
            Text('Sua lista está vazia',
                textAlign: TextAlign.center,
                style: _estilo(18, FontWeight.w600, _corTexto)),
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
                child: Text('Adicionar item',
                    style: _estilo(14, FontWeight.w600, Colors.white)),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(999),
              child: Container(
                height: 48,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: _corVerde, width: 1.5),
                ),
                child: Text('Gerar do planejamento',
                    style: _estilo(14, FontWeight.w600, _corVerde)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //seções por setor do mercado
  List<Widget> _secoes() {
    final widgets = <Widget>[];

    for (int s = 0; s < _setores.length; s++) {
      final doSetor = _itens.where((i) => i.setor == s).toList();
      if (doSetor.isEmpty) continue;

      //aplica o filtro (todos / pendentes / comprados)
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
                ? 'Nenhum item pendente. Tudo comprado! 🎉'
                : 'Nenhum item comprado ainda.',
            textAlign: TextAlign.center,
            style: _estilo(14, FontWeight.w400, _corTextoSuave),
          ),
        ),
      );
    }
    return widgets;
  }

  Widget _cardSetor(int indice, List<_Item> todos, List<_Item> visiveis) {
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
            //cabeçalho do setor
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
                        Text(setor.nome,
                            overflow: TextOverflow.ellipsis,
                            style: _estilo(18, FontWeight.w600, _corTexto)),
                        Text(setor.descricao,
                            overflow: TextOverflow.ellipsis,
                            style: _estilo(12, FontWeight.w400, _corTextoSuave)),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: tudoComprado ? _corVerdeChip : _corCinzaMedio,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  resumo,
                  style: _estilo(11, FontWeight.w700,
                      tudoComprado ? _corVerdeChipTexto : _corTextoSuave),
                ),
              ),
            ),
            for (final item in visiveis) _linhaItem(item),
          ],
        ),
      ),
    );
  }

  Widget _linhaItem(_Item item) {
    final comprado = item.comprado;

    return InkWell(
      onTap: () => setState(() => item.comprado = !comprado),
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            //bolinha de marcar
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

            //nome (e origem, se houver)
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
                  if (item.origem != null && !comprado)
                    Text(item.origem!,
                        style: _estilo(10, FontWeight.w700, _corMarrom)),
                ],
              ),
            ),
            const SizedBox(width: 8),

            //quantidade
            if (item.quantidade.isNotEmpty)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: comprado ? _corCinzaMedio : _corCardClaro,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  item.quantidade,
                  style: _estilo(11, FontWeight.w700,
                      comprado ? _corCinzaIcone : _corTextoSuave),
                ),
              ),

            //ações do item
            PopupMenuButton<String>(
              onSelected: (_) => setState(() => _itens.remove(item)),
              color: _corBranco,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 'remover',
                  child: Text('Remover item',
                      style: _estilo(14, FontWeight.w400, _corTexto)),
                ),
              ],
              child: const SizedBox(
                width: 28,
                height: 28,
                child: Icon(Icons.more_horiz, size: 16, color: _corBordaSuave),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //botão "Adicionar item"
  Widget _botaoAdicionar() {
    return InkWell(
      onTap: _abrirAdicionar,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        height: 56,
        padding: const EdgeInsets.only(left: 16, right: 20),
        decoration: BoxDecoration(
          color: _corVerde,
          borderRadius: BorderRadius.circular(999),
          boxShadow: const [
            BoxShadow(
              color: Color(0x401B2B20),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add, size: 24, color: Colors.white),
            const SizedBox(width: 8),
            Text('Adicionar item',
                style: _estilo(14, FontWeight.w700, Colors.white)),
          ],
        ),
      ),
    );
  }

  //folha para adicionar um item
  void _abrirAdicionar() {
    String nomeDigitado = '';
    String quantidadeDigitada = '';
    int setorEscolhido = 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: _corFundo,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheet) {
            return Padding(
              //sobe a folha quando o teclado abre
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: _corCinzaClaro,
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text('Adicionar item',
                          style: _estilo(20, FontWeight.w600, _corTexto)),
                      const SizedBox(height: 16),

                      _campo('Nome do item', (v) => nomeDigitado = v,
                          autofocus: true),
                      const SizedBox(height: 10),
                      _campo('Quantidade (ex.: 2 unid, 500g)',
                          (v) => quantidadeDigitada = v),
                      const SizedBox(height: 20),

                      Text('SETOR',
                          style: _estilo(11, FontWeight.w700, _corTextoSuave,
                              espaco: 0.44)),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (int i = 0; i < _setores.length; i++)
                            GestureDetector(
                              onTap: () => setSheet(() => setorEscolhido = i),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: setorEscolhido == i
                                      ? _corVerde
                                      : _corBranco,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  _setores[i].curto,
                                  style: _estilo(
                                      12,
                                      FontWeight.w600,
                                      setorEscolhido == i
                                          ? Colors.white
                                          : _corTextoSuave),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      InkWell(
                        onTap: () {
                          if (nomeDigitado.trim().isEmpty) return;
                          setState(() {
                            _itens.add(_Item(
                              nome: nomeDigitado.trim(),
                              quantidade: quantidadeDigitada.trim(),
                              setor: setorEscolhido,
                            ));
                          });
                          Navigator.pop(sheetContext);
                        },
                        borderRadius: BorderRadius.circular(999),
                        child: Container(
                          height: 52,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: _corVerde,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text('Adicionar',
                              style: _estilo(14, FontWeight.w600, Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _campo(String dica, ValueChanged<String> aoMudar,
      {bool autofocus = false}) {
    return TextField(
      autofocus: autofocus,
      onChanged: aoMudar,
      style: _estilo(14, FontWeight.w400, _corTexto),
      decoration: InputDecoration(
        hintText: dica,
        hintStyle: _estilo(14, FontWeight.w400, _corCinzaIcone),
        filled: true,
        fillColor: _corBranco,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  //menu inferior
  Widget _menuInferior() {
    return Container(
      decoration: const BoxDecoration(
        color: _corFundo,
        boxShadow: [
          BoxShadow(
            color: Color(0x0A1B2B20),
            blurRadius: 12,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _itemMenu(Icons.home, 'Início'),
              _itemMenu(Icons.menu_book, 'Receitas'),
              _itemMenu(Icons.calendar_month, 'Planejamento'),
              _itemMenu(Icons.shopping_bag, 'Compras',
                  ativo: true, badge: _pendentes),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemMenu(IconData icone, String nome,
      {bool ativo = false, int badge = 0}) {
    final cor = ativo ? _corVerde : _corTextoSuave;

    return InkWell(
      onTap: () {},
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 64, minHeight: 44),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icone, size: 24, color: cor),
                if (badge > 0)
                  Positioned(
                    top: -4,
                    right: -10,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: _corVerdeChip,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text('$badge',
                          style:
                              _estilo(10, FontWeight.w700, _corVerdeChipTexto)),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 2),
            Text(nome,
                style:
                    _estilo(11, ativo ? FontWeight.w700 : FontWeight.w500, cor)),
            if (ativo)
              Container(
                margin: const EdgeInsets.only(top: 4),
                width: 20,
                height: 4,
                decoration: BoxDecoration(
                  color: _corVerde,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
          ],
        ),
      ),
    );
  }
}