import 'package:flutter/material.dart';

import 'InicioAplicacion.dart';
// pantalla donde lo manda cuando es admin 
class AlertaAdmin extends StatefulWidget {
  const AlertaAdmin({super.key,});

  @override
  State<AlertaAdmin> createState() => _AlertaAdminState();
}
class _AlertaAdminState extends State<AlertaAdmin> {
  // es admin entonces es una alerta 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // diseño de widget 
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 280.0,
              height: 340.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.5),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(
                  'assets/icons/Adver.png',
                  fit: BoxFit.contain, // Use BoxFit.contain to make the image fit the container.
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Usted no puede acceder al sistema porque es un administrador. Por favor, ingrese desde la aplicación de escritorio. ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OnboardingScreen(),
                  ),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              ),
              icon: Icon(Icons.login), // Use the Icon widget to display an icon
              label: const Text('Regresar al Login'),
            ),
          ],
        ),
      ),
    );
  }
}