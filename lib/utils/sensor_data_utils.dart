import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'dart:io' show File;
import 'package:flutter/foundation.dart';

Future<List<Map<String, String>>> loadSensorDataFromFiles() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['txt'],
    allowMultiple: true,
  );

  List<Map<String, String>> allData = [];

  if (result != null) {
    for (var file in result.files) {
      String fileContent;

      if (kIsWeb) {
        Uint8List? fileBytes = file.bytes;
        if (fileBytes != null) {
          fileContent = utf8.decode(fileBytes);
        } else {
          throw Exception("No se pudo leer el archivo en Flutter Web.");
        }
      } else {
        String? filePath = file.path;
        if (filePath != null) {
          File localFile = File(filePath);
          fileContent = await localFile.readAsString();
        } else {
          throw Exception("No se pudo leer el archivo en plataformas móviles.");
        }
      }

      fileContent = fileContent.replaceAllMapped(
        RegExp(
            r"(\d{1,2}/\d{2}/\d{4}) (\d{1,2}):(\d{1,2}):(\d{1,2})"), 
        (match) =>
            "${match.group(1)} ${match.group(2)!.padLeft(2, '0')}:${match.group(3)!.padLeft(2, '0')}:${match.group(4)!.padLeft(2, '0')}",
      );

      List<Map<String, String>> data = fileContent
          .split('\n')
          .map((line) =>
              line.trim())
          .where((line) => line.isNotEmpty)
          .map((line) {
            final temperatureMatch =
                RegExp(r"Temperatura:\s*(\d+)\s*°C").firstMatch(line);
            final humidityMatch =
                RegExp(r"Humedad:\s*(\d+)\s*%").firstMatch(line);
            final dateMatch = RegExp(r"(\d{1,2}/\d{2}/\d{4} \d{2}:\d{2}:\d{2})")
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
          .toList();

      allData.addAll(data);
    }
    return allData;
  }

  return [];
}

Future<void> saveSensorDataToPreferences(List<Map<String, String>> data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String encodedData = jsonEncode(data);
  await prefs.setString('sensorData', encodedData);
}

Future<List<Map<String, String>>> loadSensorDataFromPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  String? encodedData = prefs.getString('sensorData');

  if (encodedData != null) {
    List<dynamic> decodedData = json.decode(encodedData);
    List<Map<String, String>> sensorData = List<Map<String, String>>.from(
        decodedData.map((item) => Map<String, String>.from(item)));

    return sensorData;
  }

  return [];
}

Future<void> deleteSensorDataFromPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('sensorData');
}
