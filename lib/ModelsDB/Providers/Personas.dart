import 'package:flutter/foundation.dart';

class Personas extends ChangeNotifier {
  int _idPersona = 1;

  int get idPersona {
    return _idPersona;
  }

  set idPersona(int value) {
    _idPersona = value;
    notifyListeners();
  }
}