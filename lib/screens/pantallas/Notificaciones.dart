import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../ModelsDB/Observaciones.dart';
import '../../ModelsDB/Providers/Personas.dart';
import '../../models/Observaciones.dart';
// notificaciones screen 
class NotificacionesPantalla extends StatefulWidget {
  @override
  State<NotificacionesPantalla> createState() => _NotificacionesPantallaState();
}

class _NotificacionesPantallaState extends State<NotificacionesPantalla> with SingleTickerProviderStateMixin {
  // contraladores de Observaciones 
  GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey<RefreshIndicatorState>();
  late AnimationController slideController;
  late Animation<Offset> slideAnimation;
  List<Observaciones> observaciones = [];

  @override
  void initState() {
    super.initState();
    // cargar los datos de Observaciones
    _refreshObservaciones();

    slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
// animaciones de Observaciones 
    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: slideController,
      curve: Curves.easeInOut,
    ));
  }
// obtiene los datos de observaciones  
  Future<void> getObservaciones() async {
    // obtiene el id de la persona
    final personas = Provider.of<Personas>(context, listen: false);
    int id = personas.person.idPersona;
    // url de la api 
    try {
      var url = Uri.parse('https://expo2023-6f28ab340676.herokuapp.com/Funciones/Observaciones/$id');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var observacionesData = json.decode(response.body);
        print('Observaciones Data: $observacionesData');

        setState(() {
          observaciones = List<Observaciones>.from(
            observacionesData.map((item) => Observaciones.fromJson(item)),
          );
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void dispose() {
    slideController.dispose();
    super.dispose();
  }
// llama el reflesh osea llame el get de Observaciones
  Future<void> _refreshObservaciones() async {
    // Check if the state is still mounted before proceeding.
    if (!mounted) return;

    await getObservaciones();

    // Check if the state is still mounted before triggering the animation.
    if (mounted) {
      slideController.reset();
      slideController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // diseño de la pantalla 
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
                      color: Colors.grey,
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
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {
                      final position = animation.status == AnimationStatus.reverse
                          ? slideAnimation
                          : slideAnimation;

                      return SlideTransition(
                        position: position,
                        child: FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                      );
                    },
                    child: ListView.builder(
                      itemCount: observaciones.length,
                      itemBuilder: (context, index) {
                        final observacion = observaciones[index];
                        final fechaCompleta = observacion.fecha.toString();
                        final fecha = fechaCompleta.substring(0, 10);


                        // se lllama las cards de Observaciones
                        return ObservacionesScreen(
                          key: ValueKey<int>(index),
                          detalle: utf8.decode(observacion.detalle.codeUnits),
                          docente: utf8.decode(observacion.docente.codeUnits),
                          Fecha: fecha, 
                        );
                      },
                    ),
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
