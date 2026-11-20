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
const _corVerdeChip = Color(0xFFC6EBD2);
const _corVerdeChipTexto = Color(0xFF002112);
const _corVerdeIcone = Color(0xFF4B6C57);
const _corVerdeSecundario = Color(0xFF456552);

const _corMarrom = Color(0xFF85532E);
const _corErro = Color(0xFFBA1A1A);

//cores com transparência
const _corVerdeChip60 = Color(0x99C6EBD2);
const _corVerdeChip40 = Color(0x66C6EBD2);
const _corVerdeBadge = Color(0x667BA68D);
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

const _sombraLeve = [
  BoxShadow(
    color: Color(0x0D000000),
    blurRadius: 2,
    offset: Offset(0, 1),
  ),
];

//opções
const _opcoesOrdem = ['Mais recentes', 'Nome (A–Z)', 'Menor tempo'];
const _opcoesPeriodo = ['Este mês', 'Últimos 3 meses', 'Tudo'];
const _meses = [
  'janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho',
  'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'
];

//dados
//primeiro acesso: nenhuma receita favoritada e nenhum prato preparado
//depois essas listas virão do ViewModel

//troque para true só para testar como o layout fica com dados.
bool _usarDadosDeExemplo = false;

class _Favorita {
  final String titulo;
  final String refeicao;
  final String imagem;
  final int minutos;
  final int kcal;

  _Favorita({
    required this.titulo,
    required this.refeicao,
    required this.imagem,
    required this.minutos,
    required this.kcal,
  });
}

class _Preparada {
  final String titulo;
  final String imagem;
  final int vezes; //quantas vezes já foi feita
  final DateTime ultimaVez;

  _Preparada({
    required this.titulo,
    required this.imagem,
    required this.vezes,
    required this.ultimaVez,
  });
}

//só para testar o layout (_usarDadosDeExemplo = true)
final _favoritasExemplo = [
  _Favorita(
    titulo: 'Frango Grelhado',
    refeicao: 'Almoço',
    imagem:
    'https://lh3.googleusercontent.com/aida-public/AB6AXuBTM7WdMhZiGfQhdFabuGg0FrDiVcMvyizO60o533_gSqOmRPahCoX8ZIAsrn6661SOcmeeZrcYPSvrGVaWzDjwodtGxsp0hRGEaRTwrPf_gfj9iciCzpQNG6CsmRoEP_SYAQ5jMxFStSGkAzfdr3wHxScGkd4D_ClS4dNE8bUteJhOQTNg_A15LIBPrsEUSNlUftE9RxbXGrOuEIKsdPElh_RsLUG8NIq4JmXVBjA',
    minutos: 30,
    kcal: 420,
  ),
  _Favorita(
    titulo: 'Salmão ao Forno',
    refeicao: 'Jantar',
    imagem:
    'https://lh3.googleusercontent.com/aida-public/AB6AXuB3N1woI2NKN89-iaHBCV5WiAQ7w7MwzZH03pdJhrjMGLROU6gxnlOakmCYHGRJc4ZxYF2s_lwyxidejfvu1ujuQz5KQffbOJW0HfGzz_wQRORA3RRHkw_TGKUJc0eN3YcMc9ZahTfnTEIv2ZHgJfLEY9wRp5LJFoKI9P-ewEJ7JtEko523GWEYvSIDARNJS2DaxQB9tdz5cCvQrCplWFt3lij-U6WlIHc3zh9wo_w',
    minutos: 25,
    kcal: 380,
  ),
  _Favorita(
    titulo: 'Panqueca de Aveia',
    refeicao: 'Café da manhã',
    imagem:
    'https://lh3.googleusercontent.com/aida-public/AB6AXuBM9M2u7N_3edI4nIlHC3nC-xfCTfvRivWUldmy6d6lgzqlYmMkRb9R0ySsaZ3OIK_Hj4Zk8CO_hfSs_G-CVI4nj2Lyj_bsZN1zJhIuT-Bo7WnrDvLFUXb1hsXsJwflWEqz4oM-bAzA6CV8IVEZk_cEKVyu3k7Cbq2ylLhyeFSRjtEYonf1NZBOMJ0jGwEx6zKJIN2muD5Hp2P8YaxxSlLIWwRW1KW7Ck_-avSV3bQ',
    minutos: 15,
    kcal: 260,
  ),
  _Favorita(
    titulo: 'Wrap Mediterrâneo',
    refeicao: 'Lanche',
    imagem:
    'https://lh3.googleusercontent.com/aida-public/AB6AXuDRh9SaKRnMJHI_mEx3NGWb9zFkBnUsV7X6I5g3l-tdleTUV0GY1gti11abyIxycAQcMGzjaFm4iVA6dfXxN6Ro_sS6fBYRrzzJmrn-k1XwGTgNz67PHtjvpmgC5bhfmp5u4fPdxDUlwxcbCcGoUUkDlOKzjOrOHGR3-3Azde0y2Sgqc9B-SOGhVWk6WD_e_1MrWYwuWbrsl7sym0v4oxL6UpzffJ43ZI8Eww2rq20',
    minutos: 10,
    kcal: 290,
  ),
];

//datas relativas a hoje, para o filtro de período funcionar
List<_Preparada> _preparadasExemplo() {
  final hoje = DateTime.now();
  return [
    _Preparada(
      titulo: 'Frango com Legumes',
      imagem:
      'https://lh3.googleusercontent.com/aida-public/AB6AXuCRE_zrhwWE1LFEDYW28DG3aNOZXkZZ4wuSi7jqP8UgX4rW7CMzNXP1K2ScCWXdj-eIupMo_554D5rphOkKGHj-LcqSbOt3TcfmsMKCEtfpNz7Avq8yAVQsu3dxkOZv2An8WrGOknkGnxaN87qkb-n5NYPRhLD6aQjYwKTFPBxUDrrDTHOfJtnhLDdSFg4Dw8ydSQ-Z7gm2g68beFiXasG7QIf_M1wIoQNaFotHtNs',
      vezes: 3,
      ultimaVez: hoje.subtract(const Duration(days: 2)),
    ),
    _Preparada(
      titulo: 'Salmão com Ervas',
      imagem:
      'https://lh3.googleusercontent.com/aida-public/AB6AXuBmADmMQTs8PfThc4FRjfJhRzyYaV3B7TuJoU9xEGg9SDIOs1cTD6jFRaAPlwr28hdJrv7ZJopFnUGEW3czctF1Lb-8lKJe2KMz4BYB-VAPw4wT_oHnZf9uWd7YJgXsTVT57iKi-qYU5AP8aZPK0tewViL7a4RttVMiCSkJDk2O0t-92bOCPBjnKnYNUDeSdKYdzy4MA8AEXGz18mi5JXat-d6HZ8qw8b6wJ88yv1I',
      vezes: 2,
      ultimaVez: hoje.subtract(const Duration(days: 6)),
    ),
    _Preparada(
      titulo: 'Omelete de Espinafre',
      imagem:
      'https://lh3.googleusercontent.com/aida-public/AB6AXuBvqwbA9giroLOIsGp33Vc4c8lAboJY2dGVsSzZUSTAvXTRuayFOtXgPWcLzw4EA-n3O7e6gj5C3jxNIs3u44JqTi6X8xiJdq7S72i5MjHEwAJyjygKC4wvIMr6q7Hl7lIGbZqUYMCKNKfTIVZItRFZgLyk9daG8tlSUft7avGk5CPpk3puQs_3syUXMLh4isaYhnkD1IceU5G54QOjKx8wswglDt9V4mesL-2HDYQ',
      vezes: 5,
      ultimaVez: hoje.subtract(const Duration(days: 40)),
    ),
  ];
}

//tela
class MyRecipesView extends StatefulWidget {
  const MyRecipesView({super.key});

  @override
  State<MyRecipesView> createState() => _MyRecipesViewState();
}

class _MyRecipesViewState extends State<MyRecipesView> {
  int _aba = 0; //0 = Favoritas, 1 = Já preparadas
  int _periodo = 0;
  String _ordem = 'Mais recentes';

  late final List<_Favorita> _favoritas =
  _usarDadosDeExemplo ? List.of(_favoritasExemplo) : <_Favorita>[];
  late final List<_Preparada> _preparadas =
  _usarDadosDeExemplo ? _preparadasExemplo() : <_Preparada>[];

  //favoritas na ordem escolhida
  List<_Favorita> get _favoritasOrdenadas {
    final lista = List.of(_favoritas);
    if (_ordem == 'Nome (A–Z)') {
      lista.sort((a, b) => a.titulo.compareTo(b.titulo));
    } else if (_ordem == 'Menor tempo') {
      lista.sort((a, b) => a.minutos.compareTo(b.minutos));
    }
    return lista;
  }

  //preparadas dentro do período escolhido
  List<_Preparada> get _preparadasDoPeriodo {
    final agora = DateTime.now();

    return _preparadas.where((p) {
      if (_periodo == 0) {
        return p.ultimaVez.year == agora.year &&
            p.ultimaVez.month == agora.month;
      }
      if (_periodo == 1) {
        return p.ultimaVez.isAfter(agora.subtract(const Duration(days: 90)));
      }
      return true;
    }).toList();
  }

  String _dataPreparo(DateTime d) => '${d.day} de ${_meses[d.month - 1]}';

  void _aviso(String texto, {SnackBarAction? acao}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(texto, style: _estilo(13, FontWeight.w500, Colors.white)),
          backgroundColor: _corTexto,
          behavior: SnackBarBehavior.floating,
          action: acao,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
  }

  //tirar dos favoritos (com opção de desfazer)
  void _desfavoritar(_Favorita receita) {
    final posicao = _favoritas.indexOf(receita);
    setState(() => _favoritas.remove(receita));

    _aviso(
      'Removida dos favoritos',
      acao: SnackBarAction(
        label: 'Desfazer',
        textColor: _corVerdeClaro,
        onPressed: () {
          setState(() => _favoritas.insert(posicao, receita));
        },
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
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        children: [
          _titulo(),
          const SizedBox(height: 24),
          _abas(),
          const SizedBox(height: 24),
          if (_aba == 0) _painelFavoritas() else _painelPreparadas(),
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
                'Minhas receitas',
                style: _estilo(18, FontWeight.w600, _corTexto),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //título + botão de ordenação
  Widget _titulo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Minhas receitas',
                style: _estilo(22, FontWeight.w700, _corTexto, altura: 1.36)),
            _menuOrdenacao(
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: _corCinzaMedio,
                  shape: BoxShape.circle,
                  boxShadow: _sombraLeve,
                ),
                child: const Icon(Icons.tune,
                    size: 20, color: _corVerdeSecundario),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text('Seu acervo culinário pessoal e histórico semanal',
            style: _estilo(14, FontWeight.w400, _corTextoSuave, altura: 1.4)),
      ],
    );
  }

  //menu de ordenação (usado no botão tune e na pílula "Mais recentes")
  Widget _menuOrdenacao(Widget filho) {
    return PopupMenuButton<String>(
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
      child: filho,
    );
  }

  //abas Favoritas / Já preparadas
  Widget _abas() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: _corCinzaMedio,
        borderRadius: BorderRadius.circular(999),
        boxShadow: _sombraLeve,
      ),
      child: Row(
        children: [
          Expanded(
            child: _botaoAba(
              indice: 0,
              icone: Icons.favorite,
              nome: 'Favoritas',
              quantidade: _favoritas.length,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: _botaoAba(
              indice: 1,
              icone: Icons.history,
              nome: 'Já preparadas',
              quantidade: _preparadas.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _botaoAba({
    required int indice,
    required IconData icone,
    required String nome,
    required int quantidade,
  }) {
    final ativo = _aba == indice;
    final cor = ativo ? Colors.white : _corTextoSuave;

    return GestureDetector(
      onTap: () => setState(() => _aba = indice),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: ativo ? _corVerde : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
          boxShadow: ativo ? _sombraLeve : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone, size: 18, color: cor),
            const SizedBox(width: 6),
            Flexible(
              child: Text(nome,
                  overflow: TextOverflow.ellipsis,
                  style: _estilo(12, FontWeight.w600, cor, espaco: 0.24)),
            ),
            if (quantidade > 0) ...[
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: ativo ? _corVerdeBadge : _corCinzaClaro,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text('$quantidade',
                    style: _estilo(10, FontWeight.w700, cor)),
              ),
            ],
          ],
        ),
      ),
    );
  }

  //aba 1: favoritas
  Widget _painelFavoritas() {
    final lista = _favoritasOrdenadas;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (lista.isEmpty)
          _estadoVazio(
            icone: Icons.favorite_border,
            titulo: 'Nenhuma receita favorita',
            texto:
            'Toque no coração de uma receita para guardá-la aqui e achar rapidinho quando precisar.',
            botao: 'Explorar receitas',
            aoTocar: () => Navigator.maybePop(context),
          )
        else ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: _corVerde,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${lista.length} ${lista.length == 1 ? 'receita salva' : 'receitas salvas'}',
                      style: _estilo(12, FontWeight.w600, _corTextoSuave,
                          espaco: 0.24),
                    ),
                  ],
                ),
                _menuOrdenacao(
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: _corCardClaro,
                      borderRadius: BorderRadius.circular(999),
                      boxShadow: _sombraLeve,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.swap_vert,
                            size: 15, color: _corVerdeSecundario),
                        const SizedBox(width: 4),
                        Text(_ordem,
                            style: _estilo(
                                11, FontWeight.w700, _corVerdeSecundario)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _grade(lista),
        ],
        const SizedBox(height: 8),
        _cardDica(),
      ],
    );
  }

  Widget _grade(List<_Favorita> lista) {
    final linhas = <Widget>[];

    for (int i = 0; i < lista.length; i += 2) {
      final segundo = i + 1 < lista.length
          ? _cardFavorita(lista[i + 1])
          : const SizedBox();

      linhas.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _cardFavorita(lista[i])),
              const SizedBox(width: 8),
              Expanded(child: segundo),
            ],
          ),
        ),
      );
      linhas.add(const SizedBox(height: 8));
    }

    return Column(children: linhas);
  }

  Widget _cardFavorita(_Favorita r) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _corBranco,
        borderRadius: BorderRadius.circular(32),
        boxShadow: _sombraCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    color: _corCinzaMedio,
                    child: Image.network(
                      r.imagem,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.restaurant,
                        size: 32,
                        color: _corCinzaIcone,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () => _desfavoritar(r),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: _corBranco90,
                          shape: BoxShape.circle,
                          boxShadow: _sombraLeve,
                        ),
                        child: const Icon(Icons.favorite,
                            size: 18, color: _corErro),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    right: 8,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: _corBranco90,
                          borderRadius: BorderRadius.circular(999),
                          boxShadow: _sombraLeve,
                        ),
                        child: Text(r.refeicao,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: _estilo(11, FontWeight.w700, _corTexto)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(r.titulo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _estilo(16, FontWeight.w600, _corTexto, altura: 1.4)),
                const SizedBox(height: 4),
                //FittedBox: encolhe a linha se não couber na largura
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      const Icon(Icons.schedule,
                          size: 13, color: _corCinzaIcone),
                      const SizedBox(width: 2),
                      Text('${r.minutos} min',
                          style: _estilo(12, FontWeight.w400, _corTextoSuave)),
                      const SizedBox(width: 6),
                      Text('•',
                          style: _estilo(12, FontWeight.w400, _corBordaSuave)),
                      const SizedBox(width: 6),
                      const Icon(Icons.local_fire_department,
                          size: 13, color: _corMarrom),
                      const SizedBox(width: 2),
                      Text('${r.kcal} kcal',
                          style: _estilo(12, FontWeight.w400, _corTextoSuave)),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardDica() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _corVerdeChip40,
        borderRadius: BorderRadius.circular(32),
        boxShadow: _sombraLeve,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: _corVerdeChip,
              shape: BoxShape.circle,
            ),
            child:
            const Icon(Icons.eco, size: 22, color: _corVerdeChipTexto),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('DICA MEAL PREP',
                    style: _estilo(11, FontWeight.w700, _corVerdeChipTexto,
                        espaco: 0.44)),
                const SizedBox(height: 2),
                Text(
                  'Grelhar peitos de frango em lote economiza até 45 min durante a sua semana.',
                  style: _estilo(12, FontWeight.w400, _corVerdeIcone,
                      altura: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //aba 2: já preparadas
  Widget _painelPreparadas() {
    final lista = _preparadasDoPeriodo;

    if (_preparadas.isEmpty) {
      return _estadoVazio(
        icone: Icons.history,
        titulo: 'Nenhum prato preparado ainda',
        texto:
        'Quando você marcar uma refeição como pronta, ela aparece aqui com a data e quantas vezes já foi feita.',
        botao: 'Ver planejamento',
        aoTocar: () => Navigator.maybePop(context),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _opcoesPeriodo.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) {
              final ativo = i == _periodo;
              return GestureDetector(
                onTap: () => setState(() => _periodo = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ativo ? _corVerde : _corCinzaMedio,
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: ativo ? _sombraLeve : null,
                  ),
                  child: Text(
                    _opcoesPeriodo[i],
                    style: _estilo(11, FontWeight.w700,
                        ativo ? Colors.white : _corTextoSuave,
                        espaco: 0.44),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        if (lista.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: _corCardClaro,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Text(
              'Nenhuma receita preparada neste período.',
              textAlign: TextAlign.center,
              style: _estilo(14, FontWeight.w400, _corTextoSuave, altura: 1.4),
            ),
          )
        else
          for (final p in lista) ...[
            _cardPreparada(p),
            const SizedBox(height: 8),
          ],
        const SizedBox(height: 8),
        InkWell(
          //TODO: reagendar os favoritos no planejamento da semana (ViewModel)
          onTap: () => _aviso('Favoritos adicionados ao planejamento!'),
          borderRadius: BorderRadius.circular(999),
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              color: _corVerde,
              borderRadius: BorderRadius.circular(999),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x331B2B20),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.edit_calendar, size: 20, color: Colors.white),
                const SizedBox(width: 8),
                Text('Reagendar favoritos da semana',
                    style: _estilo(14, FontWeight.w600, Colors.white)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _cardPreparada(_Preparada p) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _corBranco,
        borderRadius: BorderRadius.circular(32),
        boxShadow: _sombraCard,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 80,
              height: 80,
              color: _corCinzaMedio,
              child: Image.network(
                p.imagem,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                const Icon(Icons.restaurant, color: _corCinzaIcone),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(p.titulo,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: _estilo(18, FontWeight.w600, _corTexto,
                              altura: 1.3)),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: _corVerdeChip,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text('Feita ${p.vezes}x',
                          style: _estilo(11, FontWeight.w700, _corVerdeChipTexto)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text('Preparada em ${_dataPreparo(p.ultimaVez)}',
                    style: _estilo(12, FontWeight.w400, _corTextoSuave)),
                const SizedBox(height: 8),
                GestureDetector(
                  //TODO: adicionar a receita ao planejamento (ViewModel)
                  onTap: () =>
                      _aviso('${p.titulo} adicionado ao planejamento!'),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add_circle,
                          size: 17, color: _corVerde),
                      const SizedBox(width: 6),
                      Text('Preparar de novo',
                          style: _estilo(11, FontWeight.w700, _corVerde)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //estado vazio (serve para as duas abas)
  Widget _estadoVazio({
    required IconData icone,
    required String titulo,
    required String texto,
    required String botao,
    required VoidCallback aoTocar,
  }) {
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
            child: Icon(icone, size: 30, color: _corVerdeIcone),
          ),
          const SizedBox(height: 16),
          Text(titulo,
              textAlign: TextAlign.center,
              style: _estilo(18, FontWeight.w600, _corTexto)),
          const SizedBox(height: 4),
          Text(texto,
              textAlign: TextAlign.center,
              style: _estilo(14, FontWeight.w400, _corTextoSuave, altura: 1.4)),
          const SizedBox(height: 20),
          InkWell(
            onTap: aoTocar,
            borderRadius: BorderRadius.circular(999),
            child: Container(
              height: 48,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _corVerde,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(botao,
                  style: _estilo(14, FontWeight.w600, Colors.white)),
            ),
          ),
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

//cor do separador "•"
const _corBordaSuave = Color(0xFFC1C8C1);