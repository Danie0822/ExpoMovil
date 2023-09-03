import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../ModelsDB/Codigos.dart';
import '../../ModelsDB/Providers/Personas.dart';
import '../../models/Codigos.dart';
// obtener el codigos 
class DisciplinaApp extends StatefulWidget {

  @override
  State<DisciplinaApp> createState() => _DisciplinaAppState();
}

class _DisciplinaAppState extends State<DisciplinaApp> {
  // contralodores de reflescar 
       GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();
    @override
  void initState() {
    super.initState();
    getCodigos();
  }
  List<Codigos> observaciones = [];
// obtener codigos del usuario 
  Future<void> getCodigos() async {
    final personas = Provider.of<Personas>(context, listen: false);
    int id = personas.person.idPersona;
    try {
      var url = Uri.parse(
          'https://expo2023-6f28ab340676.herokuapp.com/Funciones/CodigosConductuales/$id');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var observacionesData = json.decode(response.body);
        print('Observaciones Data: $observacionesData');

        setState(() {
          observaciones = List<Codigos>.from(
              observacionesData.map((item) => Codigos.fromJson(item)));
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
// metodo de reflesh de codigos 
  Future<void> _refreshObservaciones() async {
    await getCodigos();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // diseño de codigos 
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
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
                'Disciplina App',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: 100,
                height: 95,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                    child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    'assets/icons/Notifi1.png',
                    width: 70,
                    height: 70,
                  ),
                )),
              ),
              const SizedBox(height: 30),
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
              child: ListView.builder(
                // obtener codigos osea las cards 
                itemCount: observaciones.length,
                itemBuilder: (context, index) {
                  final observacion = observaciones[index];
                  final fechaCompleta = observacion.fecha.toString();
                  final fecha = fechaCompleta.substring(0, 10);

                  return CodigosScreen(
                    JobTItle: observacion.docente,
                    companyName: observacion.codigoConductual,
                    hour: fecha,
                    TIPo: observacion.tipoCodigoConductual,
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
