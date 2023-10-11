import 'package:flutter/material.dart';
// Cards de tarjetas de observaciones 
class ObservacionesScreen extends StatelessWidget {
  final String detalle;
  final String docente;
  final String Fecha; 

  const ObservacionesScreen({
    Key? key,
    required this.detalle,
    required this.docente, required this.Fecha,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // card de de diseño de la tarjeta 
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 60,
                height: 60,
                color: Colors.grey[200],
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/icons/escuela.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Prof: $docente',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    detalle,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                   'Fecha: $Fecha',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
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