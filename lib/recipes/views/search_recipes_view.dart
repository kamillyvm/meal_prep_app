import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//cores (privadas: valem só neste arquivo)
const _corFundo = Color(0xFFFBF9F4);
const _corBranco = Color(0xFFFFFFFF);
const _corCardClaro = Color(0xFFF5F3EE);
const _corCinzaMedio = Color(0xFFF0EEE9);
const _corCinzaClaro = Color(0xFFEAE8E3);
const _corCinzaIcone = Color(0xFF717973);
const _corTexto = Color(0xFF1B1C19);
const _corTextoSuave = Color(0xFF414943);

const _corVerde = Color(0xFF3E6751);
const _corVerdeClaro = Color(0xFFC0EDD1);
const _corVerdeClaroTexto = Color(0xFF264F3A);
const _corVerdeChip = Color(0xFFC6EBD2);
const _corVerdeChipTexto = Color(0xFF002112);

const _corMarrom = Color(0xFF85532E);
const _corLaranjaClaro = Color(0xFFFFDCC6);
const _corLaranjaEscuro = Color(0xFF301400);
const _corErro = Color(0xFFBA1A1A);

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

const _sombraBusca = [
  BoxShadow(
    color: Color(0x0F1B2B20),
    blurRadius: 16,
    spreadRadius: -2,
    offset: Offset(0, 4),
  ),
];

const _sombraChip = [
  BoxShadow(
    color: Color(0x0D1B2B20),
    blurRadius: 8,
    spreadRadius: -2,
    offset: Offset(0, 2),
  ),
];

//dados
//primeiro acesso: ainda não há buscas recentes e nenhum catálogo conectado
//depois os resultados virão da API (TheMealDB) pelo ViewModel

//troque para true só para testar como o layout fica com resultados.
bool _usarDadosDeExemplo = false;

const _categorias = ['Todas', 'Café da manhã', 'Almoço', 'Lanche', 'Jantar'];

const _restricoes = ['Vegetariana', 'Sem lactose', 'Sem glúten', 'Low carb'];
const _iconesRestricoes = [
  Icons.eco,
  Icons.water_drop,
  Icons.grain,
  Icons.bolt,
];

//sugestões fixas de busca
const _sugestoes = ['Frango', 'Salada', 'Omelete', 'Sopa', 'Panqueca', 'Bowl'];

class _ReceitaBusca {
  final String titulo;
  final String refeicao;
  final String imagem;
  final int minutos;
  final int kcal;
  final String dificuldade;
  final List<String> restricoes;

  _ReceitaBusca({
    required this.titulo,
    required this.refeicao,
    required this.imagem,
    required this.minutos,
    required this.kcal,
    required this.dificuldade,
    required this.restricoes,
  });
}

//resultados disponíveis (vazio enquanto não há API conectada)
final List<_ReceitaBusca> _catalogo =
_usarDadosDeExemplo ? _catalogoExemplo : <_ReceitaBusca>[];

//só para testar o layout (_usarDadosDeExemplo = true)
final _catalogoExemplo = [
  _ReceitaBusca(
    titulo: 'Frango Grelhado com Legumes',
    refeicao: 'Almoço',
    imagem:
    'https://lh3.googleusercontent.com/aida-public/AB6AXuDUP6BvKCaefliC_pstTET9wDxyW1aAekqW0lvuDXVzM8P8A8yxogz1xkKd4lzXO-dUXgA5Y7FMudAwmVCMN57KRXVcklkWIyWXQdm4dhFrWCL6jdJVH1iGg3dhhA0r1xDssG4VQaaoJtl2r2X3CKrnIPJtLLGZeHPDtngY90CBuTMXEq4UG6UmsASJAVjITtnGxwUvcu170115TDfZ14pVADPKWOznSsro4N8rzjE',
    minutos: 30,
    kcal: 420,
    dificuldade: 'Fácil',
    restricoes: ['Sem glúten', 'Low carb'],
  ),
  _ReceitaBusca(
    titulo: 'Salmão Assado com Quinoa',
    refeicao: 'Jantar',
    imagem:
    'https://lh3.googleusercontent.com/aida-public/AB6AXuCDcwVh2oMribb04A4yTmkwt2sUwjTZSA1hR36a7AErf90lSrZ9xORrFyUlUGwLv_1koRlcDFURlrLYXuBPrArczrPWXMziLtNnFfhVJSibRQF07oAS6UdyeOlP22FuBssYgB875O_SfuEPUYoa1L20w0gaS1kotxFnRZZsYBP0umqeb7CAfBdC97Cd8GLt3aRUzu9cfPPgxBvwRwqlAClUt6LSl_Mm4kzEDbtM2hk',
    minutos: 25,
    kcal: 380,
    dificuldade: 'Médio',
    restricoes: ['Sem lactose', 'Sem glúten', 'Low carb'],
  ),
  _ReceitaBusca(
    titulo: 'Panqueca de Banana e Aveia',
    refeicao: 'Café da manhã',
    imagem:
    'https://lh3.googleusercontent.com/aida-public/AB6AXuD2EwJdo4oowVKnanbEKv21c9mKkUJ1dbJblCPfIRjcw37-QvuTMW-JB1lfV1CV4bhCa325Ep4GlRjV9vbl2L1s5UrZgONT6m95e-emk65j545vkXv9_Xx3UzVVuO3PJ6x1hNL-CdX3CZf8BXDlL1-2GUJC6CVT2Ycqh6cbYGHyQF37P-pwylJTt06dUkZnwnwYzwMGMBR35cp9wz_6Mn4jfzqrg-r8bOtxVJycy2A',
    minutos: 15,
    kcal: 250,
    dificuldade: 'Fácil',
    restricoes: ['Vegetariana'],
  ),
  _ReceitaBusca(
    titulo: 'Wrap Mediterrâneo de Homus',
    refeicao: 'Lanche',
    imagem:
    'https://lh3.googleusercontent.com/aida-public/AB6AXuBdszI6Pr1nEZ16X-2IduNVURFLJ9sE-iG7NBExQFzh9Y1j9JX-k-xTAKPxtFA6RdaZlvemCiIzv-IpoBXzGkrS1Ib7Go_iQmuTXlm20wMRFZYy6bhsmuht49tYyxbL61uGZLaJMTVVTvwPocPCWgfns4eQOg0VwwUVePt-WA4-vUCe1_FGIHeYiieLe0SMLucjoEixzF8sFUGMRYmCxYI09X9TwRtjQEBfr2JgwaQ',
    minutos: 10,
    kcal: 290,
    dificuldade: 'Fácil',
    restricoes: ['Vegetariana', 'Sem lactose'],
  ),
];

//tela
class SearchRecipesView extends StatefulWidget {
  const SearchRecipesView({super.key});

  @override
  State<SearchRecipesView> createState() => _SearchRecipesViewState();
}

class _SearchRecipesViewState extends State<SearchRecipesView> {
  final TextEditingController _busca = TextEditingController();

  int _categoria = 0;
  final Set<String> _restricoesAtivas = {};
  final List<String> _recentes = []; //começa vazio
  final Set<String> _favoritas = {};

  @override
  void dispose() {
    _busca.dispose();
    super.dispose();
  }

  String get _texto => _busca.text.trim();

  bool get _buscando =>
      _texto.isNotEmpty || _categoria != 0 || _restricoesAtivas.isNotEmpty;

  //aplica busca e filtros no catálogo
  List<_ReceitaBusca> get _resultados {
    final texto = _texto.toLowerCase();

    return _catalogo.where((r) {
      if (_categoria != 0 && r.refeicao != _categorias[_categoria]) {
        return false;
      }
      if (texto.isNotEmpty && !r.titulo.toLowerCase().contains(texto)) {
        return false;
      }
      for (final restricao in _restricoesAtivas) {
        if (!r.restricoes.contains(restricao)) return false;
      }
      return true;
    }).toList();
  }

  //guarda a busca nas recentes (sem repetir, no máximo 6)
  void _guardarRecente(String termo) {
    final t = termo.trim();
    if (t.isEmpty) return;
    setState(() {
      _recentes.removeWhere((r) => r.toLowerCase() == t.toLowerCase());
      _recentes.insert(0, t);
      if (_recentes.length > 6) _recentes.removeLast();
    });
  }

  void _buscarTermo(String termo) {
    setState(() => _busca.text = termo);
    _busca.selection = TextSelection.collapsed(offset: termo.length);
    _guardarRecente(termo);
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
    final resultados = _resultados;

    return Scaffold(
      backgroundColor: _corFundo,
      appBar: _appBar(),
      bottomNavigationBar: _menuInferior(),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        children: [
          _barraBusca(),
          const SizedBox(height: 12),
          _linhaCategorias(),
          const SizedBox(height: 6),
          _linhaRestricoes(),
          if (_recentes.isNotEmpty) _secaoRecentes(),
          const SizedBox(height: 24),
          if (resultados.isNotEmpty)
            _secaoResultados(resultados)
          else if (_buscando)
            _estadoSemResultado()
          else
            _estadoInicial(),
          _rodape(),
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
      title: Text('Receitas', style: _estilo(20, FontWeight.w600, _corTexto)),
    );
  }

  //voltar + campo de busca
  Widget _barraBusca() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: _corBranco,
              shape: BoxShape.circle,
              boxShadow: _sombraBusca,
            ),
            child: const Icon(Icons.arrow_back, size: 22, color: _corTexto),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: _corBranco,
              borderRadius: BorderRadius.circular(999),
              boxShadow: _sombraBusca,
            ),
            child: TextField(
              controller: _busca,
              textInputAction: TextInputAction.search,
              onChanged: (_) => setState(() {}),
              onSubmitted: _guardarRecente,
              style: _estilo(14, FontWeight.w400, _corTexto),
              decoration: InputDecoration(
                hintText: 'Buscar por prato ou ingrediente...',
                hintStyle: _estilo(14, FontWeight.w400, _corCinzaIcone),
                prefixIcon: const Icon(Icons.search,
                    size: 20, color: _corTextoSuave),
                suffixIcon: _texto.isEmpty
                    ? null
                    : Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () => setState(() => _busca.clear()),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: _corCinzaClaro,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close,
                          size: 16, color: _corTextoSuave),
                    ),
                  ),
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  //Todas / Café da manhã / Almoço / Lanche / Jantar
  Widget _linhaCategorias() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 4),
        itemCount: _categorias.length,
        separatorBuilder: (_, __) => const SizedBox(width: 4),
        itemBuilder: (_, i) {
          final ativo = i == _categoria;
          return GestureDetector(
            onTap: () => setState(() => _categoria = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ativo ? _corVerde : _corBranco,
                borderRadius: BorderRadius.circular(999),
                boxShadow: ativo ? null : _sombraChip,
              ),
              child: Text(
                _categorias[i],
                style: _estilo(12, FontWeight.w600,
                    ativo ? Colors.white : _corTextoSuave,
                    espaco: 0.24),
              ),
            ),
          );
        },
      ),
    );
  }

  //Vegetariana / Sem lactose / Sem glúten / Low carb
  Widget _linhaRestricoes() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 4),
        itemCount: _restricoes.length,
        separatorBuilder: (_, __) => const SizedBox(width: 4),
        itemBuilder: (_, i) {
          final nome = _restricoes[i];
          final ativo = _restricoesAtivas.contains(nome);

          //Low carb usa laranja quando ativa, as demais usam verde
          final laranja = i == 3;
          Color fundo = _corBranco;
          Color cor = _corTextoSuave;
          if (ativo) {
            fundo = laranja ? _corLaranjaClaro : _corVerdeChip;
            cor = laranja ? _corLaranjaEscuro : _corVerdeChipTexto;
          }

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
              height: 28,
              padding: const EdgeInsets.only(left: 10, right: 12),
              decoration: BoxDecoration(
                color: fundo,
                borderRadius: BorderRadius.circular(999),
                boxShadow: ativo ? null : _sombraChip,
              ),
              child: Row(
                children: [
                  Icon(_iconesRestricoes[i], size: 15, color: cor),
                  const SizedBox(width: 4),
                  Text(nome, style: _estilo(11, FontWeight.w700, cor)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  //buscas recentes (só aparece depois da primeira busca)
  Widget _secaoRecentes() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.history, size: 16, color: _corCinzaIcone),
                  const SizedBox(width: 6),
                  Text('BUSCAS RECENTES',
                      style: _estilo(11, FontWeight.w700, _corCinzaIcone,
                          espaco: 0.44)),
                ],
              ),
              GestureDetector(
                onTap: () => setState(() => _recentes.clear()),
                child: Text('Limpar',
                    style: _estilo(11, FontWeight.w700, _corMarrom)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final termo in _recentes)
                GestureDetector(
                  onTap: () => _buscarTermo(termo),
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _corCardClaro,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(termo,
                            style: _estilo(12, FontWeight.w600, _corTextoSuave,
                                espaco: 0.24)),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: () =>
                              setState(() => _recentes.remove(termo)),
                          child: const Icon(Icons.close,
                              size: 14, color: _corCinzaIcone),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  //lista de resultados
  Widget _secaoResultados(List<_ReceitaBusca> lista) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Receitas encontradas',
                style: _estilo(18, FontWeight.w600, _corTexto)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: _corVerdeClaro,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                '${lista.length} ${lista.length == 1 ? 'prato' : 'pratos'}',
                style: _estilo(12, FontWeight.w600, _corVerde, espaco: 0.24),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final r in lista) ...[
          _cardResultado(r),
          const SizedBox(height: 12),
        ],
      ],
    );
  }

  Widget _cardResultado(_ReceitaBusca r) {
    final favorita = _favoritas.contains(r.titulo);

    Color fundoChip = _corCinzaClaro;
    Color corChip = _corTexto;
    if (r.refeicao == 'Almoço') {
      fundoChip = _corVerdeChip;
      corChip = _corVerdeChipTexto;
    } else if (r.refeicao == 'Jantar') {
      fundoChip = _corLaranjaClaro;
      corChip = _corLaranjaEscuro;
    } else if (r.refeicao == 'Café da manhã') {
      fundoChip = _corVerdeClaro;
      corChip = _corVerdeClaroTexto;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _corBranco,
        borderRadius: BorderRadius.circular(32),
        boxShadow: _sombraCard,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Container(
              width: 84,
              height: 84,
              color: _corCinzaMedio,
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
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: fundoChip,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(r.refeicao,
                      style: _estilo(11, FontWeight.w700, corChip)),
                ),
                const SizedBox(height: 4),
                Text(r.titulo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _estilo(15, FontWeight.w700, _corTexto)),
                const SizedBox(height: 4),
                //FittedBox: encolhe a linha se não couber na largura
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const Icon(Icons.schedule,
                          size: 14, color: _corCinzaIcone),
                      const SizedBox(width: 2),
                      Text('${r.minutos} min',
                          style: _estilo(12, FontWeight.w400, _corTextoSuave)),
                      const SizedBox(width: 8),
                      Text('•',
                          style: _estilo(12, FontWeight.w400, _corTextoSuave)),
                      const SizedBox(width: 8),
                      const Icon(Icons.local_fire_department,
                          size: 14, color: _corMarrom),
                      const SizedBox(width: 2),
                      Text('${r.kcal} kcal',
                          style: _estilo(12, FontWeight.w400, _corTextoSuave)),
                      const SizedBox(width: 8),
                      Text('•',
                          style: _estilo(12, FontWeight.w400, _corTextoSuave)),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: _corCinzaMedio,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(r.dificuldade,
                            style:
                            _estilo(10, FontWeight.w700, _corTextoSuave)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            height: 84,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (favorita) {
                        _favoritas.remove(r.titulo);
                      } else {
                        _favoritas.add(r.titulo);
                      }
                    });
                  },
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: Icon(
                      favorita ? Icons.favorite : Icons.favorite_border,
                      size: 20,
                      color: favorita ? _corErro : _corCinzaIcone,
                    ),
                  ),
                ),
                GestureDetector(
                  //TODO: salvar a receita na lista do usuário (ViewModel)
                  onTap: () => _aviso('Receita salva na sua lista!'),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: _corVerdeChip,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add,
                        size: 18, color: _corVerdeChipTexto),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //primeiro acesso: nada pesquisado ainda
  Widget _estadoInicial() {
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
              color: _corVerdeChip,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.search,
                size: 30, color: _corVerdeChipTexto),
          ),
          const SizedBox(height: 16),
          Text('Encontre novas receitas',
              textAlign: TextAlign.center,
              style: _estilo(18, FontWeight.w600, _corTexto)),
          const SizedBox(height: 4),
          Text(
            'Pesquise por prato ou ingrediente e salve as que você gostar na sua lista.',
            textAlign: TextAlign.center,
            style: _estilo(14, FontWeight.w400, _corTextoSuave, altura: 1.4),
          ),
          const SizedBox(height: 20),
          Text('EXPERIMENTE BUSCAR POR',
              style: _estilo(11, FontWeight.w700, _corCinzaIcone, espaco: 0.44)),
          const SizedBox(height: 10),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final termo in _sugestoes)
                GestureDetector(
                  onTap: () => _buscarTermo(termo),
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: _corCardClaro,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(termo,
                        style: _estilo(12, FontWeight.w600, _corTextoSuave,
                            espaco: 0.24)),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  //buscou e não achou
  Widget _estadoSemResultado() {
    return Container(
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
          Text('Tente outro termo ou remova alguns filtros.',
              textAlign: TextAlign.center,
              style: _estilo(14, FontWeight.w400, _corTextoSuave, altura: 1.4)),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              setState(() {
                _busca.clear();
                _categoria = 0;
                _restricoesAtivas.clear();
              });
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
              child: Text('Limpar busca e filtros',
                  style: _estilo(14, FontWeight.w600, Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rodape() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cloud_done, size: 16, color: _corVerde),
          const SizedBox(width: 6),
          Text('Receitas fornecidas por TheMealDB',
              style: _estilo(11, FontWeight.w700, _corTextoSuave)),
        ],
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