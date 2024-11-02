import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/history_widgets/history_card.dart';
import 'package:flutter_application_1/widgets/history_widgets/search_week_field.dart';
import 'package:google_fonts/google_fonts.dart';

class DataHistoryScreen extends StatelessWidget {
  const DataHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF2CF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Historial de Datos',
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: Colors.brown,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: SearchWeekWidget(
                controller: TextEditingController(),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Semanas de monitorización',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: Colors.brown,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return const Column(
                    children: [
                      HistorialCard(
                        semana: 'Semana',
                        anio: '2022',
                      ),
                      SizedBox(height: 16),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
