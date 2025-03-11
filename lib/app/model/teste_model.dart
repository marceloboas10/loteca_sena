class TesteModel {
  final List<String> listaDezenas;
  final int numero;
  final String dataApuracao;
  final bool acumulado;
  final int valorEstimadoProximoConcurso;
  final String dataProximoConcurso;

  TesteModel(
      {required this.listaDezenas,
      required this.numero,
      required this.dataApuracao,
      required this.acumulado,
      required this.valorEstimadoProximoConcurso,
      required this.dataProximoConcurso});

  factory TesteModel.fromMap(Map<String, dynamic> map) {
    return TesteModel(
        listaDezenas: List<String>.from((map['listaDezenas'] as List)),
        numero: map['numero'],
        dataApuracao: map['dataApuracao'],
        acumulado: map['acumulado'],
        valorEstimadoProximoConcurso: map['valorEstimadoProximoConcurso'],
        dataProximoConcurso: map['dataProximoConcurso']);
  }

  Map<String, dynamic> toMap() {
    return {
      'numero': numero,
      'dataApuracao': dataApuracao,
      'listaDezenas': listaDezenas,
      'acumulado': acumulado, 'valorEstimadoProximoConcurso': valorEstimadoProximoConcurso,
      'dataProximoConcurso': dataProximoConcurso
    };
  }
}
