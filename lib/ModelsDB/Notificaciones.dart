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
  factory Notificaciones.fromJson(Map<String, dynamic> json) {
    return Notificaciones(
      idNotificacion: json['idNotificacion'] ?? 0,
      detalle: json['detalle'] ?? '',
      tipoNotificacion: json['tipoNotificacion'] ?? '',
      idPersona: json['idPersona'] ?? 0,
    );
  }
}