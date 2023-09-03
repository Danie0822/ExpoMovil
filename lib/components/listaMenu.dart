import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import '../models/rive_asset.dart';
// menu osea el diseño 
class MenuListScreen extends StatelessWidget {
  
  const MenuListScreen({Key? key, required this.menu, required this.press, required this.riveonInit, required this.IsActive}) : super(key: key);
  final RiveAsset menu; 
  final VoidCallback press; 
  final ValueChanged<Artboard>riveonInit;
  final bool IsActive ; 
  

  @override
  Widget build(BuildContext context) {
    return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: Divider(color: Colors.white24, height: 1),
                ),
                Stack(
                  // se estrablece el tamaño
                  children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.fastOutSlowIn,
                      height:56 ,
                      width: IsActive? 288: 0 ,
                      left: 0,
                      child: Container(decoration:const  BoxDecoration(color: Color(0xFF6792FF),
                      borderRadius:  BorderRadius.all(Radius.circular(10)),
                       )),
                    ),
                    ListTile(
                      // es un botom de abrir y cerrar el menu 
                      onTap:  press,
                      leading: SizedBox(
                        height: 34,
                        width: 34,
                        child: RiveAnimation.asset(menu.src,
                        artboard: menu.artboard,
                        onInit: riveonInit,
                        ),   
                      ),
                      title:  Text(menu.title, style: const  TextStyle(color: Colors.white)),

                    ),
                  ],
                ),
              ],
            );
  }
}