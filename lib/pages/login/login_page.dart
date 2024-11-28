// import 'package:flutter/material.dart';
// import '../register/register_page.dart';
// import 'package:flutter_application_1/pages/home/home_page.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   bool _isPasswordVisible = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFFF8E1),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: const EdgeInsets.only(top: 35),
//                 child: const Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Iniciar sesión',
//                       style: TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.brown,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'Sea usted bienvenido.',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.brown,
//                       ),
//                     ),
//                     SizedBox(height: 24),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 35),
//               // Formulario
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     // Campo de correo electrónico
//                     TextFormField(
//                       decoration: const InputDecoration(
//                         labelText: 'Correo electrónico',
//                         filled: true,
//                         fillColor: Color(0xFFF3E5F5),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                         ),
//                       ),
//                       keyboardType: TextInputType.emailAddress,
//                       validator: (value) {
//                         if (value == null || !value.contains('@')) {
//                           return 'Ingresa un correo válido';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 35),
//                     TextFormField(
//                       decoration: InputDecoration(
//                         labelText: 'Contraseña',
//                         filled: true,
//                         fillColor: const Color(0xFFF3E5F5),
//                         border: const OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                         ),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _isPasswordVisible
//                                 ? Icons.visibility
//                                 : Icons.visibility_off,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _isPasswordVisible = !_isPasswordVisible;
//                             });
//                           },
//                         ),
//                       ),
//                       obscureText: !_isPasswordVisible,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Ingresa una contraseña';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 35),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           if (_formKey.currentState?.validate() == true) {
//                             Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const HomeScreen()),
//                             );
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFFB27C34),
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: const Text(
//                           'Iniciar Sesión',
//                           style: TextStyle(fontSize: 18, color: Colors.white),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           '¿Aún no tienes cuenta?',
//                           style: TextStyle(color: Colors.brown),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const RegisterScreen()),
//                             );
//                           },
//                           child: const Text(
//                             'Registrate',
//                             style: TextStyle(
//                               color: Colors.purple,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
