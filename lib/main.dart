import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/chart/charts_page.dart';
import 'package:flutter_application_1/pages/data_history/data_history_page.dart';
import 'package:flutter_application_1/pages/home/home_page.dart';
import 'pages/presentation/presentation_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bee Alive',
      routes: {
        '/': (context) => const HomeScreen(),
        // '/register': (context) => const RegisterScreen(),
        '/history': (context) => const DataHistoryScreen(),
        '/chart': (context) => const ChartScreen(),
        '/presentation': (context) => const PresentationScreen(),
      },
    );
  }
}
