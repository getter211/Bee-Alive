import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CaptureButton extends StatelessWidget {
  const CaptureButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFB27C34),
        shape: const CircleBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 100),
      ),
      child: Text(
        'Obtener Datos',
        style: GoogleFonts.poppins(
          fontSize: 25,
          color: const Color(0xFFEDDA6F),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
