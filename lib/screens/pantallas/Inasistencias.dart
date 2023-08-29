import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../ModelsDB/Inasistencias.dart';
import '../../ModelsDB/Observaciones.dart';
import '../../ModelsDB/Providers/Personas.dart';
import '../../models/InasistenciasCard.dart';
import '../../models/Observaciones.dart';

class InasistenciasScreen extends StatefulWidget {
  @override
  State<InasistenciasScreen> createState() => _InasistenciasScreenState();
}

class _InasistenciasScreenState extends State<InasistenciasScreen> with SingleTickerProviderStateMixin {
  GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey<RefreshIndicatorState>();
  late AnimationController slideController;
  late Animation<Offset> slideAnimation;
  List<Inasisitencias> observaciones = [];

  @override
  void initState() {
    super.initState();
    _refreshObservaciones();

    slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(-1, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: slideController,
      curve: Curves.easeInOut,
    ));
  }

  Future<void> getObservaciones() async {
    final personas = Provider.of<Personas>(context, listen: false);
    int id = personas.person.idPersona;
    try {
      var url = Uri.parse('https://expo2023-6f28ab340676.herokuapp.com/Funciones/Inasisitencias/$id');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var observacionesData = json.decode(response.body);
        print('Observaciones Data: $observacionesData');

        setState(() {
          observaciones = List<Inasisitencias>.from(
            observacionesData.map((item) => Inasisitencias.fromJson(item)),
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
                    'Inasistencias',
                    style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Convierte inasistencias en oportunidadesa',
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

                        return InasisitenciasCards(
                          key: ValueKey<int>(index),
                          estado: observacion.estado,
                          docente: observacion.docente,
                          fecha: fecha, 
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
