import 'package:flutter/material.dart';

class UserDisplay extends StatelessWidget {
  final String username;

  const UserDisplay({super.key, required this.username, required TextStyle textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      username,
      style: const TextStyle(
        fontSize: 20,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.bold,
        color: Colors.brown,
      ),
      textAlign: TextAlign.right,
    );
  }
}
