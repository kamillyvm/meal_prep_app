import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//cores
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

//cores com transparência
const corVerdeChip70 = Color(0xB3C6EBD2);
const corVerdeClaro50 = Color(0x80C0EDD1);
const corLaranjaClaro60 = Color(0x99FFDCC6);
const corVerdeChip60 = Color(0x99C6EBD2);
const corTrilhaAnel = Color(0x26FBF9F4);
const corBrilho = Color(0x333E6751);
const corBotaoDia = Color(0x0DFBF9F4);

//estilo de texto simples
TextStyle estilo(double tamanho, FontWeight peso, Color cor,
    {double? altura, double? espaco}) {
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

//dados
//primeiro acesso: nada foi cadastrado nem planejado ainda
//depois esses valores virão do ViewModel
int totalRefeicoesSemana = 0; //refeições planejadas na semana
int refeicoesFeitasSemana = 0; //refeições já consumidas na semana

//troque para true só para testar como o layout fica com refeições
bool usarDadosDeExemplo = false;

const diasSemana = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
const diasSemanaCompleto = [
  'SEGUNDA', 'TERÇA', 'QUARTA', 'QUINTA', 'SEXTA', 'SÁBADO', 'DOMINGO'
];
const meses = [
  'JAN', 'FEV', 'MAR', 'ABR', 'MAI', 'JUN',
  'JUL', 'AGO', 'SET', 'OUT', 'NOV', 'DEZ'
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

//refeições de hoje (vazio no primeiro acesso)
final List<Refeicao> refeicoesDeHoje =
    usarDadosDeExemplo ? refeicoesExemplo : <Refeicao>[];

//só para testar o layout (usarDadosDeExemplo = true)
final refeicoesExemplo = [
  Refeicao(
    periodo: 'Café da Manhã',
    hora: '07:30',
    iconePeriodo: Icons.wb_twilight,
    corPeriodo: corVerde,
    titulo: 'Overnight Oats com Frutas Vermelhas & Chia',
    imagem: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCSfNz7RHxabFJrrpmE_NJACA_QsjJ_c4QjO7cI1-xNl31mmetOi8MXlNTqu9NK8vVz0ieSD7Bm2XDVRKGzwTxa-XUe4DR-L41ZiHKQU9CO7irHGx_IO7Xu3qzF8GpRLx20iJ1MiLQ_Oi84tGozhcZjEtG5-btOUaSne4dnnHCb9J9rxn7jBqsdXeuaUzSERaVygzNE06uuCVNSy4CjhV3SW8Uex2H0q3WP1MLgIIA',
    iconeTag: Icons.kitchen,
    textoTag: 'Pronto na geladeira',
    fundoTag: corVerdeChip70,
    corTag: corVerdeChipTexto,
    iconeMacro: Icons.local_fire_department,
    textoMacro: '340 kcal • 14g prot',
  ),
  Refeicao(
    periodo: 'Almoço',
    hora: '12:30',
    iconePeriodo: Icons.sunny,
    corPeriodo: corVerdeMedio,
    titulo: 'Bowl de Quinoa, Frango Grelhado & Legumes Tostados',
    imagem: 'https://lh3.googleusercontent.com/aida-public/AB6AXuA0msVDxljJJdeqfKSbu4hgu05d9xKx1ycGwnnkVLcLwEd20OMmjAiJ0-VteomCfDsbGyXKJUydS9y3Vb0QQiwsBLqfo6gLJaxIcmxx6ymC3kld2-Gq_SMgxzMoMkevXXkLkbdjU05sAtH3ceHyWW9HNZbq9bK7cezFc4SH_QVyEZpJ0XomJ99f4ZOCDj4uKsTNZkPYZ9Qf-aa0qe6FY_5SzAlw53ZzbPS9shN71Mg',
    iconeTag: Icons.ac_unit,
    textoTag: 'Porção 3/4 no freezer',
    fundoTag: corVerdeClaro50,
    corTag: corVerdeFreezerTexto,
    iconeMacro: Icons.fitness_center,
    textoMacro: '520 kcal • 38g prot',
  ),
  Refeicao(
    periodo: 'Lanche',
    hora: '16:00',
    iconePeriodo: Icons.energy_savings_leaf,
    corPeriodo: corMarrom,
    titulo: 'Mix de Castanhas & Iogurte Natural com Mel',
    imagem: 'https://lh3.googleusercontent.com/aida/ALJJyrByVDP_mg9eFsGinVUdkIkQNWZMKYbJUlO2CCJiQrTti-eMssCO6FKPmA-4bv1-E79_S3EXXeHtrhnvHIY4WQ4TreFbzr_Qinmys_DH77lFfeVTrMpsSEyfz5aYnDcERygI45BW0hS7Cn_uT-PwLdpT88FWqMXxZ79x5jQtNpIskZml1zI0ENaYNNlbNV7JAgnxzW2lMESo3dicipY9yX5nIBI2udrc2d4RDm_JXTE',
    iconeTag: Icons.bolt,
    textoTag: 'Lanche rápido (2 min)',
    fundoTag: corLaranjaClaro60,
    corTag: corMarromTexto,
    iconeMacro: Icons.local_fire_department,
    textoMacro: '210 kcal • 9g prot',
  ),
  Refeicao(
    periodo: 'Jantar',
    hora: '20:00',
    iconePeriodo: Icons.dark_mode,
    corPeriodo: corTextoSuave,
    titulo: 'Sopa Cremosa de Abóbora Cabotiá com Gengibre',
    imagem: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDzdjzbq-oYzpeIP0dMJwM-Ke1hqoPMVrdCCGnc9RSx7Fh4awLqqnb4L4jmPeodVSwzilveorM8MJltSRPeMzJSFXcvSNx5Fkji_zac3caITBRdlqc7Q9gz3Cqi70jt5xtrre3C6yq2AceoWO6cw1w6yE0DWCZu_aeKqHNOyoFE5szukO3Aq8s7Dc17nLmfS2rdNRbuibMTItBIoOjD4c8kcx9tHY_65Z14DiVk7z0',
    iconeTag: Icons.microwave,
    textoTag: 'Aquecer 5 min',
    fundoTag: corVerdeChip70,
    corTag: corVerdeChipTexto,
    iconeMacro: Icons.local_fire_department,
    textoMacro: '310 kcal • 11g prot',
  ),
];

//tela
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //datas da semana atual
  final DateTime hoje = DateTime.now();
  late final DateTime inicioSemana =
      DateTime(hoje.year, hoje.month, hoje.day - (hoje.weekday - 1));

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
      bottomNavigationBar: _menuInferior(),
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

  //topo
  PreferredSizeWidget _appBar() {
    return AppBar(
      toolbarHeight: 64,
      backgroundColor: corFundo,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      titleSpacing: 20,
      title: Row(
        children: [
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('MEAL PREP',
                  style: estilo(11, FontWeight.w700, corVerde, espaco: 0.44)),
              Text('Início', style: estilo(18, FontWeight.w600, corTexto)),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_outlined,
              size: 22, color: corTextoSuave),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 20),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: corVerdeChip60,
              shape: BoxShape.circle,
              border: Border.all(color: corBrilho, width: 2),
            ),
            child: const Icon(Icons.person_outline,
                size: 20, color: corVerdeIcone),
          ),
        ),
      ],
    );
  }

  //saudação
  Widget _saudacao() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bom dia! 🌱',
                    style: estilo(22, FontWeight.w700, corTexto, altura: 1.36)),
                const SizedBox(height: 2),
                Text('Vamos começar a planejar sua semana?',
                    style:
                        estilo(14, FontWeight.w400, corTextoSuave, altura: 1.4)),
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

  //card da semana
  Widget _cardSemana() {
    final semRefeicoes = totalRefeicoesSemana == 0;
    final progresso =
        semRefeicoes ? 0.0 : refeicoesFeitasSemana / totalRefeicoesSemana;
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
              //brilho decorativo no canto
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
                  //título + link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                size: 18, color: corVerdeClaro),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                'SEMANA ATUAL • $textoSemana',
                                overflow: TextOverflow.ellipsis,
                                style: estilo(11, FontWeight.w700, corSobreHero,
                                    espaco: 0.44),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6),
                          child: Row(
                            children: [
                              Text('Planejar',
                                  style: estilo(11, FontWeight.w700, corVerdeClaro,
                                      espaco: 0.44)),
                              const SizedBox(width: 4),
                              const Icon(Icons.arrow_forward,
                                  size: 16, color: corVerdeClaro),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  //anel de progresso + texto
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
                            Text('$porcentagem%',
                                style: estilo(12, FontWeight.w700, corFundo)),
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
                                  : '$refeicoesFeitasSemana de $totalRefeicoesSemana refeições',
                              style: estilo(18, FontWeight.w600, corFundo,
                                  altura: 1.3),
                            ),
                            Text(
                              semRefeicoes
                                  ? 'Monte seu planejamento para acompanhar o progresso'
                                  : 'Continue assim!',
                              style: estilo(12, FontWeight.w400, corSobreHero),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  //dias da semana
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
              style: estilo(10, FontWeight.w700,
                  ativo ? corVerdeClaro : corSobreHero),
            ),
            const SizedBox(height: 2),
            Text(
              '${dataDoDia(i).day}',
              style: estilo(12, ativo ? FontWeight.w700 : FontWeight.w600,
                  ativo ? Colors.white : corFundo),
            ),
          ],
        ),
      ),
    );
  }

  //banner de compras
  Widget _bannerCompras() {
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
              child: const Icon(Icons.shopping_basket,
                  size: 22, color: corVerdeChipTexto),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Lista da Semana',
                      overflow: TextOverflow.ellipsis,
                      style: estilo(12, FontWeight.w600, corTexto)),
                  Text('Nenhum item adicionado ainda',
                      overflow: TextOverflow.ellipsis,
                      style: estilo(12, FontWeight.w400, corTextoSuave)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () {},
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

  //refeições de hoje
  Widget _secaoRefeicoes() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Refeições de Hoje',
                  style: estilo(20, FontWeight.w600, corTexto)),
              Text(textoDiaSelecionado,
                  style: estilo(11, FontWeight.w700, corVerde, espaco: 0.44)),
            ],
          ),
          const SizedBox(height: 16),
          if (refeicoesDeHoje.isEmpty)
            _estadoVazioRefeicoes()
          else
            for (int i = 0; i < refeicoesDeHoje.length; i++) ...[
              _cardRefeicao(i),
              const SizedBox(height: 16),
            ],
        ],
      ),
    );
  }

  //mostrado enquanto o usuário ainda não planejou nada
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
            child: const Icon(Icons.restaurant_menu,
                size: 30, color: corVerdeIcone),
          ),
          const SizedBox(height: 16),
          Text('Nenhuma refeição por aqui',
              textAlign: TextAlign.center,
              style: estilo(18, FontWeight.w600, corTexto)),
          const SizedBox(height: 4),
          Text(
            'Planeje seu cardápio e as refeições do dia vão aparecer neste espaço.',
            textAlign: TextAlign.center,
            style: estilo(14, FontWeight.w400, corTextoSuave, altura: 1.4),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(999),
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: corVerde,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text('Planejar refeições',
                  style: estilo(14, FontWeight.w600, Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardRefeicao(int i) {
    final r = refeicoesDeHoje[i];
    final feita = refeicoesConcluidas.contains(i);

    return Opacity(
      opacity: feita ? 0.75 : 1,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: feita ? corCardClaro : corBranco,
          borderRadius: BorderRadius.circular(32),
          boxShadow: sombraCard,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //foto
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: 56,
                    height: 56,
                    color: corCinzaFoto,
                    child: Image.network(
                      r.imagem,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.restaurant, color: corCinzaIcone),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                //período + título
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(r.iconePeriodo, size: 16, color: r.corPeriodo),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              '${r.periodo} • ${r.hora}'.toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              style: estilo(11, FontWeight.w700, r.corPeriodo,
                                  espaco: 0.44),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(r.titulo,
                          style: estilo(18, FontWeight.w600, corTexto,
                              altura: 1.3)),
                    ],
                  ),
                ),

                //botão de marcar como consumida
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (feita) {
                        refeicoesConcluidas.remove(i);
                      } else {
                        refeicoesConcluidas.add(i);
                      }
                    });
                  },
                  icon: Icon(
                    feita ? Icons.check_circle : Icons.radio_button_unchecked,
                    size: 26,
                    color: feita ? corVerde : const Color(0xFFC1C8C1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _chip(r.iconeTag, r.textoTag, r.fundoTag, r.corTag),
                _chip(r.iconeMacro, r.textoMacro, corCardClaro, corTextoSuave),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(IconData icone, String texto, Color fundo, Color cor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: fundo,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icone, size: 14, color: cor),
          const SizedBox(width: 4),
          Text(texto, style: estilo(11, FontWeight.w700, cor)),
        ],
      ),
    );
  }

  //menu inferior
  Widget _menuInferior() {
    return Container(
      decoration: const BoxDecoration(
        color: corFundo,
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
              _itemMenu(Icons.home, 'Início', ativo: true),
              _itemMenu(Icons.menu_book, 'Receitas'),
              _itemMenu(Icons.calendar_month, 'Planejamento'),
              _itemMenu(Icons.shopping_bag, 'Compras'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemMenu(IconData icone, String nome, {bool ativo = false}) {
    final cor = ativo ? corVerde : corTextoSuave;

    return InkWell(
      onTap: () {},
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 64, minHeight: 44),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone, size: 24, color: cor),
            const SizedBox(height: 2),
            Text(nome,
                style: estilo(11, ativo ? FontWeight.w700 : FontWeight.w500, cor)),
            if (ativo)
              Container(
                margin: const EdgeInsets.only(top: 4),
                width: 20,
                height: 4,
                decoration: BoxDecoration(
                  color: corVerde,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
          ],
        ),
      ),
    );
  }
}