import 'package:flutter/material.dart';

import 'Inicio.dart';
import '../pantallas/AcercaDe.dart';
import '../Post/ReservacionesPost.dart';
// inicio de de docente 


class InicioDocenteScreen extends StatefulWidget {
  const InicioDocenteScreen({Key? key}) : super(key: key);

  @override
  State<InicioDocenteScreen> createState() => _InicioDocenteScreenState();
}

class _InicioDocenteScreenState extends State<InicioDocenteScreen> {
  // llamadas de tarjetas de inicio 
  final List Cards = [
    ['ITR', 'Acerca del', 'assets/icons/ricaldone.png', 'Colegio', RecipeDetailScreen()],
    ['Gestión', 'Reserva Salones', 'assets/icons/noti.png', 'Importantes', ReservacioneScreen()]
  ];
// ya no se usa xd 
  final List CardList = [
    ['Un comunicado', 'Se ha enviado', 'assets/icons/Notifi1.png', 'Importante', Colors.red],
    ['Leve', 'Codigo', 'assets/icons/Notifi1.png', 'Adventicia', Colors.orange],
    ['Codigo', 'Positivo', 'assets/icons/Notifi1.png', 'Aviso', Colors.green]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // llamada de un nuevo widget 
      backgroundColor: Colors.white,
      body: Colum(Cards: Cards, CardList: CardList),
    );
  }
}
