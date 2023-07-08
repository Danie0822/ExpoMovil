class Codigos {
  final int idCodigoConductualPersona;
  final int idPeriodo;
  final DateTime fecha;
  final String tipoCodigoConductual;
  final int idEstudiante;
  final String estudiante;
  final String docente;
  final String codigoConductual; 

  Codigos( {
    required this.idCodigoConductualPersona,
    required this.idPeriodo,
    required this.fecha,
    required this.tipoCodigoConductual,
    required this.idEstudiante,
    required this.estudiante,
    required this.docente,
    required this.codigoConductual
  });

  factory Codigos.fromJson(Map<String, dynamic> json) {
    return Codigos(
      codigoConductual: json['codigoConductual'] ?? '',
      idCodigoConductualPersona: json['idCodigoConductualPersona'] ?? 0,
      idPeriodo: json['idPeriodo'] ?? 0,
      fecha: DateTime.parse(json['fecha'] ?? ''),
      tipoCodigoConductual: json['tipoCodigoConductual'] ?? '',
      idEstudiante: json['idEstudiante'] ?? 0,
      estudiante: json['estudiante'] ?? '',
      docente: json['docente'] ?? '', 
    
    );
  }
}