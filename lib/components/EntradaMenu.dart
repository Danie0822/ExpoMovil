import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Muestra el perfil del menu osea la imagen
class Entrada extends StatelessWidget {
  const Entrada({
    super.key,
    required this.Name,
    required this.Rol,
    required this.Foto,
  });

  final String Name;
  final String Rol;
  final String Foto;

   @override
  Widget build(BuildContext context) {
    MemoryImage? image;
    try {
      image = MemoryImage(base64Decode(Foto));
    } catch (e) {
      print('Error decoding base64 image: $e'); 
    }

    return ListTile(
      leading: CircleAvatar(
        // convierte el binario a imagen otra vez 
        backgroundColor: Colors.white24,
        backgroundImage: image != null ? image : null,
        child: image == null
            ? const Icon(
                CupertinoIcons.person,
                color: Colors.white,
              )
            : null,
      ),
      title: Text(Name, style: const TextStyle(color: Colors.white)),
      subtitle: Text(Rol, style: const TextStyle(color: Colors.white)),
    );
  }
}