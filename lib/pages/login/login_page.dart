import 'package:flutter/material.dart';
import '../register/register_page.dart';
import 'package:flutter_application_1/pages/home/home_page.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bee-Alive',
      theme: ThemeData(
        primaryColor: Colors.brown,
        fontFamily: 'Arial',
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                padding: const EdgeInsets.only(top: 35), // Añade un margen superior a toda la columna
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título "Iniciar sesión"
                    const Text(
                      'Iniciar sesión',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    
                    // Separador entre título y subtítulo
                    const SizedBox(height: 8),

                    // Subtítulo
                    const Text(
                      'Sea usted bienvenido.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.brown,
                      ),
                    ),

                    // Separador entre subtítulo y formulario
                    const SizedBox(height: 24),
                    
                    // Aquí puedes continuar agregando más widgets, como el formulario, etc.
                  ],
                ),
              ),

              const SizedBox(height: 35),
              // Formulario
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Campo de correo electrónico
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Correo electrónico',
                        filled: true,
                        fillColor: Color(0xFFF3E5F5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || !value.contains('@')) {
                          return 'Ingresa un correo válido';
                        }
                        return null;
                      },
                    ),

                    // Separador entre campos de texto
                    const SizedBox(height: 35),

                    // Campo de contraseña
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        filled: true,
                        fillColor: const Color(0xFFF3E5F5),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      obscureText: !_isPasswordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingresa una contraseña';
                        }
                        return null;
                      },
                    ),

                    // Separador entre el campo de contraseña y el botón de inicio de sesión
                    const SizedBox(height: 35),

                    // Botón de inicio de sesión
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                           if (_formKey.currentState?.validate() == true) {
                        //  Lógica de autenticación
                          }
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const HomeScreen()),
                            );
                          },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFB27C34),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Iniciar Sesión',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),

                    // Separador entre el botón y el texto de registro
                    const SizedBox(height: 16),

                    // Texto de registro
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          '¿Aún no tienes cuenta?',
                          style: TextStyle(color: Colors.brown),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RegisterPage()),
                            );
                          },
                          child: const Text(
                            'Registrate',
                            style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
