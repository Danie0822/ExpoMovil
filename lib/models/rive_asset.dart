import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:SistemaExpo/screens/home/home_screen.dart';

import '../screens/home/dashboard.dart';
import '../screens/pantallas/Codigos.dart';
import '../screens/pantallas/EnfermeriaView.dart';
import '../screens/pantallas/Notificaciones.dart';

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
  RiveAsset('assets/RiveAssets/icons.riv', artboard: 'CHAT', stateMachineName: 'CHAT_Interactivity', title: 'Comunicados', Pantlla: VisitaEnfermeria()),
  RiveAsset('assets/RiveAssets/icons.riv', artboard: 'TIMER', stateMachineName: 'TIMER_Interactivity', title: 'Horarios', Pantlla: HomeScreen()),
];

List<RiveAsset> sideMenu2 = [
  RiveAsset('assets/RiveAssets/icons.riv', artboard: 'LIKE/STAR', stateMachineName: 'STAR_Interactivity', title: 'Observaciones', Pantlla: NotificacionesPantalla()),
  RiveAsset('assets/RiveAssets/icons.riv', artboard: 'USER', stateMachineName: 'USER_Interactivity', title: 'Ajuste', Pantlla: HomeScreen()),
];

List<RiveAsset> sideMenus2 = [
  RiveAsset('assets/RiveAssets/icons.riv', artboard: 'HOME', stateMachineName: 'HOME_interactivity', title: 'Inicio', Pantlla: InicioEstudianteScreen()), 
  RiveAsset('assets/RiveAssets/icons.riv', artboard: 'SEARCH', stateMachineName: 'SEARCH_Interactivity', title: 'Codigos', Pantlla: DisciplinaApp()),
 RiveAsset('assets/RiveAssets/icons.riv', artboard: 'LIKE/STAR', stateMachineName: 'STAR_Interactivity', title: 'Observaciones', Pantlla: NotificacionesPantalla()),
  RiveAsset('assets/RiveAssets/icons.riv', artboard: 'TIMER', stateMachineName: 'TIMER_Interactivity', title: 'Horarios', Pantlla: HomeScreen()),
];
List<RiveAsset> sideMenu22 = [
  RiveAsset('assets/RiveAssets/icons.riv', artboard: 'CHAT', stateMachineName: 'CHAT_Interactivity', title: 'Comunicados', Pantlla: VisitaEnfermeria()),
  RiveAsset('assets/RiveAssets/icons.riv', artboard: 'USER', stateMachineName: 'USER_Interactivity', title: 'Ajuste', Pantlla: HomeScreen()),
];