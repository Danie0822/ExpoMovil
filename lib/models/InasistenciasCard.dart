import 'package:flutter/material.dart';
// obtener los datos de las tarjetas 
class InasisitenciasCards extends StatelessWidget {
  final int estado;
  final String docente;
  final String fecha;

  const InasisitenciasCards({
    Key? key,
    required this.estado,
    required this.docente,
    required this.fecha,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // depende del estado se visualiza diferentes cosas 
    String estadoTexto = estado == 1 ? "Injustificada" : "Justificada";
    Color cardColor = estado == 1 ? Colors.redAccent : Colors.greenAccent;

    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: cardColor.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Stack(
            children: [
              Image.asset(
                'assets/icons/anas.png',
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),

            ],
          ),
        ),
        title: Text(
          'Prof: $docente',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Estado: $estadoTexto',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Fecha: $fecha',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
