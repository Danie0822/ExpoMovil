import 'dart:math';

import 'package:flutter/material.dart';

class EnfermeriaCards extends StatelessWidget {
  final String Detalle;
  final String Fecha;
// obtener  los datos de las tarjetas  
  const EnfermeriaCards({
    Key? key,
    required this.Detalle,
    required this.Fecha,
  }) : super(key: key);

Color generarColorAleatorio() {
  Random random = Random();
  int red = random.nextInt(60) + 120;
  int green = random.nextInt(40) + 80;
  int blue = random.nextInt(100) + 140;

  return Color.fromARGB(255, red, green, blue);
}

  @override
  Widget build(BuildContext context) {
    // color de aletorio para la tarjeta 
    Color colorAleatorio = generarColorAleatorio();
    return Container(
      // diseño de tarjeta  
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorAleatorio,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorAleatorio.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.4,
              child: Image.asset(
                'assets/icons/Positivos.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.5),
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
                  const  Text(
                      'Visita de Enfermería',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                   Text(
                      Detalle,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Fecha: $Fecha',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
