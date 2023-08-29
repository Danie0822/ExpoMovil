class Inasisitencias {
  final int idInasistencia;
  final String TipoLlegadaTarde;
  final DateTime fecha;
  final int estado;
  final int idEstudiante;
  final String estudiante;
  final String docente;
  final int idPeriodo; 

  Inasisitencias(  {
    required this.idInasistencia,
    required this.TipoLlegadaTarde,
    required this.fecha,
    required this.estado,
    required this.idEstudiante,
    required this.estudiante,
    required this.docente, required this.idPeriodo,
  });

  factory Inasisitencias.fromJson(Map<String, dynamic> json) {
    return Inasisitencias(
      idPeriodo:json['idPeriodo'] ?? 0,
      idInasistencia: json['idInasistencia'] ?? 0,
      TipoLlegadaTarde: json['TipoLlegadaTarde'] ?? '',
      fecha: DateTime.parse(json['fecha'] ?? ''),
      estado: json['estado'] ?? 0,
      idEstudiante: json['idEstudiante'] ?? 0,
      estudiante: json['estudiante'] ?? '',
      docente: json['docente'] ?? '',
    );
  }
}