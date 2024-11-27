import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/charts_widgets/bar_chart_widget.dart';
import 'package:flutter_application_1/widgets/charts_widgets/pie_chart_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert'; // Necesario para jsonEncode()
import 'package:flutter_application_1/widgets/charts_widgets/status_widget.dart';

class ChartScreen extends StatelessWidget {
  final List<Map<String, dynamic>>? weekData;

  const ChartScreen({super.key, this.weekData});

  @override
  Widget build(BuildContext context) {
    // Cálculo de medias por día
    final Map<String, Map<String, int>> dailyAverages = _calculateDailyAverages();

    // Convierte fechas a días de la semana y crea jsonData
    final Map<String, Map<String, int>> dailyAveragesByDay = dailyAverages.map((date, values) {
      final dayName = _getDayOfWeek(date); // Convertir fecha a día
      return MapEntry(dayName, values);
    });

    // Convierte dailyAveragesByDay a JSON string
    final jsonData = jsonEncode(dailyAveragesByDay);
    

    // Obtener medias redondeadas
    final roundedAverages = _getRoundedAverages(dailyAverages);

    return Scaffold(
      backgroundColor: const Color(0xFFFDF2CF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Gráficas de la Semana',
          style: GoogleFonts.poppins(
              color: Colors.brown, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildCard(child: BeeStatusWidget(
                temperature: roundedAverages['temperature']!,
                humidity: roundedAverages['humidity']!,
              )),
              const SizedBox(height: 20),
              _buildCard(child: BarChartWidget(jsonData: jsonData)),
              const SizedBox(height: 20),
              _buildCard(child: PieChartWidget(jsonData: jsonData)),
            ],
          ),
        ),
      ),
    );
  }

  // Método para calcular las medias por día
  Map<String, Map<String, int>> _calculateDailyAverages() {
    if (weekData == null || weekData!.isEmpty) {
      return {};
    }

    final Map<String, List<Map<String, int>>> groupedData = {};

    // Agrupar datos por fecha
    for (var entry in weekData!) {
      final date = (entry['date'] as String).split(' ')[0]; // Extraer solo la fecha

      // Manejar valores nulos
      final temperature = entry['temperature'] != null
          ? int.parse(entry['temperature'].toString())
          : 0;
      final humidity = entry['humidity'] != null
          ? int.parse(entry['humidity'].toString()) // Usar 'humidity' correctamente
          : 0;

      groupedData.putIfAbsent(date, () => []);
      groupedData[date]!.add({'temperature': temperature, 'humidity': humidity});
    }

    // Calcular medias redondeadas
    final Map<String, Map<String, int>> dailyAverages = {};
    groupedData.forEach((date, values) {
      final totalTemperature =
          values.fold(0, (sum, item) => sum + item['temperature']!);
      final totalHumidity =
          values.fold(0, (sum, item) => sum + item['humidity']!);

      final averageTemperature = (totalTemperature / values.length).round();
      final averageHumidity = (totalHumidity / values.length).round();
      print('Contenidozzz: $averageTemperature, $averageHumidity');

      dailyAverages[date] = {
        'temperature': averageTemperature,
        'humidity': averageHumidity,
      };
    }
    );

    return dailyAverages;
  }
// Método para obtener medias redondeadas
Map<String, int> _getRoundedAverages(Map<String, Map<String, int>> dailyAverages) {
  if (dailyAverages.isEmpty) {
    return {'temperature': 0, 'humidity': 0}; // Evita división por cero si no hay datos
  }

  final averageTemperature = dailyAverages.values.fold(0, (sum, item) => sum + item['temperature']!) / dailyAverages.length;
  final averageHumidity = dailyAverages.values.fold(0, (sum, item) => sum + item['humidity']!) / dailyAverages.length;

  // Redondear antes de retornar
  final roundedTemperature = averageTemperature.isNaN ? 0 : averageTemperature.round();
  final roundedHumidity = averageHumidity.isNaN ? 0 : averageHumidity.round();

  print('Contenido redondeado: $roundedTemperature, $roundedHumidity');

  return {
    'temperature': roundedTemperature,
    'humidity': roundedHumidity,
  };
}


  // Función para calcular el día de la semana basado en una fecha (yyyy-MM-dd)
  String _getDayOfWeek(String date) {
    final parts = date.split('/');
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);

    final adjustedMonth = (month < 3) ? month + 12 : month;
    final adjustedYear = (month < 3) ? year - 1 : year;

    final k = adjustedYear % 100;
    final j = (adjustedYear / 100).floor();

    final f = day +
        ((13 * (adjustedMonth + 1)) / 5).floor() +
        k +
        (k / 4).floor() +
        (j / 4).floor() -
        (2 * j);

    final dayOfWeek = ((f % 7) + 7) % 7; // Asegurar valor positivo

    const days = ['Sábado', 'Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes'];

    return days[dayOfWeek];
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      shadowColor: Colors.brown.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
