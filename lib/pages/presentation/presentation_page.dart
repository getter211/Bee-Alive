import 'package:flutter/material.dart';

class PresentationScreen extends StatelessWidget {
  const PresentationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el ancho y alto de la pantalla
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF2CF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Acerca de Bee Alive',
          style: TextStyle(
            fontSize: 20,
            color: Colors.brown,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.brown),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: screenHeight * 0.1), // Ajuste dinámico del espaciado
              Image.asset(
                'assets/images/logo.png',
                width: screenWidth * 0.4, // Hace la imagen más responsive
                height: screenHeight * 0.2, // Ajuste dinámico de la altura
              ),
              SizedBox(height: screenHeight * 0.05), // Espaciado más flexible
              Text(
                'Bee Alive',
                style: TextStyle(
                  fontSize: screenWidth * 0.08, // Hacer el texto más responsive
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              SizedBox(height: screenHeight * 0.03), // Ajustar espaciado
              Text(
                'Bee Alive es una aplicación dedicada a la preservación de las abejas y la concientización sobre su importancia en nuestro ecosistema.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth *
                      0.05, // Hacer el texto más pequeño en pantallas pequeñas
                  color: Colors.brown,
                ),
              ),
              SizedBox(height: screenHeight * 0.30),
              Text(
                'Copyright © Bee alive 2024  ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth *
                      0.05, // Hacer el texto más pequeño en pantallas pequeñas
                  color: Colors.brown,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
