import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CaptureButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CaptureButton(
      {super.key,
      required this.onPressed,
      required double height,
      required double width});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color(0xFFEDDA6F),
        backgroundColor: const Color(0xFFB27C34), 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), 
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 15, horizontal: 30), 
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.2), 
        splashFactory: InkRipple.splashFactory, 
      ),
      child: Text(
        'Importar archivo',
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: const Color(0xFFEDDA6F), 
        ),
      ),
    );
  }
}
