import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PresentationScreen extends StatelessWidget {
  const PresentationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFDF2CF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Acerca de Bee Alive',
          style: GoogleFonts.poppins(
            fontSize: 22,
            color: Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.brown),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.05),
                // Logo
                Image.asset(
                  'assets/images/logo.png',
                  width: screenWidth * 0.6,
                  height: screenHeight * 0.2,
                ),
                SizedBox(height: screenHeight * 0.03),
                // Descripción
                Text(
                  'Bee Alive es una aplicación dedicada a la preservación de las abejas y la concientización sobre su importancia en nuestro ecosistema.',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.brown[800],
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.04),
                // Contacto
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.email, color: Colors.brown),
                        const SizedBox(width: 8),
                        Text(
                          'Soporte@beealive.com',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.brown[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.phone, color: Colors.brown),
                        const SizedBox(width: 8),
                        Text(
                          '+1 800 555 1234',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.brown[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
