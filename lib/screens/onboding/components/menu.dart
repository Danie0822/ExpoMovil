import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:sistema_expo/utils/rive_utils.dart';

import '../../../ModelsDB/Providers/Personas.dart';
import '../../../components/Entrada.dart';
import '../../../components/listaMenu.dart';
import '../../../models/menu.dart';
import '../../../models/rive_asset.dart';
// menu osea el menu que manda a llamar a todos los widget para dibujarse 
class MenuScreen extends StatefulWidget {
  final Function(RiveAsset menu) onMenuSelected;

  const MenuScreen({super.key, required this.onMenuSelected});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  RiveAsset selectedMenu = sideMenus.first;
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
    return Scaffold(
      body: Container(
        // diseño de la pantalla 
        width: 288,
        height: double.infinity,
        color: const Color(0xFF17203A),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Entrada(Name: Name, Rol: texto,Foto: Foto),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text('Menu'.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white70)),
              ),
              ...sideMenus.map(
                (menu) => MenuListScreen(
                  menu: menu,
                  riveonInit: (artboard) {
                    StateMachineController controller =
                        RiveUtils.getRiveController(artboard,
                            stateMachineName: menu.stateMachineName);
                    menu.input = controller.findSMI('active') as SMIBool;
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
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text('Adicionar'.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white70)),
              ),
              ...sideMenu2.map(
                (menu) => MenuListScreen(
                  menu: menu,
                  riveonInit: (artboard) {
                    StateMachineController controller =
                        RiveUtils.getRiveController(artboard,
                            stateMachineName: menu.stateMachineName);
                    menu.input = controller.findSMI('active') as SMIBool;
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
      ),
    );
  }
}
