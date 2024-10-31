import 'package:flutter/material.dart';

class SensorDataDisplay extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;

  const SensorDataDisplay({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required int iconSize,
    required this.iconColor, required TextStyle labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 40, color: Colors.brown),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.brown)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.brown)),
      ],
    );
  }
}
