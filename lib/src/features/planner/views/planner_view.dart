import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//cores
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

//cores com transparência
const _corVerdeChip60 = Color(0x99C6EBD2);
const _corVerdeChip40 = Color(0x66C6EBD2);
const _corBrilho = Color(0x333E6751);
const _corBranco20 = Color(0x33FFFFFF);

//estilo de texto simples
TextStyle _estilo(double tamanho, FontWeight peso, Color cor,
    {double? altura, double? espaco}) {
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

//dados
//primeiro acesso: nada foi planejado e o usuário ainda não tem receitas
//depois o plano e as receitas virão do ViewModel (e da tela de receitas)

//troque para true só para testar como o layout fica com refeições planejadas.
bool _usarDadosDeExemplo = false;

const _diasCurto = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
const _mesesCompleto = [
  'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
  'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
];
const _mesesCurto = [
  'Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun',
  'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'
];

//metas diárias (depois virão das configurações do usuário)
const _metaKcal = 1800;
const _metaProteina = 105;
const _metaCarbo = 160;

//refeições de cada dia
class _Slot {
  final String nome;
  final String categoria; //mesmo nome usado nas receitas
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

class _Receita {
  final String titulo;
  final List<String> refeicoes;
  final String imagem;
  final int minutos;
  final int kcal;
  final int proteina;
  final int carbo;
  final int ingredientes;

  _Receita({
    required this.titulo,
    required this.refeicoes,
    required this.imagem,
    required this.minutos,
    required this.kcal,
    required this.proteina,
    required this.carbo,
    required this.ingredientes,
  });
}

//receita colocada em um dia/refeição
class _Planejada {
  final _Receita receita;
  bool preparada; //marmita/lote já preparado

  _Planejada(this.receita, {this.preparada = false});
}

//receitas que o usuário pode escolher (vazio no primeiro acesso)
final List<_Receita> _receitasDisponiveis =
    _usarDadosDeExemplo ? _receitasExemplo : <_Receita>[];

//só para testar o layout (_usarDadosDeExemplo = true)
final _receitasExemplo = [
  _Receita(
    titulo: 'Panqueca de Banana com Aveia',
    refeicoes: ['Café da manhã'],
    imagem:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCNYRSC3L7C5gTRsvt_LNHZ0x2LhAXpiTICHLwKHKOmOlhr4uMX3okVo6mEN3NiNo_vBKuK5DwfbV8Gm3xKJfEGCseVHOmfTU19Cdhm5qi41pQFt8JLxxGlsh6TvwrNV1_ooxiHlHLRg5h_sfNUPxixa55CTCADL0PaCXj3zk3mMEa_JxD0mWJbp-vbu68WX3FX8DADMKBN14FZGhDeh8R-zqQd1qyl6Za5FswYj58',
    minutos: 15,
    kcal: 280,
    proteina: 12,
    carbo: 38,
    ingredientes: 6,
  ),
  _Receita(
    titulo: 'Frango Grelhado com Legumes',
    refeicoes: ['Almoço'],
    imagem:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCYcZ_dIycOH5eVX3UmMvvnea_n4pZY5j6chnjRWz7m3VIrX-K1bky3eaLPzqHpSeUjsOrm75hXlsWrHuzjH3GHQ-UDPgAO7J0TlKU3eUx-PREXoGfNjSELibsu7Z3Zr0723HxIaqMo5Fcu3xCbHLZJKND8TQztDXD1eGLGFUuF-Al1LpyzgX1XnfQZbeKClVVy5It_s743-B4gNpIStTVITKwBoyF3aybeXXzfqXI',
    minutos: 30,
    kcal: 420,
    proteina: 38,
    carbo: 22,
    ingredientes: 8,
  ),
  _Receita(
    titulo: 'Salada Tropical Refrescante',
    refeicoes: ['Almoço', 'Jantar'],
    imagem:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDc-swFRrqEHDkCdQZX3EBgr0R8Ffgbi9LzP0q4u_rkhjGyTPkcXH_SUUjTiWRCrcZvOBvMcNQr7xZH5sNGAG3TW_sdBlHEwpgXacp7LvOHYpV15OSCQYjIexA3WVJ3cSpXNyBj7nFnJ0MBbv-P-_1XvGTCjK0Wc8AsB38s7lb3BL3DU7AYGoJytZTtZOHrKrOsrAE76Nnac3ntEB63FUKY1ytw0gi2mLj4T4nFxqM',
    minutos: 10,
    kcal: 190,
    proteina: 6,
    carbo: 30,
    ingredientes: 7,
  ),
  _Receita(
    titulo: 'Omelete de Vegetais & Queijo',
    refeicoes: ['Café da manhã', 'Jantar'],
    imagem:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAyvq_WteTd5I1_HnpK5xFEusNrODPBI7LO4b5Kz579P5ydujxLEsAKXLcWbwH4_4WELcXKQQzMwK-9OYcZPpERDKpsM3gE4gxF4thEk7hSWnW11xhZDdGX5tLPlsmxQcXdHSi2hAm3ZPFO_vXm-d3awNwtvI055wzWVGdJfj1tcHAz668odehmNJUIsMYFyr6qSm9TqTpvKhf6f109fwU1DIj9smpa1sUlTugdKV0',
    minutos: 12,
    kcal: 260,
    proteina: 18,
    carbo: 6,
    ingredientes: 6,
  ),
  _Receita(
    titulo: 'Bowl de Salmão com Edamame',
    refeicoes: ['Almoço'],
    imagem:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuB-80HztCA96B5bPHD6RTnlMSakveqjO7PyiVC6_k35GU-IhLNJq7yK7wPv-RvnX7BVSMa12H_8eEjljOqI-uQ5HOf3i7h664wlUuzU-gd1dDe2E-Ges3IZ41koGeqcDH1lWpUNDW_WcPMbsJ2e2f7lPr_ielTr6QWj9btHt0_Ft6OiIF-iihRRQ0wNWtjNRuRCGmC1reN3ql2T0Rhwr1tnUeMp6LzfwcDdig9JtiE',
    minutos: 20,
    kcal: 490,
    proteina: 34,
    carbo: 40,
    ingredientes: 7,
  ),
  _Receita(
    titulo: 'Muffin Integral de Mirtilo',
    refeicoes: ['Lanche'],
    imagem:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuD_bJwcu4UnEWMRvqeLUMaOsSq-U61Bnx_Dh6fzk089--rZ-VL2b33v5pJPIHx2ImgZHqXMOt1MEzvFRVvYwZCdfEXbv7e1uVL7GcN17-rHSeUuZnklLCYULC6Edc_ALAz_55YlfC2ive1h2xi2Cvdjoo7ZXDM0suGNJHkjVl4A7jsH_IX1I2Y24f8vKlwp0-C8SI0HGJjfukuEw-31e1poNFtu57e0kC1IfwYQfrM',
    minutos: 25,
    kcal: 180,
    proteina: 5,
    carbo: 30,
    ingredientes: 8,
  ),
];

//1.070 em vez de 1070
String _milhar(int n) {
  final texto = n.toString();
  final buffer = StringBuffer();
  for (int i = 0; i < texto.length; i++) {
    if (i > 0 && (texto.length - i) % 3 == 0) buffer.write('.');
    buffer.write(texto[i]);
  }
  return buffer.toString();
}

//tela
class PlannerView extends StatefulWidget {
  const PlannerView({super.key});

  @override
  State<PlannerView> createState() => _PlannerViewState();
}

class _PlannerViewState extends State<PlannerView> {
  final DateTime _hoje = DateTime.now();
  late final DateTime _inicioSemanaAtual =
      DateTime(_hoje.year, _hoje.month, _hoje.day - (_hoje.weekday - 1));

  int _semana = 0; //0 = semana atual, -1 = anterior, 1 = próxima...
  late int _diaSelecionado = _hoje.weekday - 1; //0 = segunda

  //plano: chave "ano-mês-dia-refeição" -> receita escolhida
  final Map<String, _Planejada> _plano = {};

  @override
  void initState() {
    super.initState();
    if (_usarDadosDeExemplo) _preencherExemplo();
  }

  //só para testar o layout
  void _preencherExemplo() {
    for (int i = 0; i < 5; i++) {
      final par = i % 2 == 0;
      _plano[_chave(_dataDoDia(i), 0)] =
          _Planejada(_receitasExemplo[par ? 0 : 3], preparada: i < 2);
      _plano[_chave(_dataDoDia(i), 1)] =
          _Planejada(_receitasExemplo[par ? 1 : 4], preparada: i < 3);
      if (i % 2 == 1) {
        _plano[_chave(_dataDoDia(i), 2)] = _Planejada(_receitasExemplo[5]);
      }
      _plano[_chave(_dataDoDia(i), 3)] = _Planejada(_receitasExemplo[2]);
    }
  }

  //datas
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

  //contagens
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

  //soma um campo das receitas do dia selecionado (kcal, proteína...)
  int _somaDoDia(int Function(_Receita) campo) {
    int total = 0;
    for (int s = 0; s < _slots.length; s++) {
      final p = _refeicao(_diaSelecionado, s);
      if (p != null) total += campo(p.receita);
    }
    return total;
  }

  //soma simples dos ingredientes da semana
  //(a consolidação de verdade, somando quantidades iguais, virá do ViewModel)
  int get _ingredientesSemana {
    int total = 0;
    for (int i = 0; i < 7; i++) {
      for (int s = 0; s < _slots.length; s++) {
        final p = _refeicao(i, s);
        if (p != null) total += p.receita.ingredientes;
      }
    }
    return total;
  }

  //ações
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

  //copia a semana anterior para os espaços vazios desta semana
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
          '$copiadas ${copiadas == 1 ? 'refeição copiada' : 'refeições copiadas'} da semana anterior.');
    }
  }

  void _gerarLista() {
    //todo: enviar os ingredientes consolidados da semana para a lista de compras (ViewModel)
    _aviso('Lista de compras gerada com $_ingredientesSemana ingredientes.');
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
      bottomNavigationBar: _menuInferior(),
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

  //topo
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

  //título
  Widget _cabecalho() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Planejamento semanal',
                    style: _estilo(22, FontWeight.w700, _corTexto, altura: 1.36)),
                const SizedBox(height: 2),
                Text('Organize suas refeições com praticidade',
                    style: _estilo(14, FontWeight.w400, _corTextoSuave,
                        altura: 1.4)),
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

  //progresso da semana
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
                Text('$porcentagem%',
                    style: _estilo(11, FontWeight.w700, _corVerde)),
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

  //navegação entre semanas
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
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: _corVerdeChip,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text('SEMANA ATUAL',
                          style: _estilo(11, FontWeight.w700, _corVerdeChipTexto,
                              espaco: 0.44)),
                    )
                  else
                    InkWell(
                      onTap: _voltarParaHoje,
                      borderRadius: BorderRadius.circular(999),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: _corCardClaro,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text('VOLTAR PARA HOJE',
                            style: _estilo(11, FontWeight.w700, _corVerde,
                                espaco: 0.44)),
                      ),
                    ),
                  const SizedBox(height: 2),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(_textoSemana,
                        maxLines: 1,
                        style: _estilo(18, FontWeight.w600, _corTexto)),
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

  //dias da semana
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
              Text('SELECIONE O DIA',
                  style: _estilo(11, FontWeight.w700, _corTextoSuave,
                      espaco: 0.44)),
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
              style: _estilo(11, FontWeight.w700,
                  ativo ? _corVerdeClaro : _corTextoSuave,
                  espaco: 0.44),
            ),
            Text(
              '${_dataDoDia(i).day}',
              style: _estilo(18, FontWeight.w600,
                  ativo ? Colors.white : _corTexto),
            ),
            if (ativo)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _corBranco20,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text('$n/${_slots.length}',
                    style: _estilo(10, FontWeight.w700, Colors.white)),
              )
            else
              _pontos(n),
          ],
        ),
      ),
    );
  }

  //bolinhas = quantidade de refeições planejadas no dia
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

  //refeições do dia
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
                    Text('Refeições do dia',
                        style: _estilo(20, FontWeight.w600, _corTexto)),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        color: _corCinzaClaro,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(_textoDiaSelecionado,
                          style: _estilo(11, FontWeight.w700, _corTexto)),
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
                    child: Text('Duplicar semana anterior',
                        style: _estilo(14, FontWeight.w400, _corTexto)),
                  ),
                  PopupMenuItem(
                    value: 'limparDia',
                    child: Text('Limpar este dia',
                        style: _estilo(14, FontWeight.w400, _corTexto)),
                  ),
                  PopupMenuItem(
                    value: 'limparSemana',
                    child: Text('Limpar a semana',
                        style: _estilo(14, FontWeight.w400, _corTexto)),
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

  //primeiro acesso: semana em branco
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
            child: const Icon(Icons.calendar_month,
                size: 30, color: _corVerdeIcone),
          ),
          const SizedBox(height: 16),
          Text('Sua semana está em branco',
              textAlign: TextAlign.center,
              style: _estilo(18, FontWeight.w600, _corTexto)),
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
              child: Text('Planejar primeira refeição',
                  style: _estilo(14, FontWeight.w600, Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  //refeição já planejada
  Widget _cardRefeicao(int s, _Planejada p) {
    final slot = _slots[s];
    final r = p.receita;

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
                        style: _estilo(11, FontWeight.w700, _corTextoSuave,
                            espaco: 0.44),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () => _abrirEscolha(s),
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _corCinzaFoto,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.swap_horiz,
                          size: 15, color: _corTexto),
                      const SizedBox(width: 4),
                      Text('Trocar',
                          style: _estilo(11, FontWeight.w700, _corTexto)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 4),
              InkWell(
                onTap: () => setState(
                    () => _plano.remove(_chave(_dataDoDia(_diaSelecionado), s))),
                borderRadius: BorderRadius.circular(999),
                child: const SizedBox(
                  width: 28,
                  height: 28,
                  child: Icon(Icons.close, size: 16, color: _corCinzaIcone),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 80,
                  height: 80,
                  color: _corCinzaFoto,
                  child: Image.network(
                    r.imagem,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.restaurant, color: _corCinzaIcone),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      r.titulo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: _estilo(18, FontWeight.w600, _corTexto,
                          altura: 1.3),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.schedule,
                            size: 14, color: _corTextoSuave),
                        const SizedBox(width: 4),
                        Text('${r.minutos} min',
                            style: _estilo(12, FontWeight.w600, _corTextoSuave)),
                        const SizedBox(width: 6),
                        Text('•',
                            style: _estilo(12, FontWeight.w600, _corCinzaIcone)),
                        const SizedBox(width: 6),
                        Text('${r.kcal} kcal',
                            style: _estilo(12, FontWeight.w600, _corTextoSuave)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //toque para marcar como preparada (marmita pronta)
              GestureDetector(
                onTap: () => setState(() => p.preparada = !p.preparada),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: p.preparada ? _corVerdeChip : _corCardClaro,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        p.preparada ? Icons.check_circle : Icons.schedule,
                        size: 14,
                        color: p.preparada
                            ? _corVerdeChipTexto
                            : _corTextoSuave,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        p.preparada ? 'Pronto na geladeira' : 'A preparar',
                        style: _estilo(
                            11,
                            FontWeight.w700,
                            p.preparada
                                ? _corVerdeChipTexto
                                : _corTextoSuave),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _corLaranjaClaro,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text('${r.proteina}g proteína',
                    style: _estilo(10, FontWeight.w700, _corMarromEscuro)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //refeição ainda não planejada
  Widget _cardVazio(int s) {
    final slot = _slots[s];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _corVerdeChip40,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(slot.icone, size: 18, color: _corVerdeSecundario),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        '${slot.nome} • ${slot.hora}'.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        style: _estilo(11, FontWeight.w700, _corVerdeSecundario,
                            espaco: 0.44),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text('Pendente',
                  style: _estilo(11, FontWeight.w700, _corTextoSuave)),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: _corBranco,
              shape: BoxShape.circle,
              boxShadow: _sombraLeve,
            ),
            child: Icon(slot.icone, size: 24, color: _corVerdeSecundario),
          ),
          const SizedBox(height: 8),
          Text('${slot.nome} não planejado',
              textAlign: TextAlign.center,
              style: _estilo(18, FontWeight.w600, _corTexto)),
          const SizedBox(height: 2),
          Text(
            'Escolha uma receita para esta refeição e mantenha o ritmo e a energia do seu dia.',
            textAlign: TextAlign.center,
            style: _estilo(12, FontWeight.w400, _corTextoSuave, altura: 1.5),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () => _abrirEscolha(s),
            borderRadius: BorderRadius.circular(999),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _corBranco,
                borderRadius: BorderRadius.circular(999),
                boxShadow: _sombraLeve,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add, size: 18, color: _corVerde),
                  const SizedBox(width: 6),
                  Text('Escolher receita',
                      style: _estilo(14, FontWeight.w600, _corVerde)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //resumo nutricional do dia
  Widget _resumoNutricional() {
    final kcal = _somaDoDia((r) => r.kcal);
    final proteina = _somaDoDia((r) => r.proteina);
    final carbo = _somaDoDia((r) => r.carbo);
    final faltam = _metaKcal - kcal;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _corCardClaro,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      const Icon(Icons.query_stats,
                          size: 18, color: _corVerde),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text('Resumo nutricional do dia',
                            overflow: TextOverflow.ellipsis,
                            style: _estilo(14, FontWeight.w600, _corTexto)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text('Meta: ${_milhar(_metaKcal)} kcal',
                    style: _estilo(11, FontWeight.w700, _corTextoSuave)),
              ],
            ),
            const SizedBox(height: 12),
            //IntrinsicHeight: o Row com stretch precisa dele dentro do ListView
            //(altura ilimitada), senão dá "BoxConstraints forces an infinite height"
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _caixaNutriente(
                    'Calorias',
                    _milhar(kcal),
                    faltam > 0
                        ? 'Faltam ${_milhar(faltam)} kcal'
                        : 'Meta atingida',
                    _corVerde,
                  ),
                  const SizedBox(width: 8),
                  _caixaNutriente('Proteínas', '${proteina}g',
                      'Meta ${_metaProteina}g', _corMarrom),
                  const SizedBox(width: 8),
                  _caixaNutriente('Carboidratos', '${carbo}g',
                      'Meta ${_metaCarbo}g', _corVerdeSecundario),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _caixaNutriente(String titulo, String valor, String sub, Color corSub) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _corBranco,
          borderRadius: BorderRadius.circular(16),
          boxShadow: _sombraLeve,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titulo,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: _estilo(11, FontWeight.w700, _corTextoSuave)),
            const SizedBox(height: 2),
            Text(valor, style: _estilo(18, FontWeight.w600, _corTexto)),
            Text(sub, style: _estilo(11, FontWeight.w400, corSub, altura: 1.3)),
          ],
        ),
      ),
    );
  }

  //gerar lista de compras
  Widget _botaoGerarLista() {
    final n = _ingredientesSemana;
    final ativo = n > 0;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: InkWell(
        onTap: ativo ? _gerarLista : null,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: ativo ? _corVerde : _corCinzaClaro,
            borderRadius: BorderRadius.circular(999),
            boxShadow: ativo
                ? const [
                    BoxShadow(
                      color: Color(0x401B2B20),
                      blurRadius: 20,
                      offset: Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    Icon(Icons.shopping_bag,
                        size: 22, color: ativo ? Colors.white : _corCinzaIcone),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Gerar lista de compras',
                        overflow: TextOverflow.ellipsis,
                        style: _estilo(14, FontWeight.w600,
                            ativo ? Colors.white : _corCinzaIcone),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: ativo ? _corBranco20 : _corCardClaro,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  ativo
                      ? '$n ${n == 1 ? 'ingrediente' : 'ingredientes'}'
                      : 'Planeje primeiro',
                  style: _estilo(11, FontWeight.w700,
                      ativo ? Colors.white : _corCinzaIcone),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //folha para escolher a receita de uma refeição
  void _abrirEscolha(int s) {
    final slot = _slots[s];
    final dia = _dataDoDia(_diaSelecionado); //dia fixo enquanto a folha está aberta
    bool verTodas = false;

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
            final lista = _receitasDisponiveis
                .where((r) => verTodas || r.refeicoes.contains(slot.categoria))
                .toList();

            return SafeArea(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.75,
                ),
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
                      Text('Escolher receita',
                          style: _estilo(20, FontWeight.w600, _corTexto)),
                      const SizedBox(height: 2),
                      Text(
                        '${slot.nome} • ${_diasCurto[dia.weekday - 1]}, ${dia.day} de ${_mesesCompleto[dia.month - 1]}',
                        style: _estilo(12, FontWeight.w400, _corTextoSuave),
                      ),
                      const SizedBox(height: 16),
                      if (_receitasDisponiveis.isEmpty)
                        _sheetSemReceitas(sheetContext)
                      else ...[
                        Row(
                          children: [
                            _opcaoFiltro('Para ${slot.nome}', !verTodas,
                                () => setSheet(() => verTodas = false)),
                            const SizedBox(width: 8),
                            _opcaoFiltro('Todas', verTodas,
                                () => setSheet(() => verTodas = true)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (lista.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: Center(
                              child: Text(
                                'Nenhuma receita cadastrada para ${slot.nome.toLowerCase()}. Toque em "Todas" para ver as outras.',
                                textAlign: TextAlign.center,
                                style: _estilo(
                                    14, FontWeight.w400, _corTextoSuave,
                                    altura: 1.4),
                              ),
                            ),
                          )
                        else
                          Flexible(
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: lista.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 10),
                              itemBuilder: (_, i) =>
                                  _itemReceita(lista[i], () {
                                setState(() => _plano[_chave(dia, s)] =
                                    _Planejada(lista[i]));
                                Navigator.pop(sheetContext);
                              }),
                            ),
                          ),
                      ],
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

  //usuário ainda não tem nenhuma receita
  Widget _sheetSemReceitas(BuildContext sheetContext) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(
            color: _corVerdeChip60,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.menu_book, size: 30, color: _corVerdeIcone),
        ),
        const SizedBox(height: 16),
        Text('Você ainda não tem receitas',
            textAlign: TextAlign.center,
            style: _estilo(18, FontWeight.w600, _corTexto)),
        const SizedBox(height: 4),
        Text(
          'Busque receitas ou cadastre as suas para poder montar o cardápio da semana.',
          textAlign: TextAlign.center,
          style: _estilo(14, FontWeight.w400, _corTextoSuave, altura: 1.4),
        ),
        const SizedBox(height: 20),
        InkWell(
          //TODO: navegar para a tela de receitas
          onTap: () => Navigator.pop(sheetContext),
          borderRadius: BorderRadius.circular(999),
          child: Container(
            height: 48,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _corVerde,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text('Buscar receitas',
                style: _estilo(14, FontWeight.w600, Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget _itemReceita(_Receita r, VoidCallback aoTocar) {
    return InkWell(
      onTap: aoTocar,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _corBranco,
          borderRadius: BorderRadius.circular(24),
          boxShadow: _sombraCard,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 56,
                height: 56,
                color: _corCinzaFoto,
                child: Image.network(
                  r.imagem,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.restaurant, color: _corCinzaIcone),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    r.refeicoes.join(' / '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _estilo(11, FontWeight.w700, _corVerde),
                  ),
                  Text(
                    r.titulo,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: _estilo(14, FontWeight.w600, _corTexto, altura: 1.3),
                  ),
                  const SizedBox(height: 2),
                  Text('${r.minutos} min • ${r.kcal} kcal',
                      style: _estilo(11, FontWeight.w700, _corTextoSuave)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.add_circle_outline, size: 24, color: _corVerde),
          ],
        ),
      ),
    );
  }

  Widget _opcaoFiltro(String texto, bool ativo, VoidCallback aoTocar) {
    return GestureDetector(
      onTap: aoTocar,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: ativo ? _corVerde : _corBranco,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          texto,
          style: _estilo(
              12, FontWeight.w600, ativo ? Colors.white : _corTextoSuave),
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
              _itemMenu(Icons.calendar_month, 'Planejamento', ativo: true),
              _itemMenu(Icons.shopping_bag, 'Compras'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemMenu(IconData icone, String nome, {bool ativo = false}) {
    final cor = ativo ? _corVerde : _corTextoSuave;

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