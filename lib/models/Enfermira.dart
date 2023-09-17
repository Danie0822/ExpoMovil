import 'dart:math';

import 'package:flutter/material.dart';

class EnfermeriaCards extends StatelessWidget {
  final String Detalle;
  final String Fecha;

  const EnfermeriaCards({
    Key? key,
    required this.Detalle,
    required this.Fecha,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blueGrey[200]!,
            Colors.blueGrey[100]!,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            ),
            child: const Center(
              child: Icon(
                Icons.local_hospital,
                size: 36,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Visita de Enfermería',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  Detalle,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8), // Ajuste del espaciado
                Text(
                  'Fecha: $Fecha',
                  style: TextStyle(
                    fontSize: 13,
                    color:
                        Colors.blueGrey[900]!, // Color de la fecha más fuerte
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
