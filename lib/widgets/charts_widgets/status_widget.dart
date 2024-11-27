import 'package:flutter/material.dart';

class BeeStatusWidget extends StatelessWidget {
  final int temperature;
  final int humidity;

  const BeeStatusWidget({super.key, required this.temperature, required this.humidity});

  @override
  Widget build(BuildContext context) {
    String imagePath;
    String statusText;
    String datas;

    print('pasado: $temperature, $humidity');

    // Determinar el estado de las abejas según la temperatura y humedad
    if (temperature >= 27 && humidity >= 66 && humidity <= 72) {
      imagePath = 'assets/images/Cool.png';
      statusText = 'Tus abejas están Cool';
      datas = 'Con $temperature°c y $humidity% de humedad';
      
    } else if (temperature >= 24 && temperature <= 26 && humidity >= 55 && humidity <= 65) {
      imagePath = 'assets/images/Regular.png';
      statusText = 'Tus abejas están Regular';
      datas = 'Con $temperature°c y $humidity% de humedad';
    } else if (temperature >= 18 && temperature <= 23 && humidity >= 40 && humidity <= 54) {
      imagePath = 'assets/images/Enferma.png';
      statusText = 'Tus abejas están Enfermas';
      datas = 'Con $temperature°c y $humidity% de humedad';
    } else {
      // Si no entra en ninguna de las condiciones anteriores, se asume que están "Muertas"
      imagePath = 'assets/images/Muerta.png';
      statusText = 'Tus abejas están Muertas';
      datas = 'Temperatura y humedad no son compatibles con las condiciones normales'; 
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath, width: 150, height: 150),
        SizedBox(height: 5),
        Text(
          statusText,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          datas,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
