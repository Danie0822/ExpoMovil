import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:sistema_expo/utils/rive_utils.dart';

import '../../../ModelsDB/Providers/Personas.dart';
import '../../../components/EntradaMenu.dart';
import '../../../components/listaMenu.dart';
import '../../../models/menu.dart';
import '../../../models/rive_asset.dart';

class MenuDocenteScreen extends StatefulWidget {
  final Function(RiveAsset menu) onMenuSelected;

  const MenuDocenteScreen({Key? key, required this.onMenuSelected})
      : super(key: key);

  @override
  State<MenuDocenteScreen> createState() => _MenuDocenteScreenState();
}

class _MenuDocenteScreenState extends State<MenuDocenteScreen> {
  RiveAsset selectedMenu = sideMenus2.first;

  @override
  Widget build(BuildContext context) {
    final personas = Provider.of<Personas>(context, listen: false);
    String Name = personas.person.nombrePersona;
    int Tipo = personas.person.idTipoPersona;
    String Foto = personas.person.foto;
    String texto;
    if (Tipo == 1) {
      texto = "Docente";
    } else if (Tipo == 2) {
      texto = "Estudiante";
    } else {
      texto = "Valor no válido";
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // design of widget
      resizeToAvoidBottomInset: false,
      body: Container(
        width: screenWidth * 0.8, // Adjust container width as needed
        height: screenHeight, // Use full screen height
        color: const Color(0xFF17203A),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Entrada(Name: Name, Rol: texto, Foto: Foto),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 20, bottom: 10),
                child: Text(
                  'Menu'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ...sideMenus2.map(
                      (menu) => MenuListScreen(
                        menu: menu,
                        riveonInit: (artboard) {
                          StateMachineController controller =
                              RiveUtils.getRiveController(artboard,
                                  stateMachineName: menu.stateMachineName);
                          menu.input =
                              controller.findSMI('active') as SMIBool;
                        },
                        press: () {
                          menu.input!.change(true);
                          Menu2().WingetsRw(menu.Pantlla);
                          widget.onMenuSelected(menu);
                          menu.input!.change(true);
                          Future.delayed(Duration(seconds: 1), () {
                            menu.input!.change(false);
                          });
                          Future.delayed(Duration(seconds: 1), () {
                            menu.input!.change(false);
                          });
                          setState(() {
                            selectedMenu = menu;
                          });
                        },
                        IsActive: selectedMenu == menu,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 0, bottom: 10),
                child: Text(
                  'Adicionar'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ...sideMenu22.map(
                      (menu) => MenuListScreen(
                        menu: menu,
                        riveonInit: (artboard) {
                          StateMachineController controller =
                              RiveUtils.getRiveController(artboard,
                                  stateMachineName: menu.stateMachineName);
                          menu.input =
                              controller.findSMI('active') as SMIBool;
                        },
                        press: () {
                          menu.input!.change(true);
                          Menu2().WingetsRw(menu.Pantlla);
                          widget.onMenuSelected(menu);
                          menu.input!.change(true);
                          Future.delayed(Duration(seconds: 1), () {
                            menu.input!.change(false);
                          });
                          Future.delayed(Duration(seconds: 1), () {
                            menu.input!.change(false);
                          });
                          setState(() {
                            selectedMenu = menu;
                          });
                        },
                        IsActive: selectedMenu == menu,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
