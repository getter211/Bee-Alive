import 'package:flutter/material.dart';
import '../login/login_page.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bee-Alive',
      theme: ThemeData(
        primaryColor: Colors.brown,
        fontFamily: 'Arial',
      ),
      home: const RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                      'Registrate',
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
                      '¡Regístrate  para ser parte de nosotros!',
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
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Nombre',
                        filled: true,
                        fillColor: Color(0xFFF3E5F5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null) {
                          return 'Ingresa Su nombre';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 35),
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
                    const SizedBox(height: 35),
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
                    const SizedBox(height: 35),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            // Lógica de autenticación
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFB27C34),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Registrate',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Ya estoy registrado',
                          style: TextStyle(color: Colors.brown),
                        ),
                                          TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text(
                      'Iniciar sesión',
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
