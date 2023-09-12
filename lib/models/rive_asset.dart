import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:sistema_expo/screens/home/home_screen.dart';

import '../screens/home/components/InicioDocente.dart';
import '../screens/home/dashboard.dart';
import '../screens/pantallas/Asitencia.dart';
import '../screens/pantallas/Codigos.dart';
import '../screens/pantallas/CodigosPost.dart';
import '../screens/pantallas/Comunicados.dart';
import '../screens/pantallas/Horarios.dart';
import '../screens/pantallas/Inasistencias.dart';
import '../screens/pantallas/LlegadasTardesGet.dart';
import '../screens/pantallas/LlegadasTardesPost.dart';
import '../screens/pantallas/Notificaciones.dart';
import '../screens/pantallas/ObservacionesPost.dart';
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

List<RiveAsset> bottomNavs = [
  RiveAsset("assets/RiveAssets/icons.riv",
      artboard: "CHAT", stateMachineName: "CHAT_Interactivity", title: "Chat", Pantlla: HomeScreen()),
  RiveAsset("assets/RiveAssets/icons.riv",
      artboard: "LIKE/STAR",
      stateMachineName: "STAR_Interactivity",
      title: "Estrella", Pantlla: HomeScreen()),
  RiveAsset("assets/RiveAssets/icons.riv",
      artboard: "TIMER",
      stateMachineName: "TIMER_Interactivity",
      title: "Chat", Pantlla: HomeScreen()),
  RiveAsset("assets/RiveAssets/icons.riv",
      artboard: "BELL",
      stateMachineName: "BELL_Interactivity",
      title: "Notifications", Pantlla: HomeScreen()),
  RiveAsset("assets/RiveAssets/icons.riv",
      artboard: "USER",
      stateMachineName: "USER_Interactivity",
      title: "Profile", Pantlla: HomeScreen()),
];

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