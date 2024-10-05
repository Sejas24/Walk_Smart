import 'package:flutter/material.dart';
import 'package:baston_inteligente_mejorada/markers/markers.dart';

import 'screens.dart';

class TestMarkerScreen extends StatelessWidget {
  const TestMarkerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 350,
          height: 150,
          child: CustomPaint(
            painter: EndMarkerPainter(
              destination: 'Roosters Rest & Snack Bar',
              kilometers: 50,
            ),
          ),
        ),
      ),
    );
  }
}
