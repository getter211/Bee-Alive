import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Dashboarddtos/sensor_dto.dart';

class SensorServices {
  static Future<SensorData> getSensorData() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.8.8:3000/api/sensor/sensorData'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> sensors = jsonDecode(response.body);

        if (sensors.isNotEmpty) {
          return SensorData.fromJson(
              sensors[0]); // Suponiendo que la respuesta es una lista
        } else {
          throw Exception('No sensor data available');
        }
      } else {
        throw Exception(
            'Failed to load sensor data, status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred while fetching sensor data: $e');
    }
  }
}
