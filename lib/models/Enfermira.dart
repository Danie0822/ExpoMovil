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

  Color generarColorAleatorio() {
    Random random = Random();
    int blue = random.nextInt(156) + 100;
    int red = random.nextInt(56) + 100;
    int green = random.nextInt(56) + 100;

    return Color.fromARGB(255, red, green, blue);
  }

  @override
  Widget build(BuildContext context) {
    Color colorAleatorio = generarColorAleatorio();
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(80),
          boxShadow: [
            BoxShadow(
              color: colorAleatorio.withOpacity(0.7),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.all(3),
                  color: Colors.white,
                  child: Image.asset('assets/icons/Doctor.png'),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                const   Text(
                    'Sintomas',
                    style:  TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.3,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    Detalle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Fecha: $Fecha',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
