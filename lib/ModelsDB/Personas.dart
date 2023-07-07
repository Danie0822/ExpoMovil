class Person {

  final int idPersona;
  final String codigo;
  final String nombrePersona;
  final String apellidoPersona;
  final String nacimientoPersona;
  late final int idTipoPersona;
  final String correo;
  final String claveCredenciales;
  final String foto;

  Person({
    required this.idPersona,
    required this.codigo,
    required this.nombrePersona,
    required this.apellidoPersona,
    required this.nacimientoPersona,
    required this.idTipoPersona,
    required this.correo,
    required this.claveCredenciales,
    required this.foto,
  });

 
  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      idPersona: json['idPersona'],
      codigo: json['codigo'],
      nombrePersona: json['nombrePersona'],
      apellidoPersona: json['apellidoPersona'],
      nacimientoPersona: json['nacimientoPersona'],
      idTipoPersona: json['idTipoPersona'],
      correo: json['correo'],
      claveCredenciales: json['claveCredenciales'],
      foto: json['foto'],
    );
  }
}
