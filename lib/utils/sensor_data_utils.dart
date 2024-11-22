import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

// Cargar datos desde archivo
Future<List<Map<String, String>>> loadSensorDataFromFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['txt'],
  );

  if (result != null && result.files.single.path != null) {
    File file = File(result.files.single.path!);
    String fileContent = await file.readAsString();

    List<Map<String, String>> data = fileContent
        .split('\n')
        .map((line) {
          final temperatureMatch =
              RegExp(r"Temperatura:\s*(\d+)\s*°C").firstMatch(line);
          final humidityMatch =
              RegExp(r"Humedad:\s*(\d+)\s*%").firstMatch(line);
          final dateMatch = RegExp(r"(\d{2}/\d{2}/\d{4} \d{2}:\d{2}:\d{2})")
              .firstMatch(line);

          if (temperatureMatch != null &&
              humidityMatch != null &&
              dateMatch != null) {
            return {
              'date': dateMatch.group(1)!,
              'temperature': temperatureMatch.group(1)!,
              'humidity': humidityMatch.group(1)!,
            };
          }
          return <String, String>{};
        })
        .where((data) => data.isNotEmpty)
        .take(12)
        .toList();

    return data;
  }
  return [];
}

// Guardar los datos en SharedPreferences
Future<void> saveSensorDataToPreferences(List<Map<String, String>> data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String encodedData = jsonEncode(data); // Convertir a formato JSON
  await prefs.setString('sensorData', encodedData); // Guardar el JSON como string
}

// Función para cargar los datos desde SharedPreferences
Future<List<Map<String, String>>> loadSensorDataFromPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  
  // Obtener la cadena de datos almacenados
  String? encodedData = prefs.getString('sensorData');
  
  if (encodedData != null) {
    // Si los datos existen, convertir la cadena JSON de vuelta a una lista de mapas
    List<dynamic> decodedData = json.decode(encodedData);
    
    // Convertir la lista dinámica a una lista de Map<String, String>
    List<Map<String, String>> sensorData = List<Map<String, String>>.from(decodedData.map((item) => Map<String, String>.from(item)));
    
    return sensorData;
  }
  
  // Si no se encuentran datos guardados, devolver una lista vacía
  return [];
}


Future<void> deleteSensorDataFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('sensorData');
  }
