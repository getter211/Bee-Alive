import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/data_history/data_history_page.dart';
import 'package:flutter_application_1/pages/home/home_page.dart';
import 'package:flutter_application_1/pages/splash/splash_page.dart';
import 'package:flutter_application_1/pages/chart/charts_page.dart';
import 'package:flutter_application_1/pages/presentation/presentation_page.dart';

import 'services_providers/notification_S.dart';  // Asegúrate de importar el NotificationService

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegura que la inicialización se haga antes de ejecutar el app.
  
  // Inicializa el servicio de notificaciones
  await NotificationService().initNotification();
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bee Alive',
      routes: {
        '/': (context) => const Splashscreen(),
        '/home': (context) => const HomeScreen(),
        '/history': (context) => const DataHistoryScreen(),
        '/chart': (context) => const ChartScreen(),
        '/presentation': (context) => const PresentationScreen(),
      },
    );
  }
}
