
import 'package:flutter/cupertino.dart';
import 'package:SistemaExpo/screens/home/home_screen.dart';

class Menu2 {
   late Widget Pantlla = HomeScreen();
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