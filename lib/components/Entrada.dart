import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Entrada extends StatelessWidget {
  const Entrada({
    super.key,
    required this.Name,
    required this.Rol,
  });

  final String Name;
  final String Rol;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(
          CupertinoIcons.person,
          color: Colors.white,
        ),
      ),
      title: Text(Name, style: const TextStyle(color: Colors.white)),
      subtitle: Text(Rol, style: const TextStyle(color: Colors.white)),
    );
  }
}