// clase de Inasisitencias de ka base 
class LlegadasTardes {
  final int idLlegadaTarde;
  final String TipoLlegadaTarde;
  final DateTime fecha;
  final int estado;
  final int idEstudiante;
  final String estudiante;
  final String docente;
  final int idPeriodo; 

  LlegadasTardes(  {
    required this.idLlegadaTarde,
    required this.TipoLlegadaTarde,
    required this.fecha,
    required this.estado,
    required this.idEstudiante,
    required this.estudiante,
    required this.docente, required this.idPeriodo,
  });
//  llamada la api para la conversion de json a datos normales 
  factory LlegadasTardes.fromJson(Map<String, dynamic> json) {
    return LlegadasTardes(
      idPeriodo:json['idPeriodo'] ?? 0,
      idLlegadaTarde: json['idLlegadaTarde'] ?? 0,
      TipoLlegadaTarde: json['tipoLlegadaTarde'] ?? '',
      fecha: DateTime.parse(json['fecha'] ?? ''),
      estado: json['estado'] ?? 0,
      idEstudiante: json['idEstudiante'] ?? 0,
      estudiante: json['estudiante'] ?? '',
      docente: json['docente'] ?? '',
    );
  }
}