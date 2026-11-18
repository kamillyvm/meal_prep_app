import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

const _sombraLeve = [
  BoxShadow(
    color: Color(0x0D000000),
    blurRadius: 2,
    offset: Offset(0, 1),
  ),
];

//opções do formulário
const _tiposRefeicao = ['Café da manhã', 'Almoço', 'Lanche', 'Jantar'];
const _dificuldades = ['Fácil', 'Médio', 'Difícil'];
const _iconesDificuldade = [
  Icons.sentiment_satisfied,
  Icons.sentiment_neutral,
  Icons.sentiment_dissatisfied,
];

const _restricoes = ['Vegetariana', 'Sem lactose', 'Sem glúten', 'Low carb'];
const _iconesRestricoes = [
  Icons.eco,
  Icons.water_drop,
  Icons.grain,
  Icons.fitness_center,
];

//setores do mercado (os mesmos da lista de compras)
const _setores = [
  'Hortifruti',
  'Açougue',
  'Laticínios',
  'Mercearia',
  'Padaria',
  'Limpeza',
];
const _iconesSetores = [
  Icons.kebab_dining,
  Icons.egg_alt,
  Icons.grain,
  Icons.bakery_dining,
  Icons.cleaning_services,
];

const _unidades = ['g', 'kg', 'ml', 'l', 'unid', 'col.', 'xíc.', 'maço'];
const _unidadesExtenso = {
  'g': 'gramas',
  'kg': 'quilos',
  'ml': 'ml',
  'l': 'litros',
  'unid': 'unidades',
  'col.': 'colheres',
  'xíc.': 'xícaras',
  'maço': 'maços',
};

//ingrediente adicionado ao formulário
class _Ingrediente {
  final String nome;
  final String quantidade;
  final String unidade;
  final int setor; //índice em _setores

  _Ingrediente({
    required this.nome,
    required this.quantidade,
    required this.unidade,
    required this.setor,
  });
}

//tela
class CreateRecipeView extends StatefulWidget {
  const CreateRecipeView({super.key});

  @override
  State<CreateRecipeView> createState() => _CreateRecipeViewState();
}

class _CreateRecipeViewState extends State<CreateRecipeView> {
  //campos (a receita nova começa em branco)
  final TextEditingController _nome = TextEditingController();
  final TextEditingController _kcal = TextEditingController();
  final TextEditingController _proteina = TextEditingController();
  final TextEditingController _carbo = TextEditingController();
  final TextEditingController _gordura = TextEditingController();

  final Set<String> _refeicoes = {};
  int _dificuldade = 0; //0 = Fácil
  int _minutos = 30;
  int _porcoes = 4;
  final Set<String> _restricoesAtivas = {};
  final List<_Ingrediente> _ingredientes = [];
  final List<String> _passos = [];
  bool _erroNome = false;

  @override
  void dispose() {
    _nome.dispose();
    _kcal.dispose();
    _proteina.dispose();
    _carbo.dispose();
    _gordura.dispose();
    super.dispose();
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

  void _salvar() {
    if (_nome.text.trim().isEmpty) {
      setState(() => _erroNome = true);
      _aviso('Dê um nome para a receita.');
      return;
    }
    //todo: montar a receita com os campos acima e salvar pelo ViewModel
    _aviso('Receita salva!');
    Navigator.maybePop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _corFundo,
      appBar: _appBar(),
      bottomNavigationBar: _barraSalvar(),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: [
          _areaFoto(),
          const SizedBox(height: 24),
          _campoNome(),
          const SizedBox(height: 24),
          _tipoRefeicao(),
          const SizedBox(height: 24),
          _seletorDificuldade(),
          const SizedBox(height: 24),
          _tempoEPorcoes(),
          const SizedBox(height: 24),
          _secaoRestricoes(),
          const SizedBox(height: 24),
          _secaoIngredientes(),
          const SizedBox(height: 24),
          _secaoPreparo(),
          const SizedBox(height: 24),
          _secaoNutricao(),
          const SizedBox(height: 8),
          Center(
            child: InkWell(
              onTap: () => Navigator.maybePop(context),
              borderRadius: BorderRadius.circular(999),
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                alignment: Alignment.center,
                child: Text('Descartar rascunho',
                    style: _estilo(12, FontWeight.w600, _corTextoSuave,
                        espaco: 0.24)),
              ),
            ),
          ),
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
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.maybePop(context),
        icon: const Icon(Icons.close, size: 24, color: _corTextoSuave),
      ),
      title: Text('Nova Receita',
          style: _estilo(18, FontWeight.w600, _corTexto)),
    );
  }

  //foto
  Widget _areaFoto() {
    return InkWell(
      //todo: escolher foto da câmera/galeria (precisa do pacote image_picker)
      onTap: () => _aviso('Escolher foto estará disponível em breve.'),
      borderRadius: BorderRadius.circular(32),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _corCardClaro,
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
                boxShadow: _sombraLeve,
              ),
              child: const Icon(Icons.photo_camera,
                  size: 32, color: _corVerdeChipTexto),
            ),
            const SizedBox(height: 8),
            Text('Adicionar foto do prato',
                style: _estilo(18, FontWeight.w600, _corTexto)),
            const SizedBox(height: 4),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 240),
              child: Text(
                'Tire uma foto ou escolha da galeria com iluminação natural',
                textAlign: TextAlign.center,
                style: _estilo(12, FontWeight.w400, _corTextoSuave, altura: 1.5),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: _corBranco,
                borderRadius: BorderRadius.circular(999),
                boxShadow: _sombraLeve,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add_a_photo, size: 18, color: _corVerde),
                  const SizedBox(width: 4),
                  Text('Escolher foto',
                      style: _estilo(12, FontWeight.w600, _corVerde)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //nome
  Widget _campoNome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Nome da receita ',
                      style: _estilo(12, FontWeight.w600, _corTexto,
                          espaco: 0.24),
                    ),
                    TextSpan(
                      text: '*',
                      style: _estilo(12, FontWeight.w600, _corMarrom),
                    ),
                  ],
                ),
              ),
              Text('Obrigatório',
                  style: _estilo(11, FontWeight.w700,
                      _erroNome ? _corErro : _corTextoSuave)),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: _corBranco,
            borderRadius: BorderRadius.circular(32),
            boxShadow: _sombraCard,
            border: _erroNome ? Border.all(color: _corErro, width: 1.5) : null,
          ),
          child: TextField(
            controller: _nome,
            textCapitalization: TextCapitalization.sentences,
            onChanged: (_) {
              if (_erroNome) setState(() => _erroNome = false);
            },
            style: _estilo(14, FontWeight.w400, _corTexto),
            decoration: InputDecoration(
              hintText: 'Ex.: Frango com Legumes Assados da Família',
              hintStyle: _estilo(14, FontWeight.w400, _corCinzaIcone),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
          ),
        ),
        if (_erroNome)
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 4),
            child: Text('Informe o nome da receita',
                style: _estilo(12, FontWeight.w400, _corErro)),
          ),
      ],
    );
  }

  //tipo de refeição (múltipla escolha)
  Widget _tipoRefeicao() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _rotulo('Tipo de refeição', 'Múltipla escolha'),
        const SizedBox(height: 4),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: [
            for (final tipo in _tiposRefeicao)
              _pilulaRefeicao(tipo, _refeicoes.contains(tipo)),
          ],
        ),
      ],
    );
  }

  Widget _pilulaRefeicao(String tipo, bool ativo) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (ativo) {
            _refeicoes.remove(tipo);
          } else {
            _refeicoes.add(tipo);
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: ativo ? _corVerde : _corBranco,
          borderRadius: BorderRadius.circular(999),
          boxShadow: _sombraLeve,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (ativo) ...[
              const Icon(Icons.check, size: 16, color: Colors.white),
              const SizedBox(width: 4),
            ],
            Text(tipo,
                style: _estilo(12, FontWeight.w600,
                    ativo ? Colors.white : _corTextoSuave,
                    espaco: 0.24)),
          ],
        ),
      ),
    );
  }

  //dificuldade
  Widget _seletorDificuldade() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text('Dificuldade',
              style: _estilo(12, FontWeight.w600, _corTexto, espaco: 0.24)),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: _corCardClaro,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            children: [
              for (int i = 0; i < _dificuldades.length; i++) ...[
                Expanded(child: _botaoDificuldade(i)),
                if (i < _dificuldades.length - 1) const SizedBox(width: 4),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _botaoDificuldade(int i) {
    final ativo = i == _dificuldade;

    return GestureDetector(
      onTap: () => setState(() => _dificuldade = i),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 36,
        decoration: BoxDecoration(
          color: ativo ? _corVerdeChip : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
          boxShadow: ativo ? _sombraLeve : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (ativo) ...[
              Icon(_iconesDificuldade[i], size: 16, color: _corVerdeChipTexto),
              const SizedBox(width: 4),
            ],
            Text(_dificuldades[i],
                style: _estilo(12, FontWeight.w600,
                    ativo ? _corVerdeChipTexto : _corTextoSuave,
                    espaco: 0.24)),
          ],
        ),
      ),
    );
  }

  //tempo de preparo e porções
  Widget _tempoEPorcoes() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _cardContador(
            icone: Icons.schedule,
            corIcone: _corVerde,
            titulo: 'Preparo',
            valor: '$_minutos',
            unidade: 'min',
            aoDiminuir: () =>
                setState(() => _minutos = (_minutos - 5).clamp(5, 180)),
            aoAumentar: () =>
                setState(() => _minutos = (_minutos + 5).clamp(5, 180)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _cardContador(
            icone: Icons.restaurant,
            corIcone: _corMarrom,
            titulo: 'Porções',
            valor: '$_porcoes',
            unidade: _porcoes == 1 ? 'porção' : 'porções',
            aoDiminuir: () =>
                setState(() => _porcoes = (_porcoes - 1).clamp(1, 24)),
            aoAumentar: () =>
                setState(() => _porcoes = (_porcoes + 1).clamp(1, 24)),
          ),
        ),
      ],
    );
  }

  Widget _cardContador({
    required IconData icone,
    required Color corIcone,
    required String titulo,
    required String valor,
    required String unidade,
    required VoidCallback aoDiminuir,
    required VoidCallback aoAumentar,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _corBranco,
        borderRadius: BorderRadius.circular(32),
        boxShadow: _sombraCard,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icone, size: 18, color: corIcone),
              const SizedBox(width: 4),
              Text(titulo,
                  style: _estilo(11, FontWeight.w700, _corTextoSuave,
                      espaco: 0.44)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _botaoContador(Icons.remove, aoDiminuir),
              Column(
                children: [
                  Text(valor, style: _estilo(18, FontWeight.w600, _corTexto)),
                  Text(unidade,
                      style: _estilo(11, FontWeight.w400, _corTextoSuave)),
                ],
              ),
              _botaoContador(Icons.add, aoAumentar),
            ],
          ),
        ],
      ),
    );
  }

  Widget _botaoContador(IconData icone, VoidCallback aoTocar) {
    return GestureDetector(
      onTap: aoTocar,
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          color: _corCinzaMedio,
          shape: BoxShape.circle,
        ),
        child: Icon(icone, size: 18, color: _corTexto),
      ),
    );
  }

  //restrições alimentares
  Widget _secaoRestricoes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _rotulo('Restrições alimentares', 'Opcional'),
        const SizedBox(height: 4),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: [
            for (int i = 0; i < _restricoes.length; i++)
              _pilulaRestricao(i),
          ],
        ),
      ],
    );
  }

  Widget _pilulaRestricao(int i) {
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
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: ativo ? _corLaranjaClaro : _corBranco,
          borderRadius: BorderRadius.circular(999),
          boxShadow: _sombraLeve,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _iconesRestricoes[i],
              size: 16,
              color: ativo
                  ? _corMarrom
                  : (i == 0 ? _corVerde : _corCinzaIcone),
            ),
            const SizedBox(width: 4),
            Text(nome,
                style: _estilo(12, FontWeight.w600,
                    ativo ? _corLaranjaEscuro : _corTextoSuave,
                    espaco: 0.24)),
          ],
        ),
      ),
    );
  }

  //ingredientes
  Widget _secaoIngredientes() {
    final n = _ingredientes.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              Text('Ingredientes',
                  style: _estilo(18, FontWeight.w600, _corTexto)),
              if (n > 0) ...[
                const SizedBox(width: 4),
                Container(
                  height: 24,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _corVerdeChip,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '$n ${n == 1 ? 'adicionado' : 'adicionados'}',
                    style: _estilo(11, FontWeight.w700, _corVerdeChipTexto),
                  ),
                ),
              ],
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 2, 4, 8),
          child: Text(
            'Separados automaticamente por corredor na lista de compras',
            style: _estilo(12, FontWeight.w400, _corTextoSuave, altura: 1.5),
          ),
        ),
        if (n == 0)
          _avisoVazio('Nenhum ingrediente ainda. Adicione o primeiro abaixo.'),
        for (int i = 0; i < n; i++) ...[
          _cardIngrediente(i),
          const SizedBox(height: 8),
        ],
        _botaoAdicionar('Adicionar ingrediente', _abrirNovoIngrediente),
      ],
    );
  }

  Widget _cardIngrediente(int i) {
    final ing = _ingredientes[i];
    final temQuantidade = ing.quantidade.isNotEmpty;
    final extenso = _unidadesExtenso[ing.unidade] ?? ing.unidade;
    final verde = ing.setor == 0; //hortifruti em verde, resto em cinza

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ing.nome,
                        overflow: TextOverflow.ellipsis,
                        style: _estilo(14, FontWeight.w600, _corTexto)),
                    if (temQuantidade)
                      Text('${ing.quantidade} $extenso',
                          style: _estilo(12, FontWeight.w400, _corTextoSuave)),
                  ],
                ),
              ),
              InkWell(
                onTap: () => setState(() => _ingredientes.removeAt(i)),
                borderRadius: BorderRadius.circular(999),
                child: const SizedBox(
                  width: 32,
                  height: 32,
                  child: Icon(Icons.delete_outline,
                      size: 18, color: _corTextoSuave),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: verde ? _corVerdeChip : _corCinzaClaro,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(_iconesSetores[ing.setor],
                        size: 16, color: verde ? _corVerde : _corMarrom),
                    const SizedBox(width: 6),
                    Text(_setores[ing.setor],
                        style: _estilo(
                            11,
                            FontWeight.w700,
                            verde ? _corVerdeChipTexto : _corTextoSuave)),
                  ],
                ),
              ),
              if (temQuantidade)
                Row(
                  children: [
                    _chipPequeno(ing.quantidade),
                    const SizedBox(width: 4),
                    _chipPequeno(ing.unidade),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chipPequeno(String texto) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: _corCinzaMedio,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(texto, style: _estilo(11, FontWeight.w700, _corTextoSuave)),
    );
  }

  //modo de preparo
  Widget _secaoPreparo() {
    final n = _passos.length;

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
              Text('$n ${n == 1 ? 'passo' : 'passos'}',
                  style: _estilo(11, FontWeight.w700, _corTextoSuave)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        if (n == 0)
          _avisoVazio('Nenhum passo ainda. Conte como fazer a receita.'),
        for (int i = 0; i < n; i++) ...[
          _cardPasso(i),
          const SizedBox(height: 8),
        ],
        _botaoAdicionar('Adicionar passo', _abrirNovoPasso),
      ],
    );
  }

  Widget _cardPasso(int i) {
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
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: _corVerde,
                  shape: BoxShape.circle,
                ),
                child: Text('${i + 1}',
                    style: _estilo(12, FontWeight.w600, Colors.white)),
              ),
              InkWell(
                onTap: () => setState(() => _passos.removeAt(i)),
                borderRadius: BorderRadius.circular(999),
                child: const SizedBox(
                  width: 32,
                  height: 32,
                  child: Icon(Icons.close, size: 18, color: _corTextoSuave),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(_passos[i],
              style: _estilo(14, FontWeight.w400, _corTexto, altura: 1.5)),
        ],
      ),
    );
  }

  //nutrição (opcional)
  Widget _secaoNutricao() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              Text('Nutrição estimada',
                  style: _estilo(18, FontWeight.w600, _corTexto)),
              const SizedBox(width: 4),
              Container(
                height: 24,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _corCinzaClaro,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text('Opcional',
                    style: _estilo(11, FontWeight.w700, _corTextoSuave)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
                child: _campoNutriente(
                    'Calorias', _kcal, 'kcal', _corVerde)),
            const SizedBox(width: 8),
            Expanded(
                child: _campoNutriente(
                    'Proteínas', _proteina, 'g', _corMarrom)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
                child: _campoNutriente(
                    'Carboidratos', _carbo, 'g', _corTexto)),
            const SizedBox(width: 8),
            Expanded(
                child: _campoNutriente(
                    'Gorduras', _gordura, 'g', _corTexto)),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              const Icon(Icons.auto_awesome, size: 16, color: _corVerde),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'Deixe em branco para estimar a partir dos ingredientes',
                  style: _estilo(12, FontWeight.w400, _corTextoSuave),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _campoNutriente(
      String titulo, TextEditingController controlador, String unidade, Color cor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _corBranco,
        borderRadius: BorderRadius.circular(32),
        boxShadow: _sombraCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo,
              style: _estilo(11, FontWeight.w700, _corTextoSuave,
                  espaco: 0.44)),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controlador,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: _estilo(18, FontWeight.w600, cor),
                  decoration: InputDecoration(
                    hintText: '0',
                    hintStyle: _estilo(18, FontWeight.w600, _corCinzaIcone),
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              Text(unidade, style: _estilo(12, FontWeight.w400, _corTextoSuave)),
            ],
          ),
        ],
      ),
    );
  }

  //peças reutilizáveis
  Widget _rotulo(String titulo, String direita) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(titulo,
              style: _estilo(12, FontWeight.w600, _corTexto, espaco: 0.24)),
          Text(direita, style: _estilo(11, FontWeight.w700, _corTextoSuave)),
        ],
      ),
    );
  }

  Widget _avisoVazio(String texto) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _corCardClaro,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Text(texto,
          textAlign: TextAlign.center,
          style: _estilo(12, FontWeight.w400, _corTextoSuave, altura: 1.5)),
    );
  }

  Widget _botaoAdicionar(String texto, VoidCallback aoTocar) {
    return InkWell(
      onTap: aoTocar,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        height: 48,
        width: double.infinity,
        decoration: BoxDecoration(
          color: _corBranco,
          borderRadius: BorderRadius.circular(999),
          boxShadow: _sombraCard,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, size: 20, color: _corVerde),
            const SizedBox(width: 4),
            Text(texto, style: _estilo(14, FontWeight.w600, _corVerde)),
          ],
        ),
      ),
    );
  }

  //barra de baixo
  Widget _barraSalvar() {
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: InkWell(
            onTap: _salvar,
            borderRadius: BorderRadius.circular(999),
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                color: _corVerde,
                borderRadius: BorderRadius.circular(999),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x141B2B20),
                    blurRadius: 16,
                    spreadRadius: -2,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check, size: 20, color: Colors.white),
                  const SizedBox(width: 4),
                  Text('Salvar receita',
                      style: _estilo(14, FontWeight.w600, Colors.white)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //folha: novo ingrediente
  void _abrirNovoIngrediente() {
    String nome = '';
    String quantidade = '';
    String unidade = 'g';
    int setor = 0;

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
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _alcaFolha(),
                      const SizedBox(height: 16),
                      Text('Novo ingrediente',
                          style: _estilo(20, FontWeight.w600, _corTexto)),
                      const SizedBox(height: 16),
                      _campoFolha('Nome do ingrediente', (v) => nome = v,
                          autofocus: true),
                      const SizedBox(height: 10),
                      _campoFolha('Quantidade (ex.: 500)', (v) => quantidade = v,
                          tipo: const TextInputType.numberWithOptions(
                              decimal: true)),
                      const SizedBox(height: 20),
                      _tituloFolha('UNIDADE'),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final u in _unidades)
                            _opcaoFolha(u, unidade == u,
                                () => setSheet(() => unidade = u)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _tituloFolha('SETOR DO MERCADO'),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (int i = 0; i < _setores.length; i++)
                            _opcaoFolha(_setores[i], setor == i,
                                () => setSheet(() => setor = i)),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _botaoFolha('Adicionar', () {
                        if (nome.trim().isEmpty) return;
                        setState(() {
                          _ingredientes.add(_Ingrediente(
                            nome: nome.trim(),
                            quantidade: quantidade.trim(),
                            unidade: unidade,
                            setor: setor,
                          ));
                        });
                        Navigator.pop(sheetContext);
                      }),
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

  //folha: novo passo
  void _abrirNovoPasso() {
    String texto = '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: _corFundo,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _alcaFolha(),
                  const SizedBox(height: 16),
                  Text('Passo ${_passos.length + 1}',
                      style: _estilo(20, FontWeight.w600, _corTexto)),
                  const SizedBox(height: 16),
                  _campoFolha('Descreva este passo', (v) => texto = v,
                      autofocus: true, linhas: 4),
                  const SizedBox(height: 24),
                  _botaoFolha('Adicionar passo', () {
                    if (texto.trim().isEmpty) return;
                    setState(() => _passos.add(texto.trim()));
                    Navigator.pop(sheetContext);
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //peças das folhas
  Widget _alcaFolha() {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: _corCinzaClaro,
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }

  Widget _tituloFolha(String texto) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(texto,
          style: _estilo(11, FontWeight.w700, _corTextoSuave, espaco: 0.44)),
    );
  }

  Widget _campoFolha(String dica, ValueChanged<String> aoMudar,
      {bool autofocus = false, TextInputType? tipo, int linhas = 1}) {
    return TextField(
      autofocus: autofocus,
      onChanged: aoMudar,
      keyboardType: linhas > 1 ? TextInputType.multiline : tipo,
      minLines: linhas,
      maxLines: linhas,
      textCapitalization: TextCapitalization.sentences,
      style: _estilo(14, FontWeight.w400, _corTexto),
      decoration: InputDecoration(
        hintText: dica,
        hintStyle: _estilo(14, FontWeight.w400, _corCinzaIcone),
        filled: true,
        fillColor: _corBranco,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(linhas > 1 ? 24 : 999),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _opcaoFolha(String texto, bool ativo, VoidCallback aoTocar) {
    return GestureDetector(
      onTap: aoTocar,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: ativo ? _corVerde : _corBranco,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(texto,
            style: _estilo(
                12, FontWeight.w600, ativo ? Colors.white : _corTextoSuave)),
      ),
    );
  }

  Widget _botaoFolha(String texto, VoidCallback aoTocar) {
    return InkWell(
      onTap: aoTocar,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        height: 52,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _corVerde,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(texto, style: _estilo(14, FontWeight.w600, Colors.white)),
      ),
    );
  }
}