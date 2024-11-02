import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDisplay extends StatelessWidget {
  final String username;

  const UserDisplay({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Text(
      username,
      style: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.brown,
      ),
      textAlign: TextAlign.right,
    );
  }
}
