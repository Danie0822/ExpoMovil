class Observaciones {
  final int idObservacion;
  final int idPeriodo;
  final DateTime fecha;
  final String detalle;
  final int idEstudiante;
  final String estudiante;
  final String docente;

  Observaciones({
    required this.idObservacion,
    required this.idPeriodo,
    required this.fecha,
    required this.detalle,
    required this.idEstudiante,
    required this.estudiante,
    required this.docente,
  });

  factory Observaciones.fromJson(Map<String, dynamic> json) {
    return Observaciones(
      idObservacion: json['idObservacion'] ?? 0,
      idPeriodo: json['idPeriodo'] ?? 0,
      fecha: DateTime.parse(json['fecha'] ?? ''),
      detalle: json['detalle'] ?? '',
      idEstudiante: json['idEstudiante'] ?? 0,
      estudiante: json['estudiante'] ?? '',
      docente: json['docente'] ?? '',
    );
  }
}