import 'package:flutter/material.dart';

class NotificacionScreen extends StatelessWidget {
  final String titulo;
  final String TipoNotificacion;

  const NotificacionScreen(
      {Key? key, required this.titulo, required this.TipoNotificacion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.all(12),
                  color: Colors.grey[300],
                  child: Image.asset('assets/icons/Notifi1.png'),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Notificacion',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(
                    titulo,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12.4),
                    
                  ),
                ],
              ),
            ]),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                  padding: const EdgeInsets.all(5),
                  color: Colors.blue,
                  child: Text(
                    TipoNotificacion,
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
