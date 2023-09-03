import 'dart:math';
import 'package:SistemaExpo/screens/onboding/components/MenuDocente.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:SistemaExpo/constants.dart';
import 'package:SistemaExpo/utils/rive_utils.dart';
import 'components/menu.dart';
import 'models/rive_asset.dart';
// pantalla de dashboard de docente 
class DashboardDocenteScreen extends StatefulWidget {
   
  const DashboardDocenteScreen({Key? key}) : super(key: key);

  @override
  State<DashboardDocenteScreen> createState() => _DashboardDocenteScreenState();
}

class _DashboardDocenteScreenState extends State<DashboardDocenteScreen> with SingleTickerProviderStateMixin {
  // animaciones 
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> ScaleAnimation;
  RiveAsset selectedBottomNav = bottomNavs.first;
  late SMIBool isMenuOpen;
  bool IsSideMenuClose = true;
  bool cambioWidget = false;
  bool isSideMenuClose = true;
 RiveAsset selectedMenu = sideMenus2.first;
 
  
  

  void toggleSideMenu() {
    setState(() {
      isSideMenuClose = !isSideMenuClose;
    });
  }

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(microseconds:200 ),
    )..addListener(() {
  
      setState(() {
        
      });
    });
    animation = Tween<double>(begin: 0, end:1 ).animate(CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn));
    ScaleAnimation = Tween<double>(begin: 1, end:0.8 ).animate(CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
    
  }
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // diseño que hay de en dicha pestaña 
      backgroundColor: backgroundColor2,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(microseconds: 200),
            curve: Curves.fastOutSlowIn,
            width: 288,
            left: IsSideMenuClose? -288: 0,
            height: MediaQuery.of(context).size.height,
            child:  MenuDocenteScreen(onMenuSelected: (menu){
              setState(() {
                selectedMenu = menu;
              });
            }) ,
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..setEntry(3,2, 0.001)..rotateY(animation.value -30 * animation.value * pi/180),
            child: Transform.translate(
                offset:  Offset(animation.value * 250, 0),
                child: Transform.scale(
                  scale: ScaleAnimation.value,
                  child:  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular( IsSideMenuClose?0: 24)),
                    child:selectedMenu.Pantlla))),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: IsSideMenuClose ? 0:220,
            top: 16,
            child: MenuBtnScreen(
              riveOnInit: (artboard) {
                StateMachineController controller = RiveUtils.getRiveController(
                    artboard,
                    stateMachineName: 'State Machine');
                isMenuOpen = controller.findSMI('isOpen') as SMIBool;
                isMenuOpen.value = true;
              },
              press: () {
                isMenuOpen.value = !isMenuOpen.value;
                if(IsSideMenuClose){
                  _animationController.forward();
                }
                else{
                  _animationController.reverse();
                }
                setState(() {
                IsSideMenuClose = isMenuOpen.value;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}