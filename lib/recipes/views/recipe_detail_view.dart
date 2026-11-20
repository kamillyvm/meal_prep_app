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
const _corVerdeBarra = Color(0xFF7BA68D);
const _corVerdeChip = Color(0xFFC6EBD2);
const _corVerdeChipTexto = Color(0xFF002112);
const _corVerdeEscuroTexto = Color(0xFF2D4D3B);
const _corVerdeSecundario = Color(0xFF456552);

const _corMarrom = Color(0xFF85532E);
const _corLaranja = Color(0xFFCC8F65);
const _corLaranjaClaro = Color(0xFFFFDCC6);
const _corLaranjaEscuro = Color(0xFF301400);

//cores com transparência
const _corVerdeChip40 = Color(0x66C6EBD2);
const _corBranco85 = Color(0xD9FFFFFF);

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

const _sombraLeve = [
  BoxShadow(
    color: Color(0x0D000000),
    blurRadius: 2,
    offset: Offset(0, 1),
  ),
];

//dados da receita
//a tela recebe a receita pronta; quando existir o model/ViewModel,
//é só montar um DetalheReceita com os dados reais e passar para cá.

class IngredienteDetalhe {
  final String nome;
  final double porPorcao; //quantidade para 1 porção
  final String unidade;
  final String setor;

  const IngredienteDetalhe({
    required this.nome,
    required this.porPorcao,
    required this.unidade,
    required this.setor,
  });
}

class PassoDetalhe {
  final String titulo;
  final String texto;

  const PassoDetalhe({required this.titulo, required this.texto});
}

class DetalheReceita {
  final String titulo;
  final String imagem;
  final String refeicao; //Almoço, Jantar...
  final String categoria; //Prato Principal...
  final int minutos;
  final String dificuldade;
  final List<String> restricoes;
  final int porcoesIniciais;

  //informação nutricional por porção
  final int kcal;
  final int proteina;
  final int carbo;
  final int gordura;
  final int fibra;

  final List<IngredienteDetalhe> ingredientes;
  final List<PassoDetalhe> passos;
  final String dica;

  const DetalheReceita({
    required this.titulo,
    required this.imagem,
    required this.refeicao,
    required this.categoria,
    required this.minutos,
    required this.dificuldade,
    required this.restricoes,
    required this.porcoesIniciais,
    required this.kcal,
    required this.proteina,
    required this.carbo,
    required this.gordura,
    required this.fibra,
    required this.ingredientes,
    required this.passos,
    required this.dica,
  });
}

//receita de exemplo (usada quando nenhuma é passada para a tela)
const _receitaExemplo = DetalheReceita(
  titulo: 'Frango Grelhado com Legumes',
  imagem:
  'https://lh3.googleusercontent.com/aida/ALJJyrAl9_KJfqqHMqCP3lk9UQ7de0-tOp6nDjv6XP6ynDmUeJzVyT6oXVr6V7HoQwp6iVgI7QLyCgbSLd7tQzUDYdPK9gEb4smApqHYMrOw_iRAQnBHjIsnSLdasfpBB72rfYuMMX2czMCA0gT91wNBSOAO_w3XAxnhs4kjrPcOWbCy9pXiER6mAF16h5OV3mYXD0Wie1XyeA11WE3fz_cvARB9b_4S_x-njOHXgcM_fbRK',
  refeicao: 'Almoço',
  categoria: 'Prato Principal',
  minutos: 30,
  dificuldade: 'Fácil',
  restricoes: ['Sem glúten', 'Low carb'],
  porcoesIniciais: 4,
  kcal: 420,
  proteina: 44,
  carbo: 18,
  gordura: 14,
  fibra: 6,
  ingredientes: [
    IngredienteDetalhe(
      nome: 'Filé de peito de frango',
      porPorcao: 125,
      unidade: 'g',
      setor: 'Açougue & Peixaria',
    ),
    IngredienteDetalhe(
      nome: 'Abobrinha média em rodelas',
      porPorcao: 0.5,
      unidade: 'unid',
      setor: 'Hortifruti',
    ),
    IngredienteDetalhe(
      nome: 'Brócolis fresco em floretes',
      porPorcao: 0.25,
      unidade: 'maço',
      setor: 'Hortifruti',
    ),
    IngredienteDetalhe(
      nome: 'Azeite de oliva extravirgem',
      porPorcao: 0.5,
      unidade: 'col. de sopa',
      setor: 'Mercearia & Grãos',
    ),
    IngredienteDetalhe(
      nome: 'Alecrim e tomilho frescos',
      porPorcao: 0.25,
      unidade: 'ramo',
      setor: 'Hortifruti',
    ),
    IngredienteDetalhe(
      nome: 'Limão siciliano (suco e raspas)',
      porPorcao: 0.25,
      unidade: 'unid',
      setor: 'Hortifruti',
    ),
  ],
  passos: [
    PassoDetalhe(
      titulo: 'Marinada rápida',
      texto:
      'Temperar o frango com o suco de limão siciliano, alho amassado, azeite, sal, pimenta e ervas frescas. Deixar descansar por 15 minutos.',
    ),
    PassoDetalhe(
      titulo: 'Preparar os legumes',
      texto:
      'Cortar a abobrinha em rodelas e o brócolis em floretes médios. Temperar levemente com azeite extravirgem e sal marinho.',
    ),
    PassoDetalhe(
      titulo: 'Grelhar e servir',
      texto:
      'Em fogo médio-alto, grelhar os filés de frango até dourarem por fora e ficarem suculentos por dentro. Na mesma grelha, tostar levemente os legumes até ficarem al dente.',
    ),
  ],
  dica:
  'Armazene em potes herméticos de vidro na geladeira por até 4 dias, ou congele porções individuais por até 30 dias.',
);

//tela
class RecipeDetailView extends StatefulWidget {
  const RecipeDetailView({super.key, this.receita = _receitaExemplo});

  final DetalheReceita receita;

  @override
  State<RecipeDetailView> createState() => _RecipeDetailViewState();
}

class _RecipeDetailViewState extends State<RecipeDetailView> {
  DetalheReceita get _r => widget.receita;

  late int _porcoes = _r.porcoesIniciais;
  bool _favorita = false;
  final Set<int> _marcados = {}; //ingredientes já separados

  //2 -> "2", 1.5 -> "1,5"
  String _formatar(double valor) {
    if (valor % 1 == 0) return valor.toInt().toString();
    return valor.toStringAsFixed(1).replaceAll('.', ',');
  }

  void _mudarPorcoes(int delta) {
    final novo = _porcoes + delta;
    if (novo < 1 || novo > 12) return;
    setState(() => _porcoes = novo);
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

  void _alternarFavorita() {
    setState(() => _favorita = !_favorita);
    _aviso(_favorita ? 'Salva nas receitas favoritas!' : 'Removida dos favoritos');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _corFundo,
      bottomNavigationBar: _barraAcoes(),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _imagemTopo(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _informacoes(),
                const SizedBox(height: 24),
                _cardPorcoes(),
                const SizedBox(height: 24),
                _cardNutricao(),
                const SizedBox(height: 24),
                _secaoIngredientes(),
                const SizedBox(height: 24),
                _secaoPreparo(),
                const SizedBox(height: 24),
                _cardDica(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //foto no topo
  Widget _imagemTopo() {
    final topoSeguro = MediaQuery.of(context).padding.top;

    return SizedBox(
      height: 320,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  color: _corCinzaMedio,
                  child: Image.network(
                    _r.imagem,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.restaurant,
                      size: 48,
                      color: _corCinzaIcone,
                    ),
                  ),
                ),
                //escurece um pouco para os botões aparecerem
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x6630312E),
                        Color(0x0030312E),
                        Color(0x3330312E),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: topoSeguro + 16,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _botaoRedondo(
                  Icons.arrow_back,
                      () => Navigator.maybePop(context),
                ),
                _botaoRedondo(
                  _favorita ? Icons.favorite : Icons.favorite_border,
                  _alternarFavorita,
                  cor: _favorita ? _corLaranja : _corTexto,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _botaoRedondo(IconData icone, VoidCallback aoTocar,
      {Color cor = _corTexto}) {
    return GestureDetector(
      onTap: aoTocar,
      child: Container(
        width: 44,
        height: 44,
        decoration: const BoxDecoration(
          color: _corBranco85,
          shape: BoxShape.circle,
          boxShadow: _sombraLeve,
        ),
        child: Icon(icone, size: 22, color: cor),
      ),
    );
  }

  //tipo, título e chips
  Widget _informacoes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: [
            _chipSimples(_r.refeicao, _corVerdeChip, _corVerdeChipTexto,
                tamanho: 12, pesoTexto: FontWeight.w600),
            _chipSimples(_r.categoria, _corCinzaMedio, _corVerdeSecundario,
                tamanho: 12, pesoTexto: FontWeight.w600),
          ],
        ),
        const SizedBox(height: 8),
        Text(_r.titulo,
            style: _estilo(22, FontWeight.w700, _corTexto, altura: 1.36)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: [
            _chipComIcone(Icons.schedule, '${_r.minutos} min'),
            _chipComIcone(Icons.check_circle, _r.dificuldade),
            for (final restricao in _r.restricoes)
              restricao == 'Low carb'
                  ? _chipSimples(restricao, _corLaranjaClaro, _corLaranjaEscuro)
                  : _chipSimples(restricao, _corCardClaro, _corTextoSuave),
          ],
        ),
      ],
    );
  }

  Widget _chipSimples(String texto, Color fundo, Color cor,
      {double tamanho = 11, FontWeight pesoTexto = FontWeight.w700}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: fundo,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(texto, style: _estilo(tamanho, pesoTexto, cor)),
    );
  }

  Widget _chipComIcone(IconData icone, String texto) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _corCardClaro,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icone, size: 15, color: _corVerde),
          const SizedBox(width: 4),
          Text(texto, style: _estilo(11, FontWeight.w700, _corTextoSuave)),
        ],
      ),
    );
  }

  //rendimento (porções)
  Widget _cardPorcoes() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _corBranco,
        borderRadius: BorderRadius.circular(32),
        boxShadow: _sombraCard,
      ),
      child: Column(
        children: [
          Text('Rendimento', style: _estilo(14, FontWeight.w600, _corTexto)),
          Text('Quantidades ajustam automaticamente',
              style: _estilo(12, FontWeight.w400, _corCinzaIcone)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: _corCardClaro,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _botaoPorcao(Icons.remove, () => _mudarPorcoes(-1), _porcoes > 1),
                SizedBox(
                  width: 88,
                  child: Text(
                    '$_porcoes ${_porcoes == 1 ? 'porção' : 'porções'}',
                    textAlign: TextAlign.center,
                    style: _estilo(14, FontWeight.w600, _corVerde),
                  ),
                ),
                _botaoPorcao(Icons.add, () => _mudarPorcoes(1), _porcoes < 12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _botaoPorcao(IconData icone, VoidCallback aoTocar, bool ativo) {
    return GestureDetector(
      onTap: ativo ? aoTocar : null,
      child: Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          color: _corBranco,
          shape: BoxShape.circle,
          boxShadow: _sombraLeve,
        ),
        child: Icon(icone,
            size: 18, color: ativo ? _corTexto : _corBordaDesativada),
      ),
    );
  }

  //informação nutricional
  Widget _cardNutricao() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _corBranco,
        borderRadius: BorderRadius.circular(32),
        boxShadow: _sombraCard,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    const Icon(Icons.monitor_heart_outlined,
                        size: 20, color: _corVerde),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text('Informação nutricional',
                          overflow: TextOverflow.ellipsis,
                          style: _estilo(14, FontWeight.w600, _corTexto)),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: _corCinzaClaro,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text('Por porção',
                    style: _estilo(11, FontWeight.w700, _corTextoSuave)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _caixaNutriente('Calorias', '${_r.kcal}', 'kcal',
                  corValor: _corVerde),
              const SizedBox(width: 8),
              _caixaNutriente('Proteína', '${_r.proteina}g', 'Alto',
                  corSub: _corVerdeBarra),
              const SizedBox(width: 8),
              _caixaNutriente('Carbos', '${_r.carbo}g', 'Líquidos'),
              const SizedBox(width: 8),
              _caixaNutriente('Gorduras', '${_r.gordura}g', 'Boas'),
              const SizedBox(width: 8),
              _caixaNutriente('Fibras', '${_r.fibra}g', 'Naturais'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _caixaNutriente(String titulo, String valor, String sub,
      {Color corValor = _corTexto, Color corSub = _corCinzaIcone}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
        decoration: BoxDecoration(
          color: _corCardClaro,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            _textoAjustado(titulo, _estilo(11, FontWeight.w400, _corCinzaIcone)),
            const SizedBox(height: 2),
            _textoAjustado(valor, _estilo(14, FontWeight.w600, corValor)),
            _textoAjustado(sub, _estilo(11, FontWeight.w400, corSub)),
          ],
        ),
      ),
    );
  }

  //reduz o texto se não couber (as caixas são estreitas)
  Widget _textoAjustado(String texto, TextStyle estilo) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(texto, maxLines: 1, style: estilo),
    );
  }

  //ingredientes
  Widget _secaoIngredientes() {
    final itens = _r.ingredientes;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Ingredientes',
                  style: _estilo(18, FontWeight.w600, _corTexto)),
              Text('${itens.length} ${itens.length == 1 ? 'item' : 'itens'}',
                  style: _estilo(12, FontWeight.w600, _corCinzaIcone)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _corBranco,
            borderRadius: BorderRadius.circular(32),
            boxShadow: _sombraCard,
          ),
          child: Column(
            children: [
              for (int i = 0; i < itens.length; i++) ...[
                _linhaIngrediente(i),
                if (i < itens.length - 1)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    height: 1,
                    color: _corCinzaMedio,
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _linhaIngrediente(int i) {
    final ing = _r.ingredientes[i];
    final marcado = _marcados.contains(i);
    final cor = marcado ? _corCinzaIcone : _corTexto;
    final riscado = marcado ? TextDecoration.lineThrough : null;

    Color corSetor = _corTextoSuave;
    if (ing.setor == 'Hortifruti') corSetor = _corVerde;
    if (ing.setor == 'Açougue & Peixaria') corSetor = _corMarrom;

    return InkWell(
      onTap: () {
        setState(() {
          if (marcado) {
            _marcados.remove(i);
          } else {
            _marcados.add(i);
          }
        });
      },
      borderRadius: BorderRadius.circular(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: marcado ? _corVerde : _corBranco,
              shape: BoxShape.circle,
              border: Border.all(
                color: marcado ? _corVerde : _corCinzaIcone,
                width: 1.5,
              ),
            ),
            child: marcado
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: _formatar(ing.porPorcao * _porcoes),
                        style: _estilo(14, FontWeight.w600, cor,
                            decoracao: riscado),
                      ),
                      TextSpan(
                        text: ' ${ing.unidade} ${ing.nome}',
                        style: _estilo(14, FontWeight.w400, cor,
                            decoracao: riscado),
                      ),
                    ],
                  ),
                ),
                Text(ing.setor, style: _estilo(12, FontWeight.w400, corSetor)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //modo de preparo
  Widget _secaoPreparo() {
    final passos = _r.passos;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Modo de preparo',
                  style: _estilo(18, FontWeight.w600, _corTexto)),
              Text('${passos.length} ${passos.length == 1 ? 'passo' : 'passos'}',
                  style: _estilo(12, FontWeight.w600, _corCinzaIcone)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        for (int i = 0; i < passos.length; i++) ...[
          _cardPasso(i + 1, passos[i]),
          if (i < passos.length - 1) const SizedBox(height: 8),
        ],
      ],
    );
  }

  Widget _cardPasso(int numero, PassoDetalhe passo) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _corBranco,
        borderRadius: BorderRadius.circular(32),
        boxShadow: _sombraCard,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: _corVerde,
              shape: BoxShape.circle,
            ),
            child: Text('$numero',
                style: _estilo(14, FontWeight.w600, Colors.white)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(passo.titulo,
                    style: _estilo(14, FontWeight.w600, _corTexto)),
                const SizedBox(height: 4),
                Text(passo.texto,
                    style: _estilo(14, FontWeight.w400, _corTextoSuave,
                        altura: 1.6)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //dica de meal prep
  Widget _cardDica() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _corVerdeChip40,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: _corVerdeChip,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.kitchen,
                size: 20, color: _corVerdeChipTexto),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dica de Meal Prep',
                    style: _estilo(14, FontWeight.w600, _corVerdeChipTexto)),
                const SizedBox(height: 2),
                Text(_r.dica,
                    style: _estilo(12, FontWeight.w400, _corVerdeEscuroTexto,
                        altura: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //barra fixa com as ações
  Widget _barraAcoes() {
    return Container(
      decoration: const BoxDecoration(
        color: _corFundo,
        boxShadow: [
          BoxShadow(
            color: Color(0x0F1B2B20),
            blurRadius: 12,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                //TODO: abrir a escolha de dia/refeição e salvar no planejamento
                onTap: () => _aviso('Adicionado ao planejamento semanal!'),
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  height: 52,
                  width: double.infinity,
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
                      const Icon(Icons.calendar_today,
                          size: 20, color: Colors.white),
                      const SizedBox(width: 8),
                      Text('Adicionar ao planejamento',
                          style: _estilo(14, FontWeight.w600, Colors.white)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                //TODO: enviar os ingredientes (já ajustados às porções) para a lista de compras
                onTap: () =>
                    _aviso('Ingredientes adicionados à sua lista de compras!'),
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _corVerdeChip,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.shopping_basket,
                          size: 20, color: _corVerdeChipTexto),
                      const SizedBox(width: 8),
                      Text('Adicionar à lista de compras',
                          style: _estilo(
                              14, FontWeight.w600, _corVerdeChipTexto)),
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
}

//cor do botão −/+ quando chega no limite
const _corBordaDesativada = Color(0xFFC1C8C1);