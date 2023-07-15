import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../ModelsDB/Notificaciones.dart';
import '../../../ModelsDB/Providers/Personas.dart';
import '../../../models/Cardview.dart';
import '../../../models/NotificacionCard.dart';


class Colum extends StatefulWidget {
  const Colum({super.key, required this.Cards, required this.CardList});

  final List Cards;
  final List CardList;

  @override
  State<Colum> createState() => _ColumState();
}

class _ColumState extends State<Colum> {
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
      var url = Uri.parse(
          'https://expo2023-6f28ab340676.herokuapp.com/Notificaciones/list/$id');
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
      var url = Uri.parse(
          'https://expo2023-6f28ab340676.herokuapp.com/Notificaciones/delete/$idNotificacion');
      var response = await http.delete(url);

      if (response.statusCode == 200) {
        print('Notification deleted successfully.');
      } else {
        print('Error deleting notification: ${response.statusCode}');
      }
    } catch (error) {
      print('Error deleting notification: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 93),
        const Padding(
          padding: EdgeInsets.only(left: 25.0),
          child: Text(
            'Instituto Técnico Ricaldone',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          height: 160,
          child: ListView.builder(
              itemCount: widget.Cards.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CardviewScreen(
                  companyName: widget.Cards[index][0],
                  jobTitle: widget.Cards[index][1],
                  logo: widget.Cards[index][2],
                  hour: widget.Cards[index][3],
                  pantalla: widget.Cards[index][4],
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
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const  BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: RefreshIndicator(
                  onRefresh: _refreshNotificaciones,
                  color: Colors.blue,
                  backgroundColor: Colors.white,
                  child: ListView.builder(
                    itemCount: notificaciones.length,
                    itemBuilder: (context, index) {
                      final notificacion = notificaciones[index];

                      return Dismissible(
                        key: ValueKey(notificacion.idNotificacion),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) async {
                          deleteNotification(notificacion.idNotificacion);
                          await Future.delayed(const Duration(
                              milliseconds: 500));
                          setState(() {
                            notificaciones.removeAt(index);
                          });
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  padding: const EdgeInsets.all(0),
                                  color: Colors.grey[100],
                                  child: NotificacionScreen(
                                    titulo: notificacion.detalle,
                                    TipoNotificacion: 'ITR',
                                  ),
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
    );
  }
}
