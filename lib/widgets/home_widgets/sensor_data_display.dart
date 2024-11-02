import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SensorDataDisplay extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const SensorDataDisplay({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 50, color: Colors.brown),
        const SizedBox(height: 8),
        Text(label,
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.brown)),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.brown,
          ),
        ),
      ],
    );
  }
}
