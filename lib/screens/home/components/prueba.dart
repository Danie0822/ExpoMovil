
import 'package:flutter/material.dart';

class MiClase extends StatefulWidget {
  @override
  _MiClaseState createState() => _MiClaseState();
}

class _MiClaseState extends State<MiClase> {
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


