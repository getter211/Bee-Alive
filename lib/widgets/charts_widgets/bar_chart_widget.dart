// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          barGroups: _getBarChartData(),
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
                  switch (value.toInt()) {
                    case 0:
                      return Text('Lun');
                    case 1:
                      return Text('Mar');
                    case 2:
                      return Text('Mié');
                    case 3:
                      return Text('Jue');
                    case 4:
                      return Text('Vie');
                    case 5:
                      return Text('Sáb');
                    case 6:
                      return Text('Dom');
                    default:
                      return Text('');
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Sample data for Bar Chart
  List<BarChartGroupData> _getBarChartData() {
    return [
      BarChartGroupData(
          x: 0, barRods: [BarChartRodData(toY: 3, color: Colors.brown)]),
      BarChartGroupData(
          x: 1, barRods: [BarChartRodData(toY: 4, color: Colors.brown)]),
      BarChartGroupData(
          x: 2, barRods: [BarChartRodData(toY: 2, color: Colors.brown)]),
      BarChartGroupData(
          x: 3, barRods: [BarChartRodData(toY: 5, color: Colors.brown)]),
      BarChartGroupData(
          x: 4, barRods: [BarChartRodData(toY: 3, color: Colors.brown)]),
      BarChartGroupData(
          x: 5, barRods: [BarChartRodData(toY: 4, color: Colors.brown)]),
      BarChartGroupData(
          x: 6, barRods: [BarChartRodData(toY: 2, color: Colors.brown)]),
    ];
  }
}
