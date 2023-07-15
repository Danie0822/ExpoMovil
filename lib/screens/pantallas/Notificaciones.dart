import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../ModelsDB/Observaciones.dart';
import '../../ModelsDB/Providers/Personas.dart';
import '../../models/Observaciones.dart';

class NotificacionesPantalla extends StatefulWidget {
  @override
  State<NotificacionesPantalla> createState() => _NotificacionesPantallaState();
}

class _NotificacionesPantallaState extends State<NotificacionesPantalla> {
  GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    getObservaciones();
  }

  List<Observaciones> observaciones = [];

  Future<void> getObservaciones() async {
    final personas = Provider.of<Personas>(context, listen: false);
    int id = personas.person.idPersona;
    try {
      var url = Uri.parse(
          'https://expo2023-6f28ab340676.herokuapp.com/Funciones/Observaciones/$id');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var observacionesData = json.decode(response.body);
        print('Observaciones Data: $observacionesData');

        setState(() {
          observaciones = List<Observaciones>.from(
              observacionesData.map((item) => Observaciones.fromJson(item)));
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> _refreshObservaciones() async {
    await getObservaciones();
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
                    'Observaciones',
                    style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Descubre el poder \n Aprende, crece y transforma',
                    style: TextStyle(
                      fontSize: 19,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: RefreshIndicator(
        key: refreshKey,
        onRefresh: _refreshObservaciones,
        child: ListView.builder(
          itemCount: observaciones.length,
          itemBuilder: (context, index) {
            final observacion = observaciones[index];
            final fechaCompleta = observacion.fecha.toString();
            final fecha = fechaCompleta.substring(0, 10);

            return ObservacionesScreen(
              detalle: observacion.detalle,
              docente: observacion.docente,
              Fecha: fecha,
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