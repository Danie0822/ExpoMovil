import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../ModelsDB/Observaciones.dart';
import '../../../ModelsDB/Providers/Personas.dart';
import '../../../models/Cardview.dart';
import '../../../models/Observaciones.dart';

class Colum extends StatefulWidget {
  const Colum({super.key, required this.Cards, required this.CardList});

  final List Cards;
  final List CardList;

  @override
  State<Colum> createState() => _ColumState();
}

class _ColumState extends State<Colum> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 93),
        const Padding(
          padding: EdgeInsets.only(left: 21.0),
          child: Text(
            'Instituto Técnico Ricaldone',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
          ),
        ),
        const SizedBox(height: 25),
        Container(
          height: 160,
          child: ListView.builder(
              itemCount: widget.Cards.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CardviewScreen(
                  companyName: widget.Cards[index][0],
                  JobTItle: widget.Cards[index][1],
                  Logo: widget.Cards[index][2],
                  hour: widget.Cards[index][3],
                );
              }),
        ),
        const SizedBox(height: 30),
        const Padding(
          padding: EdgeInsets.only(left: 25.0),
          child: Text(
            'Notificaciones',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
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
    );
  }
}
