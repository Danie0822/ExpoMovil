import 'dart:math';

import 'package:flutter/material.dart';

class ComunicadosScreen extends StatelessWidget {
  final String companyName;
  final String jobTitle;
  final String logo;

  const ComunicadosScreen({
    Key? key,
    required this.companyName,
    required this.jobTitle, required this.logo,
  }) : super(key: key);

  Color generarColorAleatorio() {
    Random random = Random();
    int red = random.nextInt(256); // Rango de 0 a 255
    int green = random.nextInt(256); // Rango de 0 a 255
    int blue = random.nextInt(256); // Rango de 0 a 255
    return Color.fromARGB(255, red, green, blue);
  }

  @override
  Widget build(BuildContext context) {
    Color colorAleatorio = generarColorAleatorio();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: colorAleatorio.withOpacity(0.4),
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
                borderRadius: BorderRadius.circular(28),
                child: Image.asset(
                  logo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jobTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    companyName,
                    style: const TextStyle(
                      fontSize: 14,
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
