import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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

class Codigos {
  final int idCodigoConductual;
  final int idTipoCodigoConductual;
  final int idNivelCodigoConductual;
  final String codigoConductual;

  Codigos(
      {required this.idCodigoConductual,
      required this.idTipoCodigoConductual,
      required this.idNivelCodigoConductual,
      required this.codigoConductual});

  factory Codigos.fromJson(Map<String, dynamic> json) {
    return Codigos(
      codigoConductual: json['codigoConductual'] ?? '',
      idCodigoConductual: json['idCodigoConductual'] ?? 0,
      idTipoCodigoConductual: json['idTipoCodigoConductual'] ?? 0,
      idNivelCodigoConductual: json['idNivelCodigoConductual'] ?? 0,
    );
  }
}

class Person {
  final int idPersona;
  final String codigo;
  final String nombrePersona;
  final String apellidoPersona;
  final String nacimientoPersona;
  late final int idTipoPersona;
  final String correo;
  final String claveCredenciales;
  final String foto;

  Person({
    required this.idPersona,
    required this.codigo,
    required this.nombrePersona,
    required this.apellidoPersona,
    required this.nacimientoPersona,
    required this.idTipoPersona,
    required this.correo,
    required this.claveCredenciales,
    required this.foto,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      idPersona: json['idPersona'] ?? 0,
      codigo: json['codigo']?? '',
      nombrePersona: json['nombrePersona']?? '',
      apellidoPersona: json['apellidoPersona']?? '',
      nacimientoPersona: json['nacimientoPersona']?? '',
      idTipoPersona: json['idTipoPersona'] ?? 0,
      correo: json['correo']?? '',
      claveCredenciales: json['claveCredenciales'] ?? '',
      foto: json['foto'] ?? '',
    );
  }
}



class ObservacionesSearchBar extends StatefulWidget {
  @override
  _ObservacionesSearchBarState createState() => _ObservacionesSearchBarState();
}

class _ObservacionesSearchBarState extends State<ObservacionesSearchBar> {
  bool _isSaving = false;
  TextEditingController _searchController = TextEditingController();
   TextEditingController _correoController = TextEditingController(); 
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String correo = "";
  List<Person> _searchResults = [];
  Person? _selectedPerson;
  bool _isLoading = false;
  List<String> _comboBoxItems = [];
  String? _selectedComboBoxItem;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchData(String query) async {
    setState(() {
      _searchResults.clear();
      _selectedPerson = null;
      _isLoading = true;
    });

    if (query.isEmpty) {
      setState(() {
        _selectedPerson = null;
        _selectedComboBoxItem = null;
        _isLoading = false;
      });
      return;
    }

    final response = await http.get(
      Uri.parse(
          'https://expo2023-6f28ab340676.herokuapp.com/Credenciales/Search/$query'),
    );

    if (response.statusCode == 200) {
      if (!mounted) return;
      setState(() {
        _searchResults = (json.decode(response.body) as List)
            .map((item) => Person.fromJson(item))
            .toList();
        _isLoading = false;
        if (_searchResults.isEmpty) {
          _selectedPerson = null;
        }
      });
    } else {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      print('Failed to load data');
    }
  }
Widget _buildDropDownMenu() {
  try {
    return DropdownButtonFormField<Person>(
      value: _selectedPerson,
      items: _searchResults.map((person) {
        return DropdownMenuItem<Person>(
          value: person,
          child: Text(
            '${person.nombrePersona} ${person.apellidoPersona}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
      onChanged: _searchResults.isEmpty || _isLoading
          ? null
          : (selectedPerson) {
              setState(() {
                _selectedPerson = selectedPerson;
                _searchController.text =
                    '${selectedPerson!.nombrePersona} ${selectedPerson.apellidoPersona}';
                print('idPersona: ${_selectedPerson!.idPersona}');
              });
            },
      decoration: InputDecoration(
        hintText: _isLoading ? 'Loading...' : 'Select a person',
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
      ),
    );
  } catch (e) {
    // Handle any errors that may occur here
    print('Error in _buildDropDownMenu: $e');
    return Text('Error: Unable to build dropdown');
  }
}
  Future<void> _postData(String searchValue) async {
    if(_formKey.currentState!.validate()){
     _formKey.currentState!.save();
    final personas = Provider.of<Personas>(context, listen: false);
    int id = personas.person.idPersona;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(now);
    final Map<String, dynamic> requestData = {
      'idPeriodo': 1,
      'fecha': formattedDate,
      'idEstudiante': _selectedPerson?.idPersona,
      'idDocente': id,
      'detalle': correo,
      'idObservacion': 1,
    };
    final Map<String, dynamic> requestNoti = {
      'idNotificacion': 1,
      'detalle': "Revisar Observaciones",
      'idPersona': _selectedPerson?.idPersona,
      'idTipoNotificacion': 1
    };
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse(
          'https://expo2023-6f28ab340676.herokuapp.com/0bservaciones/save'),
      body: json.encode(requestData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Se pudo');
      final response1 = await http.post(
        Uri.parse(
            'https://expo2023-6f28ab340676.herokuapp.com/Notificaciones/save'),
        body: json.encode(requestNoti),
        headers: {'Content-Type': 'application/json'},
      );
      if (response1.statusCode == 200) {
        // ignore: use_build_context_synchronously
        showDialog(
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
                    'El Codigo se envió correctamente.',
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
      }
    } else {
      print('Failed to make POST request: ${response.statusCode}');
    }

    setState(() {
      _isLoading = false;
    });
    }
    else{
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
              'Escribir un mensaje en descripción al alumno',
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

  Future<void> _onSaveButtonPressed() async {
    if (_selectedPerson != null) {
      if(!_isSaving){

    
    setState(() {
      _isSaving = true;
    });
      final searchValue = _searchController.text;
    await _postData(searchValue);

    setState(() {
      _isSaving = false;
         _searchController.clear();
           _selectedPerson = null;  
           _correoController.clear();
    });
    } 
    else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.grey[300],
            title: const Text(
              'Espere un Poco',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
              'Por favor, Esperar el envio de Observacion',
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
    else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.grey[300],
            title: const Text(
              'Seleccionar un alumno',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
              'Por favor, seleccione un alumno antes de guardar.',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[250],
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 5),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _searchData,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: "Search...",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Form(
  key: _formKey,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.only(left: 16),
        child: Text(
          "Descripción",
          style: TextStyle(color: Colors.black54),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 13, right: 13, top: 3),
        child: TextFormField(
          controller: _correoController,
          maxLines: 1,
          maxLength: 120, // Limit the input to 120 characters
          validator: (value) {
            if (value!.isEmpty) {
              return "Este campo es requerido";
            }
            if (value.length > 120) {
              return "No puede ingresar más de 120 caracteres";
            }
            return null;
          },
          onSaved: (description) {
            correo = description!;
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
    ],
  ),
),

          const SizedBox(height: 16),
          if (_searchResults.isNotEmpty)
            Expanded(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: _buildDropDownMenu(),
              ),
            )
          else if (_isLoading)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          else
            const Expanded(
              child: Center(
                child: Text(""),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onSaveButtonPressed,
        tooltip: 'Save',
        child: const Icon(Icons.save),
      ),
    );
  }
}
