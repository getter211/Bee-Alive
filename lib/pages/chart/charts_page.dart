import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/charts_widgets/bar_chart_widget.dart';
import 'package:flutter_application_1/widgets/charts_widgets/pie_chart_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF2CF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Graficas de la Semana',
          style: GoogleFonts.poppins(
              color: Colors.brown, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildCard(child: const BarChartWidget()),
              const SizedBox(height: 20),
              _buildCard(child: const PieChartWidget()),
            ],
          ),
        ),
      ),
    );
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
