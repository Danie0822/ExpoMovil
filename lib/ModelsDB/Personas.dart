// clase de personas de la base 
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

 // llamada a la api para obtener los datos en formato json 
  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      idPersona: json['idPersona'] ?? 0,
      codigo: json['codigo']?? '',
      nombrePersona: json['nombrePersona']?? '',
      apellidoPersona: json['apellidoPersona']?? '',
      nacimientoPersona: json['nacimientoPersona']?? '',
      idTipoPersona: json['idTipoPersona'] ?? 0,
      correo: json['correo']?? '',
      claveCredenciales: json['claveCredenciales'] ?? '',
      foto: json['foto'] ?? '',
    );
  }
}
