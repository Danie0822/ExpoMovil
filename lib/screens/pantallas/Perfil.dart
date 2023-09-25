import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../ModelsDB/Providers/Personas.dart';
import '../onboding/onboding_screen.dart';
// pantalla de perfil 
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    // esto para obtener desde el provider todo de la persona que ingreso 
    final personas = Provider.of<Personas>(context, listen: false);
    String name = personas.person.nombrePersona;
    String email = personas.person.correo;
    String code = personas.person.codigo;
    String image = personas.person.foto;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // esto es diseño 
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14.3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(
                    AntDesign.logout,
                    color: Colors.black,
                  ),
                  // es boton de cerrar sesion 
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OnboardingScreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              // aqui va el diseño de donde se muestra la informacion 
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: Offset(0, 12),
                    ),
                  ],
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF7D5FFF), Color(0xFF4A00E0)],
                  ),
                ),
                child: CircleAvatar(
                  backgroundImage: MemoryImage(base64Decode(image)),
                  radius: 80,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Hola, $name', 
                style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                flex: 7,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Informacion personal',
                          style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        InfoTile(
                          icon: Icons.email,
                          label: 'Correo electrónico',
                          value: email, 
                        ),
                     const    SizedBox(height: 16),
                        InfoTile(
                          icon: Icons.confirmation_number,
                          label: 'Código',
                          value: code, 
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
// esto es el widget de donde sazle dica infromacion oea cuadrado negro 
class InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // diseño de dica card pequeña 
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white, size: 28),
       const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.nunito(
                  textStyle:  const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
             const  SizedBox(height: 4),
              Text(
                value,
                style: GoogleFonts.nunito(
                  textStyle:  const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
