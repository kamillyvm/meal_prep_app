import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meal_prep_app/recipes/models/Receita.dart';

// cores
const _corFundo = Color(0xFFFBF9F4);
const _corBranco = Color(0xFFFFFFFF);
const _corCardClaro = Color(0xFFF5F3EE);
const _corCinzaClaro = Color(0xFFEAE8E3);
const _corCinzaFoto = Color(0xFFF0EEE9);
const _corCinzaIcone = Color(0xFF717973);
const _corTexto = Color(0xFF1B1C19);
const _corTextoSuave = Color(0xFF414943);

const _corVerde = Color(0xFF3E6751);
const _corVerdeClaro = Color(0xFFC0EDD1);
const _corVerdeChip = Color(0xFFC6EBD2);
const _corVerdeChipTexto = Color(0xFF002112);
const _corVerdeIcone = Color(0xFF4B6C57);
const _corVerdeSecundario = Color(0xFF456552);

const _corMarromEscuro = Color(0xFF693C19);
const _corLaranjaClaro = Color(0xFFFFDCC6);
const _corMarrom = Color(0xFF85532E);

// cores com transparência
const _corVerdeChip60 = Color(0x99C6EBD2);
const _corVerdeChip40 = Color(0x66C6EBD2);
const _corBrilho = Color(0x333E6751);
const _corBranco20 = Color(0x33FFFFFF);

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

const _sombraCard = [
  BoxShadow(
    color: Color(0x0A1B2B20),
    blurRadius: 16,
    spreadRadius: -2,
    offset: Offset(0, 4),
  ),
];

const _sombraLeve = [
  BoxShadow(
    color: Color(0x0D000000),
    blurRadius: 2,
    offset: Offset(0, 1),
  ),
];

const _diasCurto = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
const _mesesCompleto = [
  'Janeiro',
  'Fevereiro',
  'Março',
  'Abril',
  'Maio',
  'Junho',
  'Julho',
  'Agosto',
  'Setembro',
  'Outubro',
  'Novembro',
  'Dezembro',
];
const _mesesCurto = [
  'Jan',
  'Fev',
  'Mar',
  'Abr',
  'Mai',
  'Jun',
  'Jul',
  'Ago',
  'Set',
  'Out',
  'Nov',
  'Dez',
];

// metas diárias
const _metaKcal = 1800;
const _metaProteina = 105;
const _metaCarbo = 160;

// refeições de cada dia
class _Slot {
  final String nome;
  final String categoria;
  final String hora;
  final IconData icone;

  const _Slot({
    required this.nome,
    required this.categoria,
    required this.hora,
    required this.icone,
  });
}

const _slots = [
  _Slot(
    nome: 'Café da manhã',
    categoria: 'Café da manhã',
    hora: '07:30',
    icone: Icons.sunny,
  ),
  _Slot(
    nome: 'Almoço',
    categoria: 'Almoço',
    hora: '12:30',
    icone: Icons.lunch_dining,
  ),
  _Slot(
    nome: 'Lanche da tarde',
    categoria: 'Lanche',
    hora: '16:30',
    icone: Icons.bakery_dining,
  ),
  _Slot(
    nome: 'Jantar',
    categoria: 'Jantar',
    hora: '20:00',
    icone: Icons.bedtime,
  ),
];

class _Planejada {
  final Recipe receita;
  bool preparada;

  _Planejada(this.receita, {this.preparada = false});
}

String _milhar(int n) {
  final texto = n.toString();
  final buffer = StringBuffer();
  for (int i = 0; i < texto.length; i++) {
    if (i > 0 && (texto.length - i) % 3 == 0) buffer.write('.');
    buffer.write(texto[i]);
  }
  return buffer.toString();
}

String _numCurto(double valor) {
  if (valor % 1 == 0) return valor.toInt().toString();
  return valor.toStringAsFixed(1).replaceAll('.', ',');
}

class PlannerView extends StatefulWidget {
  final List<Recipe> receitasDisponiveis;
  final ValueChanged<List<Recipe>>? onGerarListaCompras;
  final VoidCallback? onIrParaCompras;
  final VoidCallback? onIrParaReceitas;

  const PlannerView({
    super.key,
    this.receitasDisponiveis = const [],
    this.onGerarListaCompras,
    this.onIrParaCompras,
    this.onIrParaReceitas,
  });

  @override
  State<PlannerView> createState() => _PlannerViewState();
}

class _PlannerViewState extends State<PlannerView> {
  final DateTime _hoje = DateTime.now();
  late final DateTime _inicioSemanaAtual = DateTime(
    _hoje.year,
    _hoje.month,
    _hoje.day - (_hoje.weekday - 1),
  );

  int _semana = 0; // 0 = semana atual, -1 = anterior, 1 = próxima...
  late int _diaSelecionado = _hoje.weekday - 1; // 0 = segunda

  // plano: chave "ano-mês-dia-slot" -> receita escolhida
  final Map<String, _Planejada> _plano = {};

  DateTime _data(int semana, int i) => DateTime(
    _inicioSemanaAtual.year,
    _inicioSemanaAtual.month,
    _inicioSemanaAtual.day + semana * 7 + i,
  );

  DateTime _dataDoDia(int i) => _data(_semana, i);

  String _chave(DateTime d, int slot) => '${d.year}-${d.month}-${d.day}-$slot';

  _Planejada? _refeicao(int dia, int slot) =>
      _plano[_chave(_dataDoDia(dia), slot)];

  String get _textoSemana {
    final ini = _dataDoDia(0);
    final fim = _dataDoDia(6);
    if (ini.month == fim.month) {
      return '${ini.day} a ${fim.day} de ${_mesesCompleto[fim.month - 1]}, ${fim.year}';
    }
    if (ini.year == fim.year) {
      return '${ini.day} de ${_mesesCurto[ini.month - 1]} a '
          '${fim.day} de ${_mesesCurto[fim.month - 1]}, ${fim.year}';
    }
    return '${ini.day} ${_mesesCurto[ini.month - 1]} ${ini.year} a '
        '${fim.day} ${_mesesCurto[fim.month - 1]} ${fim.year}';
  }

  String get _textoDiaSelecionado {
    final d = _dataDoDia(_diaSelecionado);
    return '${_diasCurto[_diaSelecionado]}, ${d.day} de ${_mesesCompleto[d.month - 1]}';
  }

  int _qtdNoDia(int dia) {
    int n = 0;
    for (int s = 0; s < _slots.length; s++) {
      if (_refeicao(dia, s) != null) n++;
    }
    return n;
  }

  int get _definidasSemana {
    int n = 0;
    for (int i = 0; i < 7; i++) {
      n += _qtdNoDia(i);
    }
    return n;
  }

  int get _totalSemana => 7 * _slots.length;

  List<Recipe> get _receitasDaSemana {
    final lista = <Recipe>[];
    for (int i = 0; i < 7; i++) {
      for (int s = 0; s < _slots.length; s++) {
        final p = _refeicao(i, s);
        if (p != null) lista.add(p.receita);
      }
    }
    return lista;
  }

  double _somaCaloriesDia() {
    double total = 0;
    for (int s = 0; s < _slots.length; s++) {
      final p = _refeicao(_diaSelecionado, s);
      if (p != null) total += p.receita.calories;
    }
    return total;
  }

  double _somaProteinaDia() {
    double total = 0;
    for (int s = 0; s < _slots.length; s++) {
      final p = _refeicao(_diaSelecionado, s);
      if (p != null) total += p.receita.protein;
    }
    return total;
  }

  double _somaCarboDia() {
    double total = 0;
    for (int s = 0; s < _slots.length; s++) {
      final p = _refeicao(_diaSelecionado, s);
      if (p != null) total += p.receita.carbs;
    }
    return total;
  }

  int get _ingredientesSemana {
    int total = 0;
    for (final r in _receitasDaSemana) {
      total += r.ingredients.length;
    }
    return total;
  }

  void _mudarSemana(int delta) {
    setState(() {
      _semana += delta;
      if (_semana == 0) _diaSelecionado = _hoje.weekday - 1;
    });
  }

  void _voltarParaHoje() {
    setState(() {
      _semana = 0;
      _diaSelecionado = _hoje.weekday - 1;
    });
  }

  void _acaoMenu(String acao) {
    if (acao == 'duplicar') {
      _duplicarSemanaAnterior();
    } else if (acao == 'limparDia') {
      setState(() {
        for (int s = 0; s < _slots.length; s++) {
          _plano.remove(_chave(_dataDoDia(_diaSelecionado), s));
        }
      });
    } else if (acao == 'limparSemana') {
      setState(() {
        for (int i = 0; i < 7; i++) {
          for (int s = 0; s < _slots.length; s++) {
            _plano.remove(_chave(_dataDoDia(i), s));
          }
        }
      });
    }
  }

  void _duplicarSemanaAnterior() {
    int naOrigem = 0;
    int copiadas = 0;

    setState(() {
      for (int i = 0; i < 7; i++) {
        for (int s = 0; s < _slots.length; s++) {
          final antiga = _plano[_chave(_data(_semana - 1, i), s)];
          if (antiga == null) continue;
          naOrigem++;

          final novaChave = _chave(_dataDoDia(i), s);
          if (_plano.containsKey(novaChave)) continue;

          _plano[novaChave] = _Planejada(antiga.receita);
          copiadas++;
        }
      }
    });

    if (naOrigem == 0) {
      _aviso('A semana anterior não tem refeições planejadas.');
    } else if (copiadas == 0) {
      _aviso('Nada para copiar: os horários desta semana já estão preenchidos.');
    } else {
      _aviso(
        '$copiadas ${copiadas == 1 ? 'refeição copiada' : 'refeições copiadas'} da semana anterior.',
      );
    }
  }

  void _gerarLista() {
    final receitas = _receitasDaSemana;
    if (receitas.isEmpty) {
      _aviso('Aloque ao menos uma receita na semana antes de gerar a lista.');
      return;
    }

    widget.onGerarListaCompras?.call(receitas);
    _aviso('Lista de compras gerada com $_ingredientesSemana ingredientes.');
    widget.onIrParaCompras?.call();
  }

  Future<void> _abrirEscolha(int slotIndex) async {
    final slot = _slots[slotIndex];
    if (widget.receitasDisponiveis.isEmpty) {
      _aviso('Nenhuma receita cadastrada ainda. Vá em Receitas para adicionar.');
      widget.onIrParaReceitas?.call();
      return;
    }

    final escolhida = await showModalBottomSheet<Recipe>(
      context: context,
      backgroundColor: _corFundo,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: widget.receitasDisponiveis.length + 1,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Text(
              'Escolher para ${slot.nome}',
              style: _estilo(18, FontWeight.w700, _corTexto),
            );
          }
          final r = widget.receitasDisponiveis[index - 1];
          return ListTile(
            tileColor: _corBranco,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            title: Text(
              r.title,
              style: _estilo(15, FontWeight.w600, _corTexto),
            ),
            subtitle: Text(
              '${_numCurto(r.calories)} kcal • ${_numCurto(r.protein)}g prot • ${r.prepTimeMinutes} min',
              style: _estilo(12, FontWeight.w400, _corTextoSuave),
            ),
            onTap: () => Navigator.pop(context, r),
          );
        },
      ),
    );

    if (escolhida != null) {
      setState(() {
        _plano[_chave(_dataDoDia(_diaSelecionado), slotIndex)] =
            _Planejada(escolhida);
      });
    }
  }

  void _aviso(String texto) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(texto, style: _estilo(13, FontWeight.w500, Colors.white)),
          backgroundColor: _corTexto,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _corFundo,
      appBar: _appBar(),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          _cabecalho(),
          _cardProgresso(),
          _navegacaoSemana(),
          _faixaDias(),
          _secaoRefeicoes(),
          _resumoNutricional(),
          _botaoGerarLista(),
        ],
      ),
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
                'Planejamento',
                style: _estilo(18, FontWeight.w600, _corTexto),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cabecalho() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Planejamento semanal',
                  style: _estilo(22, FontWeight.w700, _corTexto, altura: 1.36),
                ),
                const SizedBox(height: 2),
                Text(
                  'Organize suas refeições com praticidade',
                  style: _estilo(14, FontWeight.w400, _corTextoSuave, altura: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: _corVerdeChip,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.eco, size: 20, color: _corVerdeChipTexto),
          ),
        ],
      ),
    );
  }

  Widget _cardProgresso() {
    final definidas = _definidasSemana;
    final progresso = definidas / _totalSemana;
    final porcentagem = (progresso * 100).round();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _corCardClaro,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      const Icon(Icons.fact_check, size: 18, color: _corVerde),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          '$definidas de $_totalSemana refeições definidas',
                          overflow: TextOverflow.ellipsis,
                          style: _estilo(12, FontWeight.w600, _corTexto),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '$porcentagem%',
                  style: _estilo(11, FontWeight.w700, _corVerde),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: progresso,
                minHeight: 8,
                backgroundColor: _corCinzaClaro,
                color: _corVerde,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navegacaoSemana() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _corBranco,
          borderRadius: BorderRadius.circular(32),
          boxShadow: _sombraCard,
        ),
        child: Row(
          children: [
            _setaSemana(Icons.chevron_left, () => _mudarSemana(-1)),
            Expanded(
              child: Column(
                children: [
                  if (_semana == 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _corVerdeChip,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'SEMANA ATUAL',
                        style: _estilo(
                          11,
                          FontWeight.w700,
                          _corVerdeChipTexto,
                          espaco: 0.44,
                        ),
                      ),
                    )
                  else
                    InkWell(
                      onTap: _voltarParaHoje,
                      borderRadius: BorderRadius.circular(999),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _corCardClaro,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          'VOLTAR PARA HOJE',
                          style: _estilo(
                            11,
                            FontWeight.w700,
                            _corVerde,
                            espaco: 0.44,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 2),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      _textoSemana,
                      maxLines: 1,
                      style: _estilo(18, FontWeight.w600, _corTexto),
                    ),
                  ),
                ],
              ),
            ),
            _setaSemana(Icons.chevron_right, () => _mudarSemana(1)),
          ],
        ),
      ),
    );
  }

  Widget _setaSemana(IconData icone, VoidCallback aoTocar) {
    return InkWell(
      onTap: aoTocar,
      borderRadius: BorderRadius.circular(999),
      child: SizedBox(
        width: 40,
        height: 40,
        child: Icon(icone, size: 22, color: _corTextoSuave),
      ),
    );
  }

  Widget _faixaDias() {
    final n = _qtdNoDia(_diaSelecionado);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SELECIONE O DIA',
                style: _estilo(11, FontWeight.w700, _corTextoSuave, espaco: 0.44),
              ),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: n == 0 ? _corCinzaClaro : _corVerde,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    n == 0
                        ? 'Nenhuma refeição'
                        : '$n ${n == 1 ? 'refeição ativa' : 'refeições ativas'}',
                    style: _estilo(11, FontWeight.w700, _corVerde),
                  ),
                ],
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          child: Row(
            children: [
              for (int i = 0; i < 7; i++) ...[
                _botaoDia(i),
                if (i < 6) const SizedBox(width: 8),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _botaoDia(int i) {
    final ativo = i == _diaSelecionado;
    final n = _qtdNoDia(i);

    return GestureDetector(
      onTap: () => setState(() => _diaSelecionado = i),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: ativo ? 64 : 58,
        height: 88,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: ativo ? _corVerde : _corBranco,
          borderRadius: BorderRadius.circular(16),
          boxShadow: _sombraLeve,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _diasCurto[i].toUpperCase(),
              style: _estilo(
                11,
                FontWeight.w700,
                ativo ? _corVerdeClaro : _corTextoSuave,
                espaco: 0.44,
              ),
            ),
            Text(
              '${_dataDoDia(i).day}',
              style: _estilo(
                18,
                FontWeight.w600,
                ativo ? Colors.white : _corTexto,
              ),
            ),
            if (ativo)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _corBranco20,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '$n/${_slots.length}',
                  style: _estilo(10, FontWeight.w700, Colors.white),
                ),
              )
            else
              _pontos(n),
          ],
        ),
      ),
    );
  }

  Widget _pontos(int n) {
    if (n == 0) {
      return _ponto(_corCinzaClaro);
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < n; i++) ...[
          _ponto(_corVerde),
          if (i < n - 1) const SizedBox(width: 2),
        ],
      ],
    );
  }

  Widget _ponto(Color cor) {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(color: cor, shape: BoxShape.circle),
    );
  }

  Widget _secaoRefeicoes() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      'Refeições do dia',
                      style: _estilo(20, FontWeight.w600, _corTexto),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _corCinzaClaro,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        _textoDiaSelecionado,
                        style: _estilo(11, FontWeight.w700, _corTexto),
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: _acaoMenu,
                color: _corBranco,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: 'duplicar',
                    child: Text(
                      'Duplicar semana anterior',
                      style: _estilo(14, FontWeight.w400, _corTexto),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'limparDia',
                    child: Text(
                      'Limpar este dia',
                      style: _estilo(14, FontWeight.w400, _corTexto),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'limparSemana',
                    child: Text(
                      'Limpar a semana',
                      style: _estilo(14, FontWeight.w400, _corTexto),
                    ),
                  ),
                ],
                child: const SizedBox(
                  width: 32,
                  height: 32,
                  child: Icon(Icons.tune, size: 20, color: _corTextoSuave),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_definidasSemana == 0) ...[
            _estadoVazioSemana(),
            const SizedBox(height: 16),
          ],
          for (int s = 0; s < _slots.length; s++) ...[
            if (_refeicao(_diaSelecionado, s) != null)
              _cardRefeicao(s, _refeicao(_diaSelecionado, s)!)
            else
              _cardVazio(s),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }

  Widget _estadoVazioSemana() {
    return Container(
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
              Icons.calendar_month,
              size: 30,
              color: _corVerdeIcone,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Sua semana está em branco',
            textAlign: TextAlign.center,
            style: _estilo(18, FontWeight.w600, _corTexto),
          ),
          const SizedBox(height: 4),
          Text(
            'Escolha uma receita para cada refeição e monte o cardápio da semana. Você também pode duplicar uma semana anterior.',
            textAlign: TextAlign.center,
            style: _estilo(14, FontWeight.w400, _corTextoSuave, altura: 1.4),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () => _abrirEscolha(0),
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
                'Planejar primeira refeição',
                style: _estilo(14, FontWeight.w600, Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardRefeicao(int s, _Planejada p) {
    final slot = _slots[s];
    final r = p.receita;
    final chave = _chave(_dataDoDia(_diaSelecionado), s);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _corBranco,
        borderRadius: BorderRadius.circular(32),
        boxShadow: _sombraCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(slot.icone, size: 18, color: _corVerde),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        '${slot.nome} • ${slot.hora}'.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        style: _estilo(
                          11,
                          FontWeight.w700,
                          _corTextoSuave,
                          espaco: 0.44,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () => setState(() => p.preparada = !p.preparada),
                    borderRadius: BorderRadius.circular(999),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: p.preparada ? _corVerdeChip : _corCardClaro,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        p.preparada ? 'Preparada ✓' : 'Marcar prep.',
                        style: _estilo(
                          11,
                          FontWeight.w700,
                          p.preparada ? _corVerdeChipTexto : _corTextoSuave,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    onPressed: () => setState(() => _plano.remove(chave)),
                    icon: const Icon(Icons.close, size: 18, color: _corCinzaIcone),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () => _abrirEscolha(s),
            borderRadius: BorderRadius.circular(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  r.title,
                  style: _estilo(16, FontWeight.w600, _corTexto),
                ),
                const SizedBox(height: 6),
                Text(
                  '${_numCurto(r.calories)} kcal • ${_numCurto(r.protein)}g prot • ${_numCurto(r.carbs)}g carb • ${r.prepTimeMinutes} min',
                  style: _estilo(12, FontWeight.w400, _corTextoSuave),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardVazio(int s) {
    final slot = _slots[s];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _corBranco,
        borderRadius: BorderRadius.circular(32),
        boxShadow: _sombraCard,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: _corCardClaro,
              shape: BoxShape.circle,
            ),
            child: Icon(slot.icone, size: 20, color: _corVerde),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${slot.nome} • ${slot.hora}',
                  style: _estilo(14, FontWeight.w600, _corTexto),
                ),
                Text(
                  'Nenhuma receita alocada',
                  style: _estilo(12, FontWeight.w400, _corTextoSuave),
                ),
              ],
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: _corVerdeChip,
              foregroundColor: _corVerdeChipTexto,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            onPressed: () => _abrirEscolha(s),
            child: Text(
              'Escolher',
              style: _estilo(12, FontWeight.w700, _corVerdeChipTexto),
            ),
          ),
        ],
      ),
    );
  }

  Widget _resumoNutricional() {
    final kcal = _somaCaloriesDia().round();
    final prot = _numCurto(_somaProteinaDia());
    final carb = _numCurto(_somaCarboDia());

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _corBranco,
          borderRadius: BorderRadius.circular(24),
          boxShadow: _sombraCard,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'RESUMO DO DIA',
              style: _estilo(11, FontWeight.w700, _corTextoSuave, espaco: 0.44),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _metrica('Calorias', '${_milhar(kcal)} / ${_milhar(_metaKcal)}'),
                _metrica('Proteína', '${prot}g / ${_metaProteina}g'),
                _metrica('Carbo', '${carb}g / ${_metaCarbo}g'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _metrica(String titulo, String valor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: _estilo(11, FontWeight.w600, _corTextoSuave),
        ),
        const SizedBox(height: 2),
        Text(
          valor,
          style: _estilo(13, FontWeight.w700, _corTexto),
        ),
      ],
    );
  }

  Widget _botaoGerarLista() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 50,
        child: FilledButton.icon(
          style: FilledButton.styleFrom(
            backgroundColor: _corVerde,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          onPressed: _gerarLista,
          icon: const Icon(Icons.shopping_cart_checkout, size: 20),
          label: Text(
            'Gerar lista de compras ($_ingredientesSemana itens)',
            style: _estilo(14, FontWeight.w600, Colors.white),
          ),
        ),
      ),
    );
  }
}