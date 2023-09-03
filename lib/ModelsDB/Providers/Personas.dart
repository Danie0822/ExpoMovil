import 'package:flutter/foundation.dart';

import '../Personas.dart';
// clase de personas 
class Personas extends ChangeNotifier {
  Person _person = Person(
    idPersona: 0,
    codigo: '',
    nombrePersona: '',
    apellidoPersona: '',
    nacimientoPersona: '',
    idTipoPersona: 0,
    correo: '',
    claveCredenciales: '',
    foto: '',
  );

  Person get person {
    return _person;
  }

  set person(Person value) {
    _person = value;
    notifyListeners();
  }
}
