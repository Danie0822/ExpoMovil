import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../ModelsDB/Comunicados.dart';
import '../../models/ComunicadosCards.dart';
import '../../models/Observaciones.dart';

class ComunicadosScreen extends StatefulWidget {
  @override
  State<ComunicadosScreen> createState() => _ComunicadosScreenState();
}

class _ComunicadosScreenState extends State<ComunicadosScreen> with SingleTickerProviderStateMixin {
  GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey<RefreshIndicatorState>();
  late AnimationController slideController;
  late Animation<Offset> slideAnimation;
  List<Comunicados> observaciones = [];

  @override
  void initState() {
    super.initState();
    _refreshObservaciones();

    slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: slideController,
      curve: Curves.easeInOut,
    ));
  }

  Future<void> getObservaciones() async {
    try {
      var url = Uri.parse('https://expo2023-6f28ab340676.herokuapp.com/Comunicados/list');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var observacionesData = json.decode(response.body);
        print('Observaciones Data: $observacionesData');

        setState(() {
          observaciones = List<Comunicados>.from(
            observacionesData.map((item) => Comunicados.fromJson(item)),
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
                    'Comunicados',
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

                        return ComunicadoCard(
                          detalle: observacion.detalle,
                          docente: observacion.idComunicado.toString(),
                          Fecha: fecha, 
                          pdfBytes: base64.decode(observacion.archivo),
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
