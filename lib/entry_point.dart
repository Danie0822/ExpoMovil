
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:SistemaExpo/constants.dart';
import 'package:SistemaExpo/screens/onboding/components/menu.dart';
import 'package:SistemaExpo/utils/rive_utils.dart';
import 'components/animated_bar.dart';
import 'components/menu.dart';
import 'models/rive_asset.dart';


class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> ScaleAnimation;
  RiveAsset selectedBottomNav = bottomNavs.first;
  late SMIBool isMenuOpen;
  bool IsSideMenuClose = true;
  bool cambioWidget = false;
  bool isSideMenuClose = true;
 RiveAsset selectedMenu = sideMenus.first;
  
  

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
            child:  MenuScreen(onMenuSelected: (menu){
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
                    borderRadius: BorderRadius.all(Radius.circular(24)),
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
      bottomNavigationBar: Transform.translate(
          offset: Offset(0, 100* animation.value),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: backgroundColor2.withOpacity(0.8),
              borderRadius: const BorderRadius.all(Radius.circular(24)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...List.generate(
                  bottomNavs.length,
                  (index) => GestureDetector(
                    onTap: () {
                      bottomNavs[index].input!.change(true);
                      if (bottomNavs[index] != selectedBottomNav) {
                        setState(() {
                          selectedBottomNav = bottomNavs[index];
                        });
                      }
                      Future.delayed(const Duration(seconds: 1), () {
                        bottomNavs[index].input!.change(false);
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedBar(
                            isActive: bottomNavs[index] == selectedBottomNav),
                        SizedBox(
                          height: 36,
                          width: 36,
                          child: Opacity(
                            opacity:
                                bottomNavs[index] == selectedBottomNav ? 1 : 0.5,
                            child: RiveAnimation.asset(
                              bottomNavs.first.src,
                              artboard: bottomNavs[index].artboard,
                              onInit: (artboard) {
                                StateMachineController controller =
                                    RiveUtils.getRiveController(artboard,
                                        stateMachineName:
                                            bottomNavs[index].stateMachineName);
      
                                bottomNavs[index].input =
                                    controller.findSMI("active") as SMIBool;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
