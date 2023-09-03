// clase de notificaciones de la base 
class Notificaciones {
  final int idNotificacion;
  final String detalle;
  final String tipoNotificacion;
  final int idPersona;
  Notificaciones( {
    required this.idNotificacion,
    required this.detalle,
    required this.tipoNotificacion,
    required this.idPersona,
  });
  // llamada de la api en formato json osea convierte a datos normales 
  factory Notificaciones.fromJson(Map<String, dynamic> json) {
    return Notificaciones(
      idNotificacion: json['idNotificacion'] ?? 0,
      detalle: json['detalle'] ?? '',
      tipoNotificacion: json['tipoNotificacion'] ?? '',
      idPersona: json['idPersona'] ?? 0,
    );
  }
}