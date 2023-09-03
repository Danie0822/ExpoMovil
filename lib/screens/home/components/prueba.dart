
import 'package:flutter/material.dart';
// esto es para saber el cambio entre pantalla 
class MiClase extends StatefulWidget {
  @override
  _MiClaseState createState() => _MiClaseState();
}

class _MiClaseState extends State<MiClase> {
  // estado para saber esto 
  bool cambioWidget = false;

  void cambiarWidget(bool nuevoValor) {
    setState(() {
      cambioWidget = nuevoValor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

    );
  }
}


