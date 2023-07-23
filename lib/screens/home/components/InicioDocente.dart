import 'package:flutter/material.dart';

import '../../onboding/components/Inicio.dart';
import '../../pantallas/AcercaDe.dart';
import '../../pantallas/Horarios.dart';
import '../../pantallas/ReservacionesPost.dart';



class InicioDocenteScreen extends StatefulWidget {
  const InicioDocenteScreen({Key? key}) : super(key: key);

  @override
  State<InicioDocenteScreen> createState() => _InicioDocenteScreenState();
}

class _InicioDocenteScreenState extends State<InicioDocenteScreen> {
  final List Cards = [
    ['ITR', 'Acerca del', 'assets/icons/ricaldone.png', 'Colegio', RecipeDetailScreen()],
    ['Educación', 'Horarios', 'assets/icons/dedo.png', 'Clase', HorariosScreen()],
    ['Gestión', 'Reserva Salones', 'assets/icons/noti.png', 'Importantes', ReservacioneScreen()]
  ];

  final List CardList = [
    ['Un comunicado', 'Se ha enviado', 'assets/icons/Notifi1.png', 'Importante', Colors.red],
    ['Leve', 'Codigo', 'assets/icons/Notifi1.png', 'Adventicia', Colors.orange],
    ['Codigo', 'Positivo', 'assets/icons/Notifi1.png', 'Aviso', Colors.green]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Colum(Cards: Cards, CardList: CardList),
    );
  }
}
