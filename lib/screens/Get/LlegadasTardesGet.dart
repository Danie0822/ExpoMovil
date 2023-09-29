import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../ModelsDB/LlegadasTarde.dart';
import '../../ModelsDB/Providers/Personas.dart';
import '../../models/LlegadasTardesCards.dart';
//LLegadas Tardes de screen para mostrar 
class LLegadasTardesGetScreen extends StatefulWidget {
  @override
  State<LLegadasTardesGetScreen> createState() => _LLegadasTardesGetScreenState();
}

class _LLegadasTardesGetScreenState extends State<LLegadasTardesGetScreen> with SingleTickerProviderStateMixin {
  //contraladores de reflesh de para LLegadasTardes
  GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey<RefreshIndicatorState>();
  late AnimationController slideController;
  late Animation<Offset> slideAnimation;
  List<LlegadasTardes> observaciones = [];

  @override
  void initState() {
    super.initState();
    _refreshObservaciones();
//animaciones de tarjetas 
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
// metodo para obtener LLegadasTardes 
  Future<void> getObservaciones() async {
    final personas = Provider.of<Personas>(context, listen: false);
    int id = personas.person.idPersona;
    try {
      var url = Uri.parse('https://expo2023-6f28ab340676.herokuapp.com/Funciones/LlegadasTardes/$id');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var observacionesData = json.decode(response.body);
        print('Observaciones Data: $observacionesData');

        setState(() {
          observaciones = List<LlegadasTardes>.from(
            observacionesData.map((item) => LlegadasTardes.fromJson(item)),
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
      // diseño de LLegadasTardes 
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
                    'Llegadas Tardes',
                    style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Llega temprano, triunfa siempre',
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

                        return LlegadasTardeCards(
                          key: ValueKey<int>(index),
                          estado: observacion.idPeriodo,
                          docente: utf8.decode(observacion.docente.codeUnits),
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
