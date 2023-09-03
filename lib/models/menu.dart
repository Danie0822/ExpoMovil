
import 'package:flutter/cupertino.dart';

import '../screens/home/dashboard.dart';
// clase con lo que funciona el menu 
class Menu2 {
  // se obtiene la pantalla que se cambia  
   late Widget Pantlla = InicioEstudianteScreen();
   late bool  input = false;

     Widget WingetsRw(Widget Pantlla) {
    return this.Pantlla = Pantlla;
  }
    bool boole(bool input) {
    return this.input = input;
  }
      bool boolee() {
    return this.input ;
  }

    Widget WingetsR() {
    return this.Pantlla;
  }
  
  
  set name(Widget newPantlla) {
    Pantlla = newPantlla;
  }
}