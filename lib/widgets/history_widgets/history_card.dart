import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/chart/charts_page.dart';

class HistorialCard extends StatelessWidget {
  final String semana; // Fecha
  final String hora; // Hora
  final IconData icono;

  const HistorialCard({
    super.key,
    required this.semana,
    required this.hora,
    this.icono = Icons.remove_red_eye_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFB27C34),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          "Fecha de la semana: $semana", // Displaying the date
          style: const TextStyle(color: Color(0xFFEDDA6F)),
        ),
        subtitle: Text(
          "Hora: $hora", // Displaying the time
          style: const TextStyle(color: Color(0xFFEDDA6F)),
        ),
        trailing: Icon(
          icono,
          color: const Color(0xFFEDDA6F),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChartScreen(),
            ),
          );
        },
      ),
    );
  }
}
