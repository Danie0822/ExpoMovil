import 'package:flutter/foundation.dart';

import '../Personas.dart';

class PersonProvider with ChangeNotifier {
  late Person _person;

  Person get person => _person;

  void setPerson(Person person) {
    _person = person;
    notifyListeners();
  }
}
