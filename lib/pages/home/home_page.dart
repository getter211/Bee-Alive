import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/capture_button.dart';
import '../../widgets/drawer_home.dart';
import '../../widgets/sensor_data_display.dart';
import '../../widgets/user_display.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.brown,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 20),
        ],
      ),
      backgroundColor: const Color(0xFFFFF9DC),
      drawer: const DrawerHome(),
      drawerScrimColor: const Color.fromARGB(221, 88, 88, 88),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8.0),
            child: UserDisplay(
              username: 'LaloGmer333',
              textStyle: GoogleFonts.poppins(
                fontSize: 20,
                color: Colors.brown,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                double screenWidth = MediaQuery.of(context).size.width;
                bool isWideScreen = screenWidth > 600;
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 80),
                      const CaptureButton(),
                      const SizedBox(height: 70),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SensorDataDisplay(
                            icon: Icons.thermostat_outlined,
                            label: 'Temperatura',
                            value: '00',
                            labelStyle: GoogleFonts.poppins(
                              fontSize: isWideScreen ? 24 : 16,
                              color: Colors.brown,
                              fontWeight: FontWeight.w600,
                            ),
                            iconSize: isWideScreen ? 40 : 24,
                            iconColor: Colors.brown,
                          ),
                          SensorDataDisplay(
                            icon: Icons.water_drop_outlined,
                            label: 'Humedad',
                            value: '00',
                            labelStyle: GoogleFonts.poppins(
                              fontSize: isWideScreen ? 24 : 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                            iconSize: isWideScreen ? 40 : 24,
                            iconColor: Colors.blue,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
