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
const _corVerdeChip = Color(0xFFC6EBD2);
const _corVerdeChipTexto = Color(0xFF002112);
const _corVerdeIcone = Color(0xFF4B6C57);

const _corMarrom = Color(0xFF85532E);
const _corMarromTexto = Color(0xFF522907);
const _corLaranja = Color(0xFFCC8F65);
const _corLaranjaClaro = Color(0xFFFFDCC6);
const _corErro = Color(0xFFBA1A1A);

//cores com transparência
const _corVerdeChip60 = Color(0x99C6EBD2);
const _corBrilho = Color(0x333E6751);
const _corBranco90 = Color(0xE6FFFFFF);

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

//dados
//primeiro acesso: o usuário ainda não tem receitas
//depois a lista virá do ViewModel / API

//troque para true só para testar como o layout fica com receitas.
bool _usarDadosDeExemplo = false;

const _categorias = ['Todas', 'Café da manhã', 'Almoço', 'Lanche', 'Jantar'];

const _restricoes = ['Vegetariana', 'Sem lactose', 'Sem glúten', 'Low carb'];
const _iconesRestricoes = [Icons.spa, Icons.check, Icons.grain, Icons.bolt];

const _opcoesOrdem = ['Relevância', 'Menor tempo', 'Menos calorias'];
const _opcoesTempo = [null, 15, 30, 45, 60]; // null = qualquer
const _opcoesDificuldade = [null, 'Fácil', 'Médio', 'Difícil'];

class _Receita {
  final String titulo;
  final List<String> refeicoes;
  final String imagem;
  final String dificuldade;
  final int minutos;
  final int kcal;
  final List<String> restricoes;

  _Receita({
    required this.titulo,
    required this.refeicoes,
    required this.imagem,
    required this.dificuldade,
    required this.minutos,
    required this.kcal,
    required this.restricoes,
  });
}

//receitas cadastradas / salvas (vazio no primeiro acesso)
final List<_Receita> _receitas =
    _usarDadosDeExemplo ? _receitasExemplo : <_Receita>[];

//só para testar o layout (_usarDadosDeExemplo = true)
final _receitasExemplo = [
  _Receita(
    titulo: 'Panqueca de Banana com Aveia',
    refeicoes: ['Café da manhã'],
    imagem:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCNYRSC3L7C5gTRsvt_LNHZ0x2LhAXpiTICHLwKHKOmOlhr4uMX3okVo6mEN3NiNo_vBKuK5DwfbV8Gm3xKJfEGCseVHOmfTU19Cdhm5qi41pQFt8JLxxGlsh6TvwrNV1_ooxiHlHLRg5h_sfNUPxixa55CTCADL0PaCXj3zk3mMEa_JxD0mWJbp-vbu68WX3FX8DADMKBN14FZGhDeh8R-zqQd1qyl6Za5FswYj58',
    dificuldade: 'Fácil',
    minutos: 15,
    kcal: 280,
    restricoes: ['Vegetariana'],
  ),
  _Receita(
    titulo: 'Frango Grelhado com Legumes',
    refeicoes: ['Almoço'],
    imagem:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCYcZ_dIycOH5eVX3UmMvvnea_n4pZY5j6chnjRWz7m3VIrX-K1bky3eaLPzqHpSeUjsOrm75hXlsWrHuzjH3GHQ-UDPgAO7J0TlKU3eUx-PREXoGfNjSELibsu7Z3Zr0723HxIaqMo5Fcu3xCbHLZJKND8TQztDXD1eGLGFUuF-Al1LpyzgX1XnfQZbeKClVVy5It_s743-B4gNpIStTVITKwBoyF3aybeXXzfqXI',
    dificuldade: 'Médio',
    minutos: 30,
    kcal: 420,
    restricoes: ['Sem glúten', 'Low carb'],
  ),
  _Receita(
    titulo: 'Salada Tropical Refrescante',
    refeicoes: ['Almoço', 'Jantar'],
    imagem:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDc-swFRrqEHDkCdQZX3EBgr0R8Ffgbi9LzP0q4u_rkhjGyTPkcXH_SUUjTiWRCrcZvOBvMcNQr7xZH5sNGAG3TW_sdBlHEwpgXacp7LvOHYpV15OSCQYjIexA3WVJ3cSpXNyBj7nFnJ0MBbv-P-_1XvGTCjK0Wc8AsB38s7lb3BL3DU7AYGoJytZTtZOHrKrOsrAE76Nnac3ntEB63FUKY1ytw0gi2mLj4T4nFxqM',
    dificuldade: 'Fácil',
    minutos: 10,
    kcal: 190,
    restricoes: ['Vegetariana', 'Sem lactose', 'Sem glúten'],
  ),
  _Receita(
    titulo: 'Omelete de Vegetais & Queijo',
    refeicoes: ['Café da manhã', 'Jantar'],
    imagem:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAyvq_WteTd5I1_HnpK5xFEusNrODPBI7LO4b5Kz579P5ydujxLEsAKXLcWbwH4_4WELcXKQQzMwK-9OYcZPpERDKpsM3gE4gxF4thEk7hSWnW11xhZDdGX5tLPlsmxQcXdHSi2hAm3ZPFO_vXm-d3awNwtvI055wzWVGdJfj1tcHAz668odehmNJUIsMYFyr6qSm9TqTpvKhf6f109fwU1DIj9smpa1sUlTugdKV0',
    dificuldade: 'Fácil',
    minutos: 12,
    kcal: 260,
    restricoes: ['Vegetariana', 'Sem glúten', 'Low carb'],
  ),
  _Receita(
    titulo: 'Bowl de Salmão com Edamame',
    refeicoes: ['Almoço'],
    imagem:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuB-80HztCA96B5bPHD6RTnlMSakveqjO7PyiVC6_k35GU-IhLNJq7yK7wPv-RvnX7BVSMa12H_8eEjljOqI-uQ5HOf3i7h664wlUuzU-gd1dDe2E-Ges3IZ41koGeqcDH1lWpUNDW_WcPMbsJ2e2f7lPr_ielTr6QWj9btHt0_Ft6OiIF-iihRRQ0wNWtjNRuRCGmC1reN3ql2T0Rhwr1tnUeMp6LzfwcDdig9JtiE',
    dificuldade: 'Médio',
    minutos: 20,
    kcal: 490,
    restricoes: ['Sem lactose', 'Sem glúten'],
  ),
  _Receita(
    titulo: 'Muffin Integral de Mirtilo',
    refeicoes: ['Lanche'],
    imagem:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuD_bJwcu4UnEWMRvqeLUMaOsSq-U61Bnx_Dh6fzk089--rZ-VL2b33v5pJPIHx2ImgZHqXMOt1MEzvFRVvYwZCdfEXbv7e1uVL7GcN17-rHSeUuZnklLCYULC6Edc_ALAz_55YlfC2ive1h2xi2Cvdjoo7ZXDM0suGNJHkjVl4A7jsH_IX1I2Y24f8vKlwp0-C8SI0HGJjfukuEw-31e1poNFtu57e0kC1IfwYQfrM',
    dificuldade: 'Fácil',
    minutos: 25,
    kcal: 180,
    restricoes: ['Vegetariana'],
  ),
];

//tela
class RecipesView extends StatefulWidget {
  const RecipesView({super.key});

  @override
  State<RecipesView> createState() => _RecipesViewState();
}

class _RecipesViewState extends State<RecipesView> {
  final TextEditingController _busca = TextEditingController();

  int _categoria = 0; //índice em _categorias
  final Set<String> _restricoesAtivas = {};
  int? _tempoMax; //null = qualquer
  String? _dificuldade; //null = qualquer
  String _ordem = 'Relevância';
  final Set<String> _favoritas = {};

  @override
  void dispose() {
    _busca.dispose();
    super.dispose();
  }

  //aplica busca, filtros e ordenação na lista de receitas
  List<_Receita> get _filtradas {
    final texto = _busca.text.trim().toLowerCase();

    final lista = _receitas.where((r) {
      if (_categoria != 0 && !r.refeicoes.contains(_categorias[_categoria])) {
        return false;
      }
      if (texto.isNotEmpty && !r.titulo.toLowerCase().contains(texto)) {
        return false;
      }
      for (final restricao in _restricoesAtivas) {
        if (!r.restricoes.contains(restricao)) return false;
      }
      if (_tempoMax != null && r.minutos > _tempoMax!) return false;
      if (_dificuldade != null && r.dificuldade != _dificuldade) return false;
      return true;
    }).toList();

    if (_ordem == 'Menor tempo') {
      lista.sort((a, b) => a.minutos.compareTo(b.minutos));
    } else if (_ordem == 'Menos calorias') {
      lista.sort((a, b) => a.kcal.compareTo(b.kcal));
    }
    return lista;
  }

  void _limparFiltros() {
    setState(() {
      _busca.clear();
      _categoria = 0;
      _restricoesAtivas.clear();
      _tempoMax = null;
      _dificuldade = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtradas = _filtradas;

    return Scaffold(
      backgroundColor: _corFundo,
      appBar: _appBar(),
      bottomNavigationBar: _menuInferior(),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          _titulo(),
          _campoBusca(),
          _linhaCategorias(),
          _linhaRestricoes(),
          if (_receitas.isEmpty)
            _estadoVazioGeral()
          else ...[
            _cabecalhoLista(filtradas.length),
            if (filtradas.isEmpty)
              _estadoVazioFiltros()
            else
              _grade(filtradas),
          ],
          _dica(),
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
                Text('Receitas',
                    style: _estilo(22, FontWeight.w700, _corTexto, altura: 1.36)),
                const SizedBox(height: 2),
                Text('Encontre inspiração para suas refeições',
                    style: _estilo(12, FontWeight.w400, _corTextoSuave,
                        altura: 1.5)),
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
            child: const Icon(Icons.eco, size: 20, color: _corVerdeChipTexto),
          ),
        ],
      ),
    );
  }

  //busca + filtros
  Widget _campoBusca() {
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
                onChanged: (_) => setState(() {}),
                style: _estilo(14, FontWeight.w400, _corTexto),
                decoration: InputDecoration(
                  hintText: 'Buscar receitas...',
                  hintStyle: _estilo(14, FontWeight.w400, _corCinzaIcone),
                  prefixIcon: const Icon(Icons.search,
                      size: 20, color: _corCinzaIcone),
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
                  // bolinha quando há filtro avançado ativo
                  if (_tempoMax != null || _dificuldade != null)
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

  //pílulas: todas / café da manhã / almoço / lanche / jantar
  Widget _linhaCategorias() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            for (int i = 0; i < _categorias.length; i++) ...[
              GestureDetector(
                onTap: () => setState(() => _categoria = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: i == _categoria ? _corVerde : _corBranco,
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
                    _categorias[i],
                    style: _estilo(12, FontWeight.w600,
                        i == _categoria ? Colors.white : _corTextoSuave,
                        espaco: 0.24),
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

  //restrições alimentares: vegetariana / sem lactose / sem glúten / low carb
  Widget _linhaRestricoes() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            for (int i = 0; i < _restricoes.length; i++) ...[
              _chipRestricao(i),
              const SizedBox(width: 6),
            ],
          ],
        ),
      ),
    );
  }

  Widget _chipRestricao(int i) {
    final nome = _restricoes[i];
    final ativo = _restricoesAtivas.contains(nome);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (ativo) {
            _restricoesAtivas.remove(nome);
          } else {
            _restricoesAtivas.add(nome);
          }
        });
      },
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
            Icon(_iconesRestricoes[i],
                size: 15, color: ativo ? _corVerdeChipTexto : _corTextoSuave),
            const SizedBox(width: 6),
            Text(
              nome,
              style: _estilo(11, FontWeight.w700,
                  ativo ? _corVerdeChipTexto : _corTextoSuave,
                  espaco: 0.44),
            ),
          ],
        ),
      ),
    );
  }

  //cabeçalho da lista
  Widget _cabecalhoLista(int quantidade) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text('Sugestões da semana',
                  style: _estilo(18, FontWeight.w700, _corTexto)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _corCinzaClaro,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text('$quantidade',
                    style: _estilo(11, FontWeight.w700, _corTextoSuave)),
              ),
            ],
          ),
          PopupMenuButton<String>(
            onSelected: (valor) => setState(() => _ordem = valor),
            color: _corBranco,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            itemBuilder: (_) => [
              for (final op in _opcoesOrdem)
                PopupMenuItem(
                  value: op,
                  child: Text(op,
                      style: _estilo(
                          14,
                          op == _ordem ? FontWeight.w700 : FontWeight.w400,
                          op == _ordem ? _corVerde : _corTexto)),
                ),
            ],
            child: Row(
              children: [
                Text(_ordem, style: _estilo(12, FontWeight.w600, _corVerde)),
                const SizedBox(width: 4),
                const Icon(Icons.swap_vert, size: 18, color: _corVerde),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //grade de receitas
  Widget _grade(List<_Receita> lista) {
    final linhas = <Widget>[];

    for (int i = 0; i < lista.length; i += 2) {
      final segundo = i + 1 < lista.length
          ? _cardReceita(lista[i + 1])
          : const SizedBox();

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

  Widget _cardReceita(_Receita r) {
    final favorita = _favoritas.contains(r.titulo);

    Color corDificuldade = _corVerde;
    if (r.dificuldade == 'Médio') corDificuldade = _corMarrom;
    if (r.dificuldade == 'Difícil') corDificuldade = _corErro;

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: const BoxDecoration(
          color: _corBranco,
          boxShadow: _sombraCard,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //foto + favorito + dificuldade
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    color: _corCinzaFoto,
                    child: Image.network(
                      r.imagem,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.restaurant,
                        color: _corCinzaIcone,
                        size: 32,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (favorita) {
                            _favoritas.remove(r.titulo);
                          } else {
                            _favoritas.add(r.titulo);
                          }
                        });
                      },
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
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: _corBranco90,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(r.dificuldade,
                          style: _estilo(11, FontWeight.w700, corDificuldade)),
                    ),
                  ),
                ],
              ),
            ),

            //textos
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
                          r.refeicoes.join(' / '),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: _estilo(11, FontWeight.w700, _corVerde),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          r.titulo,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: _estilo(14, FontWeight.w600, _corTexto,
                              altura: 1.4),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.schedule,
                                size: 14, color: _corTextoSuave),
                            const SizedBox(width: 4),
                            Text('${r.minutos} min',
                                style: _estilo(
                                    11, FontWeight.w700, _corTextoSuave)),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _corVerdeChip60,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text('${r.kcal} kcal',
                              style: _estilo(
                                  10, FontWeight.w700, _corVerdeChipTexto)),
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
    );
  }

  //estados vazios

  //primeiro acesso: ainda não há nenhuma receita
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
              child:
                  const Icon(Icons.menu_book, size: 30, color: _corVerdeIcone),
            ),
            const SizedBox(height: 16),
            Text('Nenhuma receita por aqui',
                textAlign: TextAlign.center,
                style: _estilo(18, FontWeight.w600, _corTexto)),
            const SizedBox(height: 4),
            Text(
              'Busque receitas para planejar suas refeições ou cadastre as suas, com foto, tempo de preparo e porções.',
              textAlign: TextAlign.center,
              style: _estilo(14, FontWeight.w400, _corTextoSuave, altura: 1.4),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
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
                child: Text('Criar minha receita',
                    style: _estilo(14, FontWeight.w600, _corVerde)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //há receitas, mas os filtros não encontraram nenhuma
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
            Text('Nenhuma receita encontrada',
                textAlign: TextAlign.center,
                style: _estilo(18, FontWeight.w600, _corTexto)),
            const SizedBox(height: 4),
            Text('Tente mudar a busca ou remover alguns filtros.',
                textAlign: TextAlign.center,
                style: _estilo(14, FontWeight.w400, _corTextoSuave, altura: 1.4)),
            const SizedBox(height: 16),
            InkWell(
              onTap: _limparFiltros,
              borderRadius: BorderRadius.circular(999),
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _corVerde,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text('Limpar filtros',
                    style: _estilo(14, FontWeight.w600, Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //dica de preparo
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
              child: const Icon(Icons.lightbulb_outline,
                  size: 20, color: _corMarromTexto),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dica de preparo eficiente',
                      style: _estilo(14, FontWeight.w700, _corTexto)),
                  const SizedBox(height: 4),
                  Text(
                    'Cozinhe os legumes e o frango juntos na mesma assadeira com azeite e ervas para economizar até 25 minutos de limpeza!',
                    style: _estilo(12, FontWeight.w400, _corTextoSuave,
                        altura: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //folha de filtros (botão "tune")
  void _abrirFiltros() {
    showModalBottomSheet(
      context: context,
      backgroundColor: _corFundo,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheet) {
            return SafeArea(
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
                    Text('Filtros',
                        style: _estilo(20, FontWeight.w600, _corTexto)),
                    const SizedBox(height: 20),

                    Text('TEMPO MÁXIMO DE PREPARO',
                        style: _estilo(11, FontWeight.w700, _corTextoSuave,
                            espaco: 0.44)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final t in _opcoesTempo)
                          _opcaoFiltro(
                            t == null ? 'Qualquer' : 'Até $t min',
                            _tempoMax == t,
                            () {
                              setState(() => _tempoMax = t);
                              setSheet(() {});
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Text('DIFICULDADE',
                        style: _estilo(11, FontWeight.w700, _corTextoSuave,
                            espaco: 0.44)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final d in _opcoesDificuldade)
                          _opcaoFiltro(
                            d ?? 'Qualquer',
                            _dificuldade == d,
                            () {
                              setState(() => _dificuldade = d);
                              setSheet(() {});
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _tempoMax = null;
                                _dificuldade = null;
                              });
                              setSheet(() {});
                            },
                            borderRadius: BorderRadius.circular(999),
                            child: Container(
                              height: 48,
                              alignment: Alignment.center,
                              child: Text('Limpar',
                                  style: _estilo(
                                      14, FontWeight.w600, _corTextoSuave)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: () => Navigator.pop(sheetContext),
                            borderRadius: BorderRadius.circular(999),
                            child: Container(
                              height: 48,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: _corVerde,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text('Aplicar',
                                  style: _estilo(
                                      14, FontWeight.w600, Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
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
          style: _estilo(12, FontWeight.w600,
              ativo ? Colors.white : _corTextoSuave),
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
              _itemMenu(Icons.menu_book, 'Receitas', ativo: true),
              _itemMenu(Icons.calendar_month, 'Planejamento'),
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