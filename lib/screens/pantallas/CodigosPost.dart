import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Codigos( {
    required this.idCodigoConductual,
    required this.idTipoCodigoConductual,
    required this.idNivelCodigoConductual,
    required this.codigoConductual
  });

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
      idPersona: json['idPersona'],
      codigo: json['codigo'],
      nombrePersona: json['nombrePersona'],
      apellidoPersona: json['apellidoPersona'],
      nacimientoPersona: json['nacimientoPersona'],
      idTipoPersona: json['idTipoPersona'],
      correo: json['correo'],
      claveCredenciales: json['claveCredenciales'],
      foto: json['foto'],
    );
  }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SearchBarWidget(),
      ),
    );
  }
}

class SearchBarWidget extends StatefulWidget {
  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController _searchController = TextEditingController();
  List<Person> _searchResults = [];
  Person? _selectedPerson;
  bool _isLoading = false;
  List<String> _comboBoxItems = [];
  String? _selectedComboBoxItem;

  @override
  void initState() {
    super.initState();
    _fetchComboBoxData();
  }
  Future<List<String>> _fetchComboBoxData() async {
    final response = await http.get(
        Uri.parse('https://expo2023-6f28ab340676.herokuapp.com/CodigosConductuales/list'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      final List<String> comboBoxItems = [];
      for (var item in data) {
        // Aquí se selecciona el campo "nombre" del objeto JSON y se agrega a la lista de elementos de la ComboBox.
        comboBoxItems.add(item['codigoConductual'].toString());
      }
      return comboBoxItems;
    } else {
      print('Failed to load ComboBox data');
      return [];
    }
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
      _isLoading = false;
    });
    return;
  }

  final response = await http.get(
      Uri.parse(
          'https://expo2023-6f28ab340676.herokuapp.com/Credenciales/Search/$query'));

  if (response.statusCode == 200) {
    if (!mounted) return; // Add this line to check if the widget is still mounted
    setState(() {
      _searchResults = (json.decode(response.body) as List)
          .map((item) => Person.fromJson(item))
          .toList();
      _isLoading = false;
    });
  } else {
    if (!mounted) return; // Add this line to check if the widget is still mounted
    setState(() {
      _isLoading = false;
    });
    print('Failed to load data');
  }
}


  Widget _buildDropDownMenu() {
    return DropdownButtonFormField<Person>(
      value: _selectedPerson,
      items: _searchResults.map((person) {
        return DropdownMenuItem<Person>(
          value: person,
          child: Text('${person.nombrePersona} ${person.apellidoPersona}'),
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
      ),
    );
  }

  Future<void> _postData(String searchValue, String comboBoxValue) async {

    final response1 = await http.get(
        Uri.parse(
            'https://expo2023-6f28ab340676.herokuapp.com/CodigosConductuales/Search/$comboBoxValue'));

    List<Codigos> idCodigo = (json.decode(response1.body) as List)
        .map((item) => Codigos.fromJson(item))
        .toList();

    final Map<String, dynamic> requestData = {
      'idPeriodo' : 1,
      'fecha': DateTime.now().toString(),
      'idEstudiante': _selectedPerson?.idPersona,
      'idDocente': 24,
      'idCodigoConductual': idCodigo[0].idCodigoConductual,
      'idCodigoConductualPersona': null
    };

    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse('https://expo2023-6f28ab340676.herokuapp.com/CodigosConductualesPersonas/save'), 
      body: json.encode(requestData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {

    } else {
      print('Failed to make POST request' + response.statusCode.toString());
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _onSaveButtonPressed() {
    if (_selectedPerson != null) {
      final searchValue = _searchController.text;
      final comboBoxValue = _selectedComboBoxItem ?? '';
      _postData(searchValue, comboBoxValue);
    } else {
      print('No person selected.');
    }
  }

 Widget _buildComboBox() {
    return FutureBuilder<List<String>>(
      future: _fetchComboBoxData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _comboBoxItems = snapshot.data!;
          return DropdownButtonFormField<String>(
            value: _selectedComboBoxItem,
            items: _comboBoxItems.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (selectedItem) {
              setState(() {
                _selectedComboBoxItem = selectedItem;
              });
            },
            decoration: InputDecoration(
              hintText: 'Select an item',
            ),
          );
        } else {
          return Text('Failed to load data');
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplicar código'),
        backgroundColor: Colors.lightBlue, // Color de fondo de la AppBar
        elevation: 0, // Elimina la sombra debajo de la AppBar
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey[50], // Color de fondo de la barra de búsqueda
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _searchData,
                decoration: InputDecoration(
                  hintText: "Search...",
                  border: InputBorder.none, // Elimina el borde de la barra de búsqueda
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          _buildComboBox(), // ComboBox debajo de la barra de búsqueda
          SizedBox(height: 16),
          if (_searchResults.isNotEmpty)
            Expanded(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8),
                child: _buildDropDownMenu(),
              ),
            )
          else if (_isLoading)
            Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          else
            Expanded(
              child: Center(
                child: Text(""),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onSaveButtonPressed,
        tooltip: 'Save',
        backgroundColor: Colors.lightBlue, // Color de fondo del botón flotante
        child: Icon(Icons.save, color: Colors.white), // Color del ícono del botón flotante
        elevation: 4, // Añade una sombra al botón flotante
      ),
    );
  }
}