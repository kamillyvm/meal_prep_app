class ListaCompras {
  final String id;
  final String nome;
  final double quantidade;
  final String unidade;
  final String setorMercado;
  final bool comprado;
  final bool isAvulso;

  const ListaCompras({
    required this.id,
    required this.nome,
    required this.quantidade,
    required this.unidade,
    this.setorMercado = 'Mercearia',
    this.comprado = false,
    this.isAvulso = false,
  });

  ListaCompras copyWith({
    String? id,
    String? nome,
    double? quantidade,
    String? unidade,
    String? setorMercado,
    bool? comprado,
    bool? isAvulso,
  }) {
    return ListaCompras(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      quantidade: quantidade ?? this.quantidade,
      unidade: unidade ?? this.unidade,
      setorMercado: setorMercado ?? this.setorMercado,
      comprado: comprado ?? this.comprado,
      isAvulso: isAvulso ?? this.isAvulso,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'quantidade': quantidade,
    'unidade': unidade,
    'setorMercado': setorMercado,
    'comprado': comprado,
    'isAvulso': isAvulso,
  };

  factory ListaCompras.fromJson(Map<String, dynamic> json) => ListaCompras(
    id: json['id'] ?? '',
    nome: json['nome'] ?? '',
    quantidade: (json['quantidade'] ?? 0.0).toDouble(),
    unidade: json['unidade'] ?? '',
    setorMercado: json['setorMercado'] ?? 'Mercearia',
    comprado: json['comprado'] ?? false,
    isAvulso: json['isAvulso'] ?? false,
  );
}