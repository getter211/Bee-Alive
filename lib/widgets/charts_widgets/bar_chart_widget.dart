import 'dart:convert'; // Necesario para decodificar jsonData
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartWidget extends StatelessWidget {
  final String jsonData;

  const BarChartWidget({super.key, required this.jsonData});

  @override
  Widget build(BuildContext context) {
    final Map<String, Map<String, dynamic>> data = _parseJsonData(jsonData);
    final List<String> days = data.keys.toList();

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          barGroups: _getBarChartData(data),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 40),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= 0 && value.toInt() < days.length) {
                    final shortDay = days[value.toInt()].substring(0, 3); // Solo las primeras 3 letras
                    return Text(shortDay);
                  }
                  return const Text('');
                },
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < days.length) {
                    final dayData = data[days[index]]!;
                    final humidity = dayData['humidity']?.toString() ?? '';
                    return Text('$humidity%', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Map<String, Map<String, dynamic>> _parseJsonData(String jsonData) {
    final decodedData = jsonDecode(jsonData) as Map<String, dynamic>;
    return decodedData.map((key, value) => MapEntry(key, Map<String, dynamic>.from(value)));
  }

  List<BarChartGroupData> _getBarChartData(Map<String, Map<String, dynamic>> data) {
    final List<BarChartGroupData> barGroups = [];
    final List<String> days = data.keys.toList();

    for (int i = 0; i < days.length; i++) {
      final dayData = data[days[i]]!;
      final humidity = int.tryParse(dayData['humidity']?.toString() ?? '0') ?? 0;

      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: humidity.toDouble(),
              color: Colors.brown,
            ),
          ],
        ),
      );
    }

    return barGroups;
  }
}
