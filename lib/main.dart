import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_expo/screens/pantallas/InicioAplicacion.dart';
import 'package:sistema_expo/ModelsDB/Providers/Personas.dart';

void main() {
  runMyApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expo 2023',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEEF1F8),
        primarySwatch: Colors.blue,
        fontFamily: "Intel",
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          errorStyle: TextStyle(height: 0),
          border: defaultInputBorder,
          enabledBorder: defaultInputBorder,
          focusedBorder: defaultInputBorder,
          errorBorder: defaultInputBorder,
        ),
      ),
      home: OnboardingScreen(),
    );
  }
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);

void runMyApp() {
  try {
    runApp(
      ChangeNotifierProvider<Personas>(
        create: (context) => Personas(),
        child: const MyApp(),
      ),
    );
  } catch (error) {
     // ignore: avoid_print
     print('An error occurred: $error');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: GlobalKey<NavigatorState>().currentState!.overlay!.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('An error occurred. Please restart the application.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }
}
