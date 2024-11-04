// import 'dart:async'; // Importa dart:async para usar Timer
// import 'package:flutter/material.dart';
// import '../login/login_page.dart';
// import 'package:google_fonts/google_fonts.dart';

// class Splashscreen extends StatefulWidget {
//   const Splashscreen({super.key});

//   @override
//   State<Splashscreen> createState() => _SplashscreenState();
// }

// class _SplashscreenState extends State<Splashscreen> {
//   bool _showLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     Timer(const Duration(seconds: 2), () {
//       setState(() {
//         _showLoading = true;
//       });
//     });

//     Timer(const Duration(seconds: 4), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: const Color(0xFFFFF9DC),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/images/logo.png',
//                 width: 250,
//               ),
//               Text(
//                 'Bee-Alive',
//                 style: GoogleFonts.libreBaskerville(
//                   fontSize: 20,
//                   color: Colors.brown,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 280),
//               if (_showLoading) ...[
//                 const CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>(Colors.brown),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   'Cargando...',
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     color: Colors.brown,
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
