import 'dart:convert'; // Necesario para decodificar jsonData
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartWidget extends StatelessWidget {
  final String jsonData; // Recibe jsonData como un String

  const PieChartWidget({super.key, required this.jsonData});

  @override
  Widget build(BuildContext context) {
    // Decodifica el JSON para convertirlo en un mapa
    final Map<String, dynamic> data = _parseJsonData(jsonData);

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sectionsSpace: 4,
              centerSpaceRadius: 40,
              sections: _getPieChartSections(data), // Pasa los datos a la función de secciones
            ),
          ),
        ),
        _buildLegend(data),
      ],
    );
  }

  // Función para parsear el jsonData a un mapa de días y temperaturas
  Map<String, dynamic> _parseJsonData(String jsonData) {
    // Decodificar el JSON, que ahora es un mapa
    final decodedData = jsonDecode(jsonData);
    return decodedData as Map<String, dynamic>;
  }

  // Crear las secciones de la gráfica con los datos
  List<PieChartSectionData> _getPieChartSections(Map<String, dynamic> data) {
    final List<PieChartSectionData> sections = [];
    final List<Color> colors = [
      Colors.brown.shade300, Colors.brown.shade400, Colors.brown.shade500,
      Colors.brown.shade600, Colors.brown.shade700, Colors.brown.shade800,
      Colors.brown.shade900,
    ];

    int colorIndex = 0;

    // Iterar sobre los datos y crear una sección por cada día con temperatura
    data.forEach((dayName, value) {
      final temperature = value['temperature']; // Ahora directamente usas el valor numérico
      final tempValue = temperature is int ? temperature : 0; // Verifica que sea int, usa 0 si no lo es

      if (tempValue != 0) { // Solo agregar si la temperatura es válida
        sections.add(PieChartSectionData(
          color: colors[colorIndex++],
          value: tempValue.toDouble(),
          title: dayName,
          radius: 50,
          titleStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ));
      }
    });

    return sections;
  }

  // Construir la leyenda del gráfico
  Widget _buildLegend(Map<String, dynamic> data) {
    final List<Color> colors = [
      Colors.brown.shade300, Colors.brown.shade400, Colors.brown.shade500,
      Colors.brown.shade600, Colors.brown.shade700, Colors.brown.shade800,
      Colors.brown.shade900,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(data.length, (index) {
        final entry = data.entries.elementAt(index);
        final dayName = entry.key;
        final temperature = entry.value['temperature'];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            children: [
              Container(
                width: 16,
                height: 16,
                color: colors[index],
              ),
              SizedBox(width: 8),
              Text('$dayName: $temperature°C'), // Mostrar temperatura directamente
            ],
          ),
        );
      }),
    );
  }
}
