import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../ModelsDB/Providers/Personas.dart';
import '../../ModelsDB/VisitaEnfermeria.dart';

import '../../models/Enfermira.dart';
// vista de enfermeria 
class VisitaEnfermeria extends StatefulWidget {
  @override
  State<VisitaEnfermeria> createState() => _VisitaEnfermeriaState();
}

class _VisitaEnfermeriaState extends State<VisitaEnfermeria> {
  GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    getCodigos();
  }

  List<VisitasEnfermeria> observaciones = [];
// metodo para obtener las visitas enfermeria 
  Future<void> getCodigos() async {
    final personas = Provider.of<Personas>(context, listen: false);
    int id = personas.person.idPersona;
    try {
      var url = Uri.parse(
          'https://expo2023-6f28ab340676.herokuapp.com/VisitasEnfermeria/String/$id');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var observacionesData = json.decode(response.body);
        print('Observaciones Data: $observacionesData');

        setState(() {
          observaciones = List<VisitasEnfermeria>.from(observacionesData
              .map((item) => VisitasEnfermeria.fromJson(item)));
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
// metodo de refelsh 
  Future<void> _refreshObservaciones() async {
    await getCodigos();
  }

  @override
  Widget build(BuildContext context) {
    // diseño de formulario 
    return Scaffold(
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
              SizedBox(height: 55),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const Text(
                    'Visita Enfermería',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  
                ],
              ),
                          const Text(
                '¡Tu salud, nuestra prioridad! Visita enfermería y vive al máximo',
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
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
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
                  child: RefreshIndicator(
                    key: refreshKey,
                    onRefresh: _refreshObservaciones,
                    child: ListView.builder(
                      // llamada de cards de Visitas de enfermeria 
                      itemCount: observaciones.length,
                      itemBuilder: (context, index) {
                        final observacion = observaciones[index];
                        final fechaCompleta = observacion.fecha.toString();
                        final fecha = fechaCompleta.substring(0, 10);

                        return EnfermeriaCards(
                          Detalle: utf8.decode(observacion.detalleVisitia.codeUnits),
                          Fecha: fecha,
                        );
                      },
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
