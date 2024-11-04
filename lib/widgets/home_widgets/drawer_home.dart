import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/data_history/data_history_page.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../pages/presentation/presentation_page.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFFFF9DC),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Image.asset(
                    'assets/images/logo.png',
                    width: 150,
                    height: 100,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Bee-Alive',
                    style: GoogleFonts.libreBaskerville(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.transparent),
            const SizedBox(height: 20),
            ListTile(
              title: Text(
                'Historial de Datos',
                style: GoogleFonts.poppins(
                  color: Colors.brown,
                ),
              ),
              trailing: const Icon(
                Icons.file_copy_sharp,
                color: Colors.brown,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DataHistoryScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(
                'Info',
                style: GoogleFonts.poppins(
                  color: Colors.brown,
                ),
              ),
              trailing: const Icon(
                Icons.info_outline,
                color: Colors.brown,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const PresentationScreen();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
