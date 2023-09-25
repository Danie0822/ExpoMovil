import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../ModelsDB/Providers/Personas.dart';

class CodigosPersonas {
  final int idCodigoConductualPersona;
  final int idPeriodo;
  final int idCodigoConductual;
  final DateTime fecha;
  final int idEstudiante;
  final int idDocente;

  CodigosPersonas({
    required this.idCodigoConductualPersona,
    required this.idPeriodo,
    required this.fecha,
    required this.idCodigoConductual,
    required this.idEstudiante,
    required this.idDocente,
  });

  factory CodigosPersonas.fromJson(Map<String, dynamic> json) {
    return CodigosPersonas(
      idPeriodo: json['idPeriodo'] ?? 0,
      // Convert the DateTime to a string before encoding to JSON
      fecha: DateTime.parse(json['fecha'] ?? ''),
      idEstudiante: json['idEstudiante'] ?? 0,
      idDocente: json['idDocente'] ?? 0,
      idCodigoConductual: json['idCodigoConductual'] ?? 0,
      idCodigoConductualPersona: json['idCodigoConductualPersona'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idPeriodo': idPeriodo,
      'fecha': fecha.toIso8601String(), // Convert DateTime to a string
      'idEstudiante': idEstudiante,
      'idDocente': idDocente,
      'idCodigoConductual': idCodigoConductual,
      'idCodigoConductualPersona': idCodigoConductualPersona,
    };
  }
}

class Salones {
  final int idSalon;
  final String codigoSalon;

  Salones({required this.idSalon, required this.codigoSalon});

  factory Salones.fromJson(Map<String, dynamic> json) {
    return Salones(
      idSalon: json['idSalon'] ?? 0,
      codigoSalon: json['codigoSalon'] ?? '',
    );
  }
}

class RangoHoras {
  final int idRangoHora;
  final String titulo;
  final String inicio;
  final String Finals;

  RangoHoras(
      {required this.idRangoHora,
      required this.titulo,
      required this.inicio,
      required this.Finals});

  factory RangoHoras.fromJson(Map<String, dynamic> json) {
    return RangoHoras(
        idRangoHora: json['idRangoHora'] ?? 0,
        titulo: json['titulo'] ?? '',
        inicio: json['inicio'] ?? '',
        Finals: json['finals'] ?? '');
  }
}

//pantalla de reservaciones de salones
class ReservacioneScreen extends StatefulWidget {
  @override
  _ReservacioneScreenState createState() => _ReservacioneScreenState();
}

class _ReservacioneScreenState extends State<ReservacioneScreen> {
  // contraladores de de buscadores como lista
  TextEditingController _searchController = TextEditingController();
  TextEditingController _correoController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String correo = "";
  bool _isLoading = false;
  List<String> _comboBoxItems = [];
  List<String> _comboBoxItems1 = [];
  String? _selectedComboBoxItem;
  String? _selectedComboBoxItem1;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchComboBoxData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

// obtener datos para salones
  Future<List<String>> _fetchComboBoxData() async {
    final response = await http.get(
      Uri.parse('https://expo2023-6f28ab340676.herokuapp.com/Salones/list'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;

      final Set<String> uniqueValues = {};

      for (var item in data) {
        uniqueValues.add(item['codigoSalon'].toString());
      }

      // Convert the set back to a list
      final List<String> comboBoxItems = uniqueValues.toList();
      return comboBoxItems;
    } else {
      print('Failed to load ComboBox data');
      return [];
    }
  }

// obtiene la lista de rango de horas
  Future<List<String>> _fetchComboBoxData1() async {
    final response = await http.get(
      Uri.parse('https://expo2023-6f28ab340676.herokuapp.com/RangoHoras/list'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      final Set<String> uniqueValues = {};

      for (var item in data) {
        uniqueValues.add(item['titulo'].toString());
      }

      // Convert the set back to a list
      final List<String> comboBoxItems = uniqueValues.toList();
      return comboBoxItems;
    } else {
      print('Failed to load ComboBox data');
      return [];
    }
  }

  Future<void> _postData(String comboBoxValue, String comboBoxItems) async {
    if (_isLoading) {
      return; // Return if a request is already in progress
    }
    setState(() {
      _isLoading = true;
    });

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final response1 = await http.get(
        Uri.parse(
            'https://expo2023-6f28ab340676.herokuapp.com/Salones/Search/$comboBoxValue'),
      );
      final response12 = await http.get(
        Uri.parse(
            'https://expo2023-6f28ab340676.herokuapp.com/RangoHoras/Search/$comboBoxItems'),
      );
      // url para tener el id de rengo de horas como tambien de salones
      if (response1.statusCode == 200 && response12.statusCode == 200) {
        final List<dynamic> decodedJsonList = json.decode(response1.body);
        final List<dynamic> decodedJsonList2 = json.decode(response12.body);
        if (decodedJsonList.isNotEmpty && decodedJsonList2.isNotEmpty) {
          final Salones idCodigo = Salones.fromJson(decodedJsonList[0]);
          final RangoHoras idRangoHora =
              RangoHoras.fromJson(decodedJsonList2[0]);
          final personas = Provider.of<Personas>(context, listen: false);
          int id = personas.person.idPersona;
          print(idRangoHora.idRangoHora);
          final Map<String, dynamic> requestData = {
            'estado': 1,
            'idRangoHora': idRangoHora.idRangoHora,
            'idReservante': id,
            'idSalon': idCodigo.idSalon,
            'motivoReserva': correo,
            'Fecha': DateFormat('yyyy-MM-dd').format(_selectedDate ?? DateTime.now()),
          };

          setState(() {
            _isLoading = true;
          });

          final response = await http.post(
            Uri.parse(
                'https://expo2023-6f28ab340676.herokuapp.com/ReservacionesSalones/save'),
            body: json.encode(requestData),
            headers: {'Content-Type': 'application/json'},
          );
          // status de post que hace para guardar reservaciones de salones
          if (response.statusCode == 200) {
            _correoController.clear();
            setState(() {
              _isLoading = false;
            });
            // ignore: use_build_context_synchronously
            showDialog(
              // el mensaje de que todo estuvo bien
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: Colors.green[100],
                  title: const Text(
                    '¡Éxito!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green[800],
                        size: 40,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'La reservación se envió correctamente.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the alert
                      },
                      child: Text(
                        'Aceptar',
                        style: TextStyle(
                          color: Colors.green[800],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            print('Failed to make POST request: ${response1.statusCode}');
            setState(() {
              _isLoading = false;
            });
          }

          setState(() {
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: Colors.grey[300],
                title: const Text(
                  'Seleccionar la información',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: const Text(
                  'Selecionar salon y rango de hora antes de guardar.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the alert
                    },
                    child: const Text(
                      'Aceptar',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              backgroundColor: Colors.grey[300],
              title: const Text(
                'Seleccionar la información',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: const Text(
                'Selecionar salon y rango de hora antes de guardar.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the alert
                  },
                  child: const Text(
                    'Aceptar',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.grey[300],
            title: const Text(
              'Mensaje',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
              'Escribir un mensaje de motivo de la reservación ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the alert
                },
                child: const Text(
                  'Aceptar',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: _selectedDate ?? DateTime.now(), // Utiliza la fecha actual si es nula
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(Duration(days: 30)),
  );
  if (picked != null) {
    setState(() {
      _selectedDate = picked;
    });
  }
}


// llamaa el metodo de save le pasa todos los valores
  void _onSaveButtonPressed() {
    final comboBoxValue = _selectedComboBoxItem ?? '';
    final comboBoxValue2 = _selectedComboBoxItem1 ?? '';
    print(comboBoxValue2);
    _postData(comboBoxValue, comboBoxValue2);
  }

// llena el combo box osea el primero
  Widget _buildComboBox() {
    return FutureBuilder<List<String>>(
      future: _fetchComboBoxData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _comboBoxItems = snapshot.data!;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Selecionar salon',
                labelStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedComboBoxItem,
                  items: _comboBoxItems.map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                  onChanged: (selectedItem) {
                    setState(() {
                      _selectedComboBoxItem = selectedItem;
                    });
                  },
                ),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

// llena el combo box osea el segundo
  Widget _buildComboBox2() {
    return FutureBuilder<List<String>>(
      future: _fetchComboBoxData1(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _comboBoxItems1 = snapshot.data!;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Selecione el Rango de hora ',
                labelStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedComboBoxItem1,
                  items: _comboBoxItems1.map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                  onChanged: (selectedItem) {
                    setState(() {
                      _selectedComboBoxItem1 = selectedItem;
                    });
                  },
                ),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildComboBox(),
          const SizedBox(height: 16),
          _buildComboBox2(),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    "Motivo de reservación",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13, right: 13, top: 3),
                  child: TextFormField(
                    controller: _correoController,
                    maxLines: 1,
                    maxLength: 128,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Este campo es requerido";
                      }
                      if (value.length > 128) {
                        return "No puede ingresar más de 128 caracteres";
                      }
                      return null;
                    },
                    onSaved: (email) {
                      correo = email!;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Image.asset("assets/icons/Descripcion.png"),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13, right: 13, top: 3),
                  child: ElevatedButton(
                    onPressed: () {
                      _selectDate(context); // Muestra el selector de fecha
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Color de fondo

                      onPrimary: Colors.white, // Color del texto

                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 8),
                        Text(
                          "Fecha de reservacion",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 13, right: 13, top: 3),
                  child: Text(
                    "Fecha Seleccionada: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _selectedDate != null ? _onSaveButtonPressed : null,
        tooltip: 'Save',
        child: const Icon(Icons.save),
      ),
    );
  }
}
