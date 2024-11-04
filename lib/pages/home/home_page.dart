import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login/login_page.dart';
import '../../widgets/home_widgets/capture_button.dart';
import '../../widgets/home_widgets/drawer_home.dart';
import '../../widgets/home_widgets/sensor_data_display.dart';
import '../../widgets/home_widgets/user_display.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
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
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.1,
              vertical: 8.0,
            ),
            child: const UserDisplay(
              username: 'LaloGmer333',
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.1),
                  const CaptureButton(),
                  SizedBox(height: screenHeight * 0.08),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SensorDataDisplay(
                        icon: Icons.thermostat_outlined,
                        label: 'Temperatura',
                        value: '00',
                      ),
                      SensorDataDisplay(
                        icon: Icons.water_drop_outlined,
                        label: 'Humedad',
                        value: '00',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
