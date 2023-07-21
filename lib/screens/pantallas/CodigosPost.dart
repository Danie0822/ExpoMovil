import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

class SearchBarWidget extends StatefulWidget {
  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  TextEditingController _searchController = TextEditingController();
  List<Person> _searchResults = [];
  Person? _selectedPerson;
  bool _isLoading = false;

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
        Uri.parse('https://expo2023-6f28ab340676.herokuapp.com/Credenciales/Search/$query'));

    if (response.statusCode == 200) {
      setState(() {
        _searchResults = (json.decode(response.body) as List)
            .map((item) => Person.fromJson(item))
            .toList();
        _isLoading = false;
      });
    } else {
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

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        SizedBox(height: 90),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            onChanged: _searchData,
            decoration: InputDecoration(
              hintText: "Search...",
            ),
          ),
        ),
        if (_searchResults.isNotEmpty)
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(8.0),
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
              child: Text("Your App Content Here"),
            ),
          ),
      ],
    ),
  );
}
}