import 'package:flutter/material.dart';

class BeeStatusWidget extends StatelessWidget {
  final int temperature;
  final int humidity;

  const BeeStatusWidget({
    super.key,
    required this.temperature,
    required this.humidity,
  });

  @override
  Widget build(BuildContext context) {
    String imagePath;
    String statusText;
    String datas;

    print('Datos recibidos: temperature = $temperature, humidity = $humidity');

    // Determinar el estado de las abejas según la temperatura y humedad
    if (temperature >= 27 && humidity >= 66 && humidity <= 77) {
      imagePath = 'assets/images/Cool.png';
      statusText = 'Tus abejas están Cool';
      datas = 'Con $temperature°c y $humidity% de humedad';
    } else if (temperature >= 24 && temperature <= 26 && humidity >= 55 && humidity <= 65) {
      imagePath = 'assets/images/Regular.png';
      statusText = 'Tus abejas están Regular';
      datas = 'Con $temperature°c y $humidity% de humedad';
    } else if (temperature >= 19 && temperature <= 23 && humidity >= 44 && humidity <= 54) {
      imagePath = 'assets/images/Enferma.png';
      statusText = 'Tus abejas están Enfermas';
      datas = 'Con $temperature°c y $humidity% de humedad';
    } else if ((temperature <= 15 || temperature >= 18) || (humidity <= 20 || humidity <= 43)) {
      imagePath = 'assets/images/Muerta.png';
      statusText = 'Tus abejas están Muertas';
      datas = 'Temperaturas fuera del rango de 15°c - 18°c, humedad fuera del rango de 20% - 39%.';
      print('Condición de muerte: temperature = $temperature, humidity = $humidity');
    } else {
      imagePath = 'assets/images/what.png';
      statusText = 'Tus abejas están Confundidas';
      datas = 'Datos no compatibles con las condiciones normales o sucede algo inesperado';
      print('Condición inesperada: temperature = $temperature, humidity = $humidity');
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          width: 150,
          height: 150,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.broken_image, size: 150, color: Colors.grey);
          },
        ),
        SizedBox(height: 10),
        Text(
          statusText,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 5),
        Text(
          datas,
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
