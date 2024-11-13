import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/data_history/data_history_page.dart';
import 'package:flutter_application_1/pages/home/home_page.dart';
import 'package:flutter_application_1/pages/login/login_page.dart';
import 'package:flutter_application_1/pages/chart/charts_page.dart';
import 'package:flutter_application_1/pages/presentation/presentation_page.dart';
import 'package:flutter_application_1/pages/register/register_page.dart';
import 'package:firebase_core/firebase_core.dart'; // Importa Firebase
import 'package:provider/provider.dart'; // Importa Provider para AuthProvider
import 'auth_provider.dart'; // Importa el AuthProvider
import 'firebase_options.dart'; // Importa las opciones de Firebase

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Inicializa Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()), // Proveedor de autenticación
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bee-Alive',
        routes: {
          '/': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/home': (context) => const HomeScreen(),
          '/history': (context) => const DataHistoryScreen(),
          '/chart': (context) => const ChartScreen(),
          '/presentation': (context) => const PresentationScreen(),
        },
      ),
    );
  }
}
