import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sectionsSpace: 4,
              centerSpaceRadius: 40,
              sections: _getPieChartSections(),
            ),
          ),
        ),
        _buildLegend(),
        _buildMaxTempAndHumidityBox(),
      ],
    );
  }

  Widget _buildLegend() {
    final List<String> days = [
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado',
      'Domingo'
    ];
    final List<Color> colors = [
      Colors.brown.shade300,
      Colors.brown.shade400,
      Colors.brown.shade500,
      Colors.brown.shade600,
      Colors.brown.shade700,
      Colors.brown.shade800,
      Colors.brown.shade900,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(days.length, (index) {
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
              Text(days[index]),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildMaxTempAndHumidityBox() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Temp. max.: 31°C',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Humedad max.: 75%',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _getPieChartSections() {
    return [
      PieChartSectionData(
        color: Colors.brown.shade300,
        value: 15,
        title: 'Lunes',
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.brown.shade400,
        value: 20,
        title: 'Martes',
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.brown.shade500,
        value: 18,
        title: 'Miércoles',
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.brown.shade600,
        value: 22,
        title: 'Jueves',
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.brown.shade700,
        value: 10,
        title: 'Viernes',
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.brown.shade800,
        value: 10,
        title: 'Sábado',
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.brown.shade900,
        value: 10,
        title: 'Domingo',
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }
}
