import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../screens/InicioCarrusel/InicioDocente.dart';
import '../screens/InicioCarrusel/InicioAlumno.dart';
import '../screens/Post/Asitencia.dart';
import '../screens/Get/Codigos.dart';
import '../screens/Post/CodigosPost.dart';
import '../screens/Get/Comunicados.dart';
import '../screens/Get/Inasistencias.dart';
import '../screens/Get/LlegadasTardesGet.dart';
import '../screens/Post/LlegadasTardesPost.dart';
import '../screens/Get/Observaciones.dart';
import '../screens/Post/ObservacionesPost.dart';
import '../screens/pantallas/Perfil.dart';
// lista de del menu 
class RiveAsset {
  final String artboard, stateMachineName, title, src;
  late SMIBool? input;
  Widget Pantlla; 

  RiveAsset(this.src,
      {required this.artboard,
      required this.stateMachineName,
      required this.title,
      required this.Pantlla,
      this.input});


  set setInput(SMIBool status) {
    input = status;
  }
}



List<RiveAsset> sideMenus = [
  RiveAsset('assets/RiveAssets/icons.riv', artboard: 'HOME', stateMachineName: 'HOME_interactivity', title: 'Inicio', Pantlla: InicioEstudianteScreen()), 
  RiveAsset('assets/RiveAssets/icons.riv', artboard: 'SEARCH', stateMachineName: 'SEARCH_Interactivity', title: 'Codigos', Pantlla: DisciplinaApp()),
     RiveAsset('assets/RiveAssets/icons.riv', artboard: 'LIKE/STAR', stateMachineName: 'STAR_Interactivity', title: 'Observaciones', Pantlla: NotificacionesPantalla()),
      RiveAsset('assets/RiveAssets/icons.riv', artboard: 'BELL', stateMachineName: 'BELL_Interactivity', title: 'Inasistencias', Pantlla: InasistenciasScreen()),
       RiveAsset('assets/RiveAssets/icons.riv', artboard: 'TIMER', stateMachineName: 'TIMER_Interactivity', title: 'LLegadas Tarde', Pantlla: LLegadasTardesGetScreen()),
  
];

List<RiveAsset> sideMenu2 = [
   RiveAsset('assets/RiveAssets/icons.riv', artboard: 'CHAT', stateMachineName: 'CHAT_Interactivity', title: 'Comunicados', Pantlla: ComunicadosScreen()),
  RiveAsset('assets/RiveAssets/icons.riv', artboard: 'USER', stateMachineName: 'USER_Interactivity', title: 'Perfil', Pantlla: ProfileScreen()),
];

List<RiveAsset> sideMenus2 = [
  RiveAsset('assets/RiveAssets/icons.riv', artboard: 'HOME', stateMachineName: 'HOME_interactivity', title: 'Inicio', Pantlla: InicioDocenteScreen()), 
  RiveAsset('assets/RiveAssets/icons.riv', artboard: 'SEARCH', stateMachineName: 'SEARCH_Interactivity', title: 'Codigos', Pantlla: SearchBarWidget()),
 RiveAsset('assets/RiveAssets/icons.riv', artboard: 'LIKE/STAR', stateMachineName: 'STAR_Interactivity', title: 'Observaciones', Pantlla: ObservacionesSearchBar()),
  RiveAsset('assets/RiveAssets/icons.riv', artboard: 'BELL', stateMachineName: 'BELL_Interactivity', title: 'Llegadas Tarde', Pantlla: LlegadasPostScreen()),
  RiveAsset('assets/RiveAssets/icons.riv', artboard: 'TIMER', stateMachineName: 'TIMER_Interactivity', title: 'Inasistencias', Pantlla: AsistenciaScreen()),
];
List<RiveAsset> sideMenu22 = [
  RiveAsset('assets/RiveAssets/icons.riv', artboard: 'CHAT', stateMachineName: 'CHAT_Interactivity', title: 'Comunicados', Pantlla: ComunicadosScreen()),
  RiveAsset('assets/RiveAssets/icons.riv', artboard: 'USER', stateMachineName: 'USER_Interactivity', title: 'Perfil', Pantlla: ProfileScreen()),
];