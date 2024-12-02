// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/charts_widgets/bar_chart_widget.dart';
import 'package:flutter_application_1/widgets/charts_widgets/pie_chart_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:flutter_application_1/widgets/charts_widgets/status_widget.dart';

class ChartScreen extends StatefulWidget {
  final List<Map<String, dynamic>>? weekData;

  const ChartScreen({super.key, this.weekData});

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  bool _isLoading = true;
  Map<String, Map<String, int>>? dailyAverages;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // Simula un tiempo de carga para tus datos
    await Future.delayed(const Duration(seconds: 2));

    final Map<String, Map<String, int>> averages = _calculateDailyAverages();
    setState(() {
      dailyAverages = averages;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Graficas Semanales',
            style: GoogleFonts.poppins(color: Colors.brown, fontSize: 20),
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(), // Indicador de carga
        ),
      );
    }

    final Map<String, Map<String, int>> dailyAveragesByDay =
        dailyAverages!.map((date, values) {
      final dayName = _getDayOfWeek(date); // Convertir fecha a día
      return MapEntry(dayName, values);
    });
    final jsonData = jsonEncode(dailyAveragesByDay);

    final roundedAverages = _getRoundedAverages(dailyAverages!);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF9DC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Graficas Semanales',
          style: GoogleFonts.poppins(color: Colors.brown, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Status Widget
              _buildCard(
                child: BeeStatusWidget(
                  temperature: roundedAverages['temperature']!,
                  humidity: roundedAverages['humidity']!,
                ),
              ),
              const SizedBox(height: 20),

              // Bar Chart Widget
              _buildCard(
                child: BarChartWidget(jsonData: jsonData),
              ),
              const SizedBox(height: 20),

              // Pie Chart Widget
              _buildCard(
                child: PieChartWidget(jsonData: jsonData),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, Map<String, int>> _calculateDailyAverages() {
    if (widget.weekData == null || widget.weekData!.isEmpty) {
      return {};
    }

    final Map<String, List<Map<String, int>>> groupedData = {};

    for (var entry in widget.weekData!) {
      final date = (entry['date'] as String).split(' ')[0];
      final temperature = entry['temperature'] != null
          ? int.parse(entry['temperature'].toString())
          : 0;
      final humidity = entry['humidity'] != null
          ? int.parse(entry['humidity'].toString())
          : 0;

      groupedData.putIfAbsent(date, () => []);
      groupedData[date]!
          .add({'temperature': temperature, 'humidity': humidity});
    }

    final Map<String, Map<String, int>> dailyAverages = {};
    groupedData.forEach((date, values) {
      final totalTemperature =
          values.fold(0, (sum, item) => sum + item['temperature']!);
      final totalHumidity =
          values.fold(0, (sum, item) => sum + item['humidity']!);

      final averageTemperature = (totalTemperature / values.length).round();
      final averageHumidity = (totalHumidity / values.length).round();
      dailyAverages[date] = {
        'temperature': averageTemperature,
        'humidity': averageHumidity,
      };
    });

    return dailyAverages;
  }

  Map<String, int> _getRoundedAverages(
      Map<String, Map<String, int>> dailyAverages) {
    final averageTemperature = dailyAverages.values
            .fold(0, (sum, item) => sum + item['temperature']!) /
        dailyAverages.length;
    final averageHumidity =
        dailyAverages.values.fold(0, (sum, item) => sum + item['humidity']!) /
            dailyAverages.length;

    return {
      'temperature': averageTemperature.isNaN ? 0 : averageTemperature.round(),
      'humidity': averageHumidity.isNaN ? 0 : averageHumidity.round(),
    };
  }

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

    final dayOfWeek = ((f % 7) + 7) % 7;

    const days = [
      'Sábado',
      'Domingo',
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes'
    ];
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
