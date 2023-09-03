import 'dart:convert';
import 'dart:io';
// clase de comunicados 
class Comunicados {
  final int idComunicado;
  final int idGrado;
  final DateTime fecha;
  final String detalle;
  final String archivo;

  Comunicados({
    required this.idComunicado,
    required this.idGrado,
    required this.fecha,
    required this.detalle,
    required this.archivo,
  });
// clase para llamar la api en formato json 
  factory Comunicados.fromJson(Map<String, dynamic> json) {
    return Comunicados(
      idComunicado: json['idComunicado'] ?? 0,
      idGrado: json['idGrado'] ?? 0,
      detalle: json['detalle'] ?? '',
      fecha: DateTime.parse(json['fecha'] ?? ''),
      archivo: json['archivo'] ?? '',
    );
  }
// conversion de df osea obiente el archico binario lo convierte 
  Future<File?> getPdfFile() async {
    try {
      final bytes = base64.decode(archivo);
      final tempDir = await Directory.systemTemp;
      final pdfFile = File('${tempDir.path}/comunicado_${idComunicado}.pdf');
      await pdfFile.writeAsBytes(bytes);
      return pdfFile;
    } catch (e) {
      print('Error al obtener el archivo PDF: $e');
      return null;
    }
  }
}
