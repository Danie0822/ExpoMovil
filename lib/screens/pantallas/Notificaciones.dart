import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../ModelsDB/Notificaciones.dart';
import '../../ModelsDB/Providers/Personas.dart';
import '../../models/NotificacionCard.dart';

class NotificacionesPantalla extends StatefulWidget {
  @override
  State<NotificacionesPantalla> createState() => _NotificacionesPantallaState();
}

class _NotificacionesPantallaState extends State<NotificacionesPantalla> {
  List<Notificaciones> notificaciones = [];

  @override
  void initState() {
    super.initState();
    getNotificaciones();
  }

  Future<void> getNotificaciones() async {
    final personas = Provider.of<Personas>(context, listen: false);
    int id = personas.person.idPersona;
    try {
      var url = Uri.parse('https://expo2023-6f28ab340676.herokuapp.com/Funciones/Notificaciones/$id');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var notificacionesData = json.decode(response.body);
        print('Notificaciones Data: $notificacionesData');

        setState(() {
          notificaciones = List<Notificaciones>.from(
              notificacionesData.map((item) => Notificaciones.fromJson(item)));
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> _refreshNotificaciones() async {
    await getNotificaciones();
  }

  Future<void> deleteNotification(int idNotificacion) async {
  try {
    var url = Uri.parse('https://expo2023-6f28ab340676.herokuapp.com/Notificaciones/delete/$idNotificacion');
    var response = await http.delete(url);

    if (response.statusCode == 200) {
      print('Notification deleted successfully.');
      setState(() {
        notificaciones.removeWhere((notification) => notification.idNotificacion == idNotificacion);
      });
    } else {
      print('Error deleting notification: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (error) {
    print('Error deleting notification: $error');
  }
}

 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            color: Colors.white,
            child: const Column(
              children: [
                Text(
                  'Notificaciones ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Conéctate al instante \n  a un universo de novedades',
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: RefreshIndicator(
                onRefresh: _refreshNotificaciones,
                color: Colors.black,
                backgroundColor: Colors.white,
                child: ListView.builder(
                  itemCount: notificaciones.length,
                  itemBuilder: (context, index) {
                    final notificacion = notificaciones[index];

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Container(
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              padding: EdgeInsets.all(0),
                              color: Colors.grey[100],
                              child: NotificacionScreen(
                                titulo: notificacion.detalle,
                                TipoNotificacion: 'ITR',
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}