import 'package:flutter/material.dart';

import '../onboding/components/Inicio.dart';




class InicioEstudianteScreen extends StatefulWidget {
  const InicioEstudianteScreen({Key? key}) : super(key: key);

  @override
  State<InicioEstudianteScreen> createState() => _InicioEstudianteScreenState();
}

class _InicioEstudianteScreenState extends State<InicioEstudianteScreen> {
  final List Cards = [
     ['ITR', 'Acerca del', 'assets/icons/ricaldone.png', 'Colegio'], 
      ['Academicos', 'Horarios', 'assets/icons/dedo.png', 'Academicos'], 
       ['Noticias', 'Comunicados', 'assets/icons/noti.png', 'Importantes']
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
