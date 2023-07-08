import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return ListTile(
      leading:  CircleAvatar(
                      backgroundColor: Colors.white24,
                      backgroundImage: Foto != null
                          ? MemoryImage(base64Decode(Foto))
                          : null,
                      child: Foto == null
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
