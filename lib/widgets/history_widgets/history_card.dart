import 'package:flutter/material.dart';

class HistorialCard extends StatelessWidget {
  final String semana;
  final String hora;
  final IconData icono;
  final List<Map<String, String>> dayData;

  const HistorialCard({
    super.key,
    required this.semana,
    required this.hora,
    this.icono = Icons.remove_red_eye_outlined,
    required this.dayData,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFB27C34),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          "Fecha de la semana: $semana",
          style: const TextStyle(color: Color(0xFFEDDA6F)),
        ),
        subtitle: Text(
          "Hora: $hora",
          style: const TextStyle(color: Color(0xFFEDDA6F)),
        ),
        trailing: Icon(
          icono,
          color: const Color(0xFFEDDA6F),
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: const Color(0xFFB27C34),
                title: Text(
                  'Datos del día: $semana',
                  style: const TextStyle(color: Color(0xFFEDDA6F)),
                ),
                content: SizedBox(
                  width: double.maxFinite,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: dayData.length,
                    itemBuilder: (context, index) {
                      final data = dayData[index];
                      String date = data['date'] ?? 'N/A';
                      String temperature = data['temperature'] ?? 'N/A';
                      String humidity = data['humidity'] ?? 'N/A';
                      return ListTile(
                        title: Text(
                          'Fecha: $date',
                          style: const TextStyle(color: Color(0xFFEDDA6F)),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Temperatura: $temperature°C',
                              style: const TextStyle(color: Color(0xFFEDDA6F)),
                            ),
                            Text(
                              'Humedad: $humidity%',
                              style: const TextStyle(color: Color(0xFFEDDA6F)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cerrar',
                      style: TextStyle(color: Color(0xFFEDDA6F)),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
