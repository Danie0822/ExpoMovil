import 'package:flutter/material.dart';

import 'sign_in_form.dart';
// Dialog de login osea el ingresar del sitema
Future<Object?> customSigninDialog(BuildContext context,
    {required ValueChanged onCLosed}) {
  return showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: "Sign In",
    context: context,
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: (_, animation, __, child) {
      Tween<Offset> tween;
      //  dicha aniamcion de Dialog
      tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        ),
        child: child,
      );
    },
    pageBuilder: (context, _, __) => Center(
      // para que siempre este centrado 
      child: Container(
        height: 530,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.89),
          borderRadius: const BorderRadius.all(Radius.circular(45)),
        ),
        child:  Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Stack(
            clipBehavior: Clip.none,
            children: [ 
              Column(
                children: [
                  Column(
                    children: [
                  const Text(
                    "Acceso",
                    style: TextStyle(fontSize: 34, fontFamily: "Poppins"),
                  ),
                  Container(width: 50, height: 50,decoration: const BoxDecoration(color: Colors.white30,
                      borderRadius:  BorderRadius.all(Radius.circular(20)),
                       ), child: Image.asset("assets/icons/ricaldone.png")),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 1),
                    child: Text(
                      '"Buenos Cristianos y Honrados Ciudadanos"',
                      textAlign: TextAlign.center,
                    ),
                  ),
                    ],
                  ),
                   // se llama a tro widget 
                   const SignInForm(),
                ],
              ),
               const Positioned(
                left: 0,
                right: 0,
                bottom: -48,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ).then(onCLosed);
}