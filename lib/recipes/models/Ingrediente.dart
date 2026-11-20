class Ingrediente {
  final String nome;
  final double quantidade;
  final String unidade;
  final String setorMercado;

  Ingrediente({
    required this.nome,
    required this.quantidade,
    required this.unidade,
    required this.setorMercado,
  });

  Ingrediente copyWith({
    String? nome,
    double? quantidade,
    String? unidade,
    String? setorMercado,
  }) {
    return Ingrediente(
      nome: nome ?? this.nome,
      quantidade: quantidade ?? this.quantidade,
      unidade: unidade ?? this.unidade,
      setorMercado: setorMercado ?? this.setorMercado,
    );
  }

  factory Ingrediente.fromJson(Map<String, dynamic> json) {
    return Ingrediente(
      nome: json['nome'] ?? '',
      quantidade: (json['quantidade'] ?? 0.0).toDouble(),
      unidade: json['unidade'] ?? '',
      setorMercado: json['setorMercado'] ?? 'Mercearia',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'quantidade': quantidade,
      'unidade': unidade,
      'setorMercado': setorMercado,
    };
  }
}