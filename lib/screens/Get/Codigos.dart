import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../ModelsDB/Codigos.dart';
import '../../ModelsDB/Providers/Personas.dart';
import '../../models/Codigos.dart';
// pagina para obtener  datos de codigos a personas 
class DisciplinaApp extends StatefulWidget {
  @override
  State<DisciplinaApp> createState() => _DisciplinaAppState();
}

class _DisciplinaAppState extends State<DisciplinaApp> with SingleTickerProviderStateMixin {
  // estado de reflesgh 
  GlobalKey<RefreshIndicatorState> refreshKey = GlobalKey<RefreshIndicatorState>();
  List<Codigos> observaciones = [];
  late AnimationController refreshAnimationController;
  late Animation<Offset> slideOutAnimation;
  late Animation<Offset> slideInAnimation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCodigos();
    });

    refreshAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
// animaciones cuando hay aparece las tarejetas 
    slideOutAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1, 0),
    ).animate(CurvedAnimation(
      parent: refreshAnimationController,
      curve: Curves.easeInOut,
    ));

    slideInAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: refreshAnimationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    refreshAnimationController.dispose();
    super.dispose();
  }
// metodo para obtener los datos de tarjeta 
  Future<void> getCodigos() async {
    // provider para obtener el id de tarjeta 
    final personas = Provider.of<Personas>(context, listen: false);
    int id = personas.person.idPersona;
    try {
      // url de la api 
      var url = Uri.parse('https://expo2023-6f28ab340676.herokuapp.com/Funciones/CodigosConductuales/$id');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var observacionesData = json.decode(response.body);
        print('Observaciones Data: $observacionesData');

        setState(() {
          observaciones = List<Codigos>.from(
            observacionesData.map((item) => Codigos.fromJson(item)),
          );
        });

        refreshAnimationController.forward();
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
// metodo para reflesh 
  Future<void> _refreshObservaciones() async {
    refreshAnimationController.reset();
    await getCodigos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // diseño de codigo de formulario 
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(

              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 55),
              const Text(
                'Codigos ',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Promoviendo la disciplina y el crecimiento',
                style: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: RefreshIndicator(
                    key: refreshKey,
                    onRefresh: _refreshObservaciones,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (child, animation) {
                        final position = animation.status == AnimationStatus.reverse
                            ? slideOutAnimation
                            : slideInAnimation;

                        return SlideTransition(
                          position: position,
                          child: child,
                        );
                      },
                      child: ListView.builder(
                        key: UniqueKey(), // Importante: Asignar una clave única
                        itemCount: observaciones.length,
                        itemBuilder: (context, index) {
                          final observacion = observaciones[index];
                          final fechaCompleta = observacion.fecha.toString();
                          final fecha = fechaCompleta.substring(0, 10);

                          return FadeTransition(
                            opacity: refreshAnimationController,
                            // tarjeta de codigos screen 
                            child: CodigosScreen(
                              jobTitle: utf8.decode(observacion.docente.codeUnits),
                              companyName: utf8.decode(observacion.codigoConductual.codeUnits),
                              hour: fecha,
                              type: observacion.tipoCodigoConductual,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
