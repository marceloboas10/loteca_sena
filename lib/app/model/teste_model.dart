class TesteModel {
  final List<String> dezenas;
  final int concurso;
  final String data;
  final bool acumulou;
  final double valorEstimadoProximoConcurso;
  final String dataProximoConcurso;

  TesteModel(
      {required this.dezenas,
      required this.concurso,
      required this.data,
      required this.acumulou,
      required this.valorEstimadoProximoConcurso,
      required this.dataProximoConcurso});

  factory TesteModel.fromMap(Map<String, dynamic> map) {
    return TesteModel(
        dezenas: List<String>.from((map['dezenas'] as List)),
        concurso: map['concurso'],
        data: map['data'],
        acumulou: map['acumulou'],
        valorEstimadoProximoConcurso: map['valorEstimadoProximoConcurso'],
        dataProximoConcurso: map['dataProximoConcurso']);
  }

  Map<String, dynamic> toMap() {
    return {
      'concurso': concurso,
      'data': data,
      'dezenas': dezenas,
      'acumulou': acumulou, 'valorEstimadoProximoConcurso': valorEstimadoProximoConcurso,
      'dataProximoConcurso': dataProximoConcurso
    };
  }
}
