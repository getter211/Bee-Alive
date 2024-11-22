import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double imageSize =
        screenWidth < screenHeight ? screenWidth * 0.5 : screenHeight * 0.2;
    return Container(
      alignment: Alignment.center,
      child: Image(
        image: const AssetImage('assets/images/apiario2.png'),
        height: imageSize,
        width: imageSize,
        fit: BoxFit.contain,
      ),
    );
  }
}
