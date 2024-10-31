import 'package:flutter/material.dart';

class CaptureButton extends StatelessWidget {
  const CaptureButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Lógica de captura
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFB27C34),
        shape: const CircleBorder(),
        padding: const EdgeInsets.symmetric(
            horizontal: 100, vertical: 100),
      ),
      child: const Text(
        'Capturar Datos',
        style: TextStyle(color: Color(0xFFEDDA6F), fontSize: 20),
      ),
    );
  }
}
