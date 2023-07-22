import 'package:flutter/material.dart';

import '../onboding/components/Inicio.dart';
import '../pantallas/AcercaDe.dart';
import '../pantallas/EnfermeriaView.dart';
import '../pantallas/Permisos.dart';




class InicioEstudianteScreen extends StatefulWidget {
  const InicioEstudianteScreen({Key? key}) : super(key: key);

  @override
  State<InicioEstudianteScreen> createState() => _InicioEstudianteScreenState();
}

class _InicioEstudianteScreenState extends State<InicioEstudianteScreen> {
  final List Cards = [
     ['ITR', 'Acerca del', 'assets/icons/ricaldone.png', 'Colegio', RecipeDetailScreen()], 
      ['Salud', 'Visitas Enfermeria', 'assets/icons/dedo.png', 'Salud', VisitaEnfermeria()], 
       ['Noticias', 'Permisos', 'assets/icons/noti.png', 'Importantes', PermisosScreen()]
  ]; 

    // ignore: non_constant_identifier_names
    final List CardList = [
     ['Un conmunicado', 'Se a enviando', 'assets/icons/Notifi1.png', 'Importante', Colors.red], 
      ['Leve', 'Codigo', 'assets/icons/Notifi1.png', 'Adventicia',Colors.orange], 
       ['Codigo', 'Positivo', 'assets/icons/Notifi1.png', 'Aviso', Colors.green]
  ]; 
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:  Colum(Cards: Cards, CardList: CardList),
        
      
    );
  }
}