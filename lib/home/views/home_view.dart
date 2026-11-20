import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// cores
const corFundo = Color(0xFFFBF9F4);
const corBranco = Color(0xFFFFFFFF);
const corCardClaro = Color(0xFFF5F3EE);
const corCinzaFoto = Color(0xFFF0EEE9);
const corCinzaIcone = Color(0xFF717973);
const corTexto = Color(0xFF1B1C19);
const corTextoSuave = Color(0xFF414943);
const corSobreHero = Color(0xFFE4E2DD);

const corVerde = Color(0xFF3E6751);
const corVerdeEscuro = Color(0xFF113B28);
const corVerdeClaro = Color(0xFFC0EDD1);
const corVerdeChip = Color(0xFFC6EBD2);
const corVerdeChipTexto = Color(0xFF002112);
const corVerdeMedio = Color(0xFF456552);
const corVerdeIcone = Color(0xFF4B6C57);
const corVerdeFreezerTexto = Color(0xFF264F3A);

const corMarrom = Color(0xFF85532E);
const corMarromTexto = Color(0xFF522907);

// cores com transparência
const corVerdeChip70 = Color(0xB3C6EBD2);
const corVerdeClaro50 = Color(0x80C0EDD1);
const corLaranjaClaro60 = Color(0x99FFDCC6);
const corVerdeChip60 = Color(0x99C6EBD2);
const corTrilhaAnel = Color(0x26FBF9F4);
const corBrilho = Color(0x333E6751);
const corBotaoDia = Color(0x0DFBF9F4);

// estilo de texto simples
TextStyle estilo(
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

const sombraCard = [
  BoxShadow(
    color: Color(0x0A1B2B20),
    blurRadius: 16,
    spreadRadius: -2,
    offset: Offset(0, 4),
  ),
];

const diasSemana = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
const diasSemanaCompleto = [
  'SEGUNDA',
  'TERÇA',
  'QUARTA',
  'QUINTA',
  'SEXTA',
  'SÁBADO',
  'DOMINGO',
];
const meses = [
  'JAN',
  'FEV',
  'MAR',
  'ABR',
  'MAI',
  'JUN',
  'JUL',
  'AGO',
  'SET',
  'OUT',
  'NOV',
  'DEZ',
];

class Refeicao {
  final String periodo;
  final String hora;
  final IconData iconePeriodo;
  final Color corPeriodo;
  final String titulo;
  final String imagem;
  final IconData iconeTag;
  final String textoTag;
  final Color fundoTag;
  final Color corTag;
  final IconData iconeMacro;
  final String textoMacro;

  Refeicao({
    required this.periodo,
    required this.hora,
    required this.iconePeriodo,
    required this.corPeriodo,
    required this.titulo,
    required this.imagem,
    required this.iconeTag,
    required this.textoTag,
    required this.fundoTag,
    required this.corTag,
    required this.iconeMacro,
    required this.textoMacro,
  });
}

class HomeView extends StatefulWidget {
  final int totalPlanejadas;
  final int feitasPlanejadas;
  final int totalItensLista;
  final VoidCallback? onIrParaPlanejar;
  final VoidCallback? onIrParaCompras;
  final VoidCallback? onIrParaReceitas;

  const HomeView({
    super.key,
    this.totalPlanejadas = 0,
    this.feitasPlanejadas = 0,
    this.totalItensLista = 0,
    this.onIrParaPlanejar,
    this.onIrParaCompras,
    this.onIrParaReceitas,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final DateTime hoje = DateTime.now();
  late final DateTime inicioSemana = DateTime(
    hoje.year,
    hoje.month,
    hoje.day - (hoje.weekday - 1),
  );

  late int diaSelecionado = hoje.weekday - 1;
  final Set<int> refeicoesConcluidas = {};

  DateTime dataDoDia(int i) => inicioSemana.add(Duration(days: i));

  String get textoSemana {
    final fim = dataDoDia(6);
    if (inicioSemana.month == fim.month) {
      return '${inicioSemana.day} A ${fim.day} ${meses[fim.month - 1]}';
    }
    return '${inicioSemana.day} ${meses[inicioSemana.month - 1]} A '
        '${fim.day} ${meses[fim.month - 1]}';
  }

  String get textoDiaSelecionado {
    final d = dataDoDia(diaSelecionado);
    return '${diasSemanaCompleto[diaSelecionado]}, ${d.day} ${meses[d.month - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corFundo,
      appBar: _appBar(),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          _saudacao(),
          _cardSemana(),
          _bannerCompras(),
          _secaoRefeicoes(),
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      toolbarHeight: 64,
      backgroundColor: corFundo,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      titleSpacing: 20,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: 42,
            height: 42,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => const Icon(
              Icons.eco,
              size: 32,
              color: corVerde,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'MEAL PREP',
                style: estilo(11, FontWeight.w700, corVerde, espaco: 0.44),
              ),
              Text('Início', style: estilo(18, FontWeight.w600, corTexto)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _saudacao() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bom dia! 🌱',
                  style: estilo(22, FontWeight.w700, corTexto, altura: 1.36),
                ),
                const SizedBox(height: 2),
                Text(
                  'Vamos começar a planejar sua semana?',
                  style: estilo(14, FontWeight.w400, corTextoSuave, altura: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: corVerdeChip60,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.eco, size: 20, color: corVerdeIcone),
          ),
        ],
      ),
    );
  }

  Widget _cardSemana() {
    final total = widget.totalPlanejadas;
    final feitas = widget.feitasPlanejadas.clamp(0, total);
    final semRefeicoes = total == 0;
    final progresso = semRefeicoes ? 0.0 : (feitas / total).clamp(0.0, 1.0);
    final porcentagem = (progresso * 100).round();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Container(
          color: corVerdeEscuro,
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              Positioned(
                right: -60,
                bottom: -60,
                child: Container(
                  width: 176,
                  height: 176,
                  decoration: const BoxDecoration(
                    color: corBrilho,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              size: 18,
                              color: corVerdeClaro,
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                'SEMANA ATUAL • $textoSemana',
                                overflow: TextOverflow.ellipsis,
                                style: estilo(
                                  11,
                                  FontWeight.w700,
                                  corSobreHero,
                                  espaco: 0.44,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: widget.onIrParaPlanejar,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Planejar',
                                style: estilo(
                                  11,
                                  FontWeight.w700,
                                  corVerdeClaro,
                                  espaco: 0.44,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.arrow_forward,
                                size: 16,
                                color: corVerdeClaro,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(
                        width: 64,
                        height: 64,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 64,
                              height: 64,
                              child: CircularProgressIndicator(
                                value: progresso,
                                strokeWidth: 5.5,
                                strokeCap: StrokeCap.round,
                                backgroundColor: corTrilhaAnel,
                                color: corVerdeClaro,
                              ),
                            ),
                            Text(
                              '$porcentagem%',
                              style: estilo(12, FontWeight.w700, corFundo),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              semRefeicoes
                                  ? 'Nenhuma refeição planejada'
                                  : '$total ${total == 1 ? 'refeição planejada' : 'refeições planejadas'}',
                              style: estilo(
                                18,
                                FontWeight.w600,
                                corFundo,
                                altura: 1.3,
                              ),
                            ),
                            Text(
                              semRefeicoes
                                  ? 'Monte seu planejamento para acompanhar o progresso'
                                  : feitas > 0
                                  ? '$feitas de $total preparadas na semana'
                                  : 'Prontas na sua semana para gerar a lista',
                              style: estilo(12, FontWeight.w400, corSobreHero),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int i = 0; i < 7; i++) _botaoDia(i),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _botaoDia(int i) {
    final ativo = i == diaSelecionado;

    return GestureDetector(
      onTap: () => setState(() => diaSelecionado = i),
      child: Container(
        constraints: BoxConstraints(minWidth: ativo ? 42 : 38),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: ativo ? 8 : 6),
        decoration: BoxDecoration(
          color: ativo ? corVerde : corBotaoDia,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              diasSemana[i].toUpperCase(),
              style: estilo(
                10,
                FontWeight.w700,
                ativo ? corVerdeClaro : corSobreHero,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '${dataDoDia(i).day}',
              style: estilo(
                12,
                ativo ? FontWeight.w700 : FontWeight.w600,
                ativo ? Colors.white : corFundo,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bannerCompras() {
    final qtd = widget.totalItensLista;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: corCardClaro,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: corVerdeChip,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_basket,
                size: 22,
                color: corVerdeChipTexto,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lista da Semana',
                    overflow: TextOverflow.ellipsis,
                    style: estilo(12, FontWeight.w600, corTexto),
                  ),
                  Text(
                    qtd == 0
                        ? 'Nenhum item adicionado ainda'
                        : '$qtd ${qtd == 1 ? 'item na lista' : 'itens na lista'}',
                    overflow: TextOverflow.ellipsis,
                    style: estilo(12, FontWeight.w400, corTextoSuave),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: widget.onIrParaCompras,
              borderRadius: BorderRadius.circular(999),
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: corBranco,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text('Abrir', style: estilo(12, FontWeight.w600, corVerde)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _secaoRefeicoes() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Refeições de Hoje',
                style: estilo(20, FontWeight.w600, corTexto),
              ),
              Text(
                textoDiaSelecionado,
                style: estilo(11, FontWeight.w700, corVerde, espaco: 0.44),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _estadoVazioRefeicoes(),
        ],
      ),
    );
  }

  Widget _estadoVazioRefeicoes() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 28),
      decoration: BoxDecoration(
        color: corBranco,
        borderRadius: BorderRadius.circular(32),
        boxShadow: sombraCard,
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: corVerdeChip60,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.restaurant_menu,
              size: 30,
              color: corVerdeIcone,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.totalPlanejadas == 0
                ? 'Nenhuma refeição por aqui'
                : '${widget.totalPlanejadas} ${widget.totalPlanejadas == 1 ? 'refeição planejada' : 'refeições planejadas'} na semana',
            textAlign: TextAlign.center,
            style: estilo(18, FontWeight.w600, corTexto),
          ),
          const SizedBox(height: 4),
          Text(
            widget.totalPlanejadas == 0
                ? 'Planeje seu cardápio e as refeições do dia vão aparecer neste espaço.'
                : 'Veja e gerencie os horários na aba Planejar ou gere sua lista em Compras.',
            textAlign: TextAlign.center,
            style: estilo(14, FontWeight.w400, corTextoSuave, altura: 1.4),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: widget.onIrParaPlanejar,
            borderRadius: BorderRadius.circular(999),
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: corVerde,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                widget.totalPlanejadas == 0
                    ? 'Planejar refeições'
                    : 'Ver planejamento',
                style: estilo(14, FontWeight.w600, Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}