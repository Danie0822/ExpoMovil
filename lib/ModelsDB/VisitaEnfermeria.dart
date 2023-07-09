class VisitasEnfermeria {
  final int idVisitaEnfermeria;
  final int idPeriodo;
  final DateTime fecha;
  final String detalleVisitia;
  final int idPersona;
  final String persona;

  VisitasEnfermeria( {
    required this.idVisitaEnfermeria,
    required this.idPeriodo,
    required this.fecha,
    required this.detalleVisitia,
    required this.idPersona,
    required this.persona,
  });

  factory VisitasEnfermeria.fromJson(Map<String, dynamic> json) {
    return VisitasEnfermeria(
      idVisitaEnfermeria: json['idVisitaEnfermeria'] ?? 0,
      idPeriodo: json['idPeriodo'] ?? 0,
      fecha: DateTime.parse(json['fecha'] ?? ''),
      detalleVisitia: json['detalleVisitia'] ?? '',
      idPersona: json['idPersona'] ?? 0,
      persona: json['persona'] ?? '', 
    
    );
  }
}