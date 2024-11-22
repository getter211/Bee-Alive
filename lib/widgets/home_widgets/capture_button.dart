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
        backgroundColor: const Color(0xFFB27C34), // Color de texto
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Bordes redondeados
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 15, horizontal: 30), // Espaciado
        elevation: 5, // Sombra para el botón
        shadowColor: Colors.black.withOpacity(0.2), // Color de la sombra
        splashFactory: InkRipple.splashFactory, // Efecto de toque
      ),
      child: Text(
        'Importar archivo',
        style: GoogleFonts.poppins(
          fontSize: 16, // Ajuste de tamaño de texto
          fontWeight: FontWeight.bold,
          color: Color(0xFFEDDA6F), // Color del texto
        ),
      ),
    );
  }
}
