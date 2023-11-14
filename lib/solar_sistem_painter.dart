import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kun_systemasy/models.dart';

class SolarSystemFullPainter extends CustomPainter {
  late List<Planet> _planets;

  SolarSystemFullPainter(this._planets);

  @override
  void paint(Canvas canvas, Size size) {
    final sunPaint = Paint()..color = Colors.yellow;

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 40, sunPaint);
    for (int i = 0; i < _planets.length; i++) {
      var planet = _planets[i];
      final radius = planet.distance;
      final orbitRadius = planet.orbitRadius;

      var angle = planet.angle;
      final color = planet.color;

      final planetPaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      final x = size.width / 2 + orbitRadius * cos(angle);
      final y = size.height / 2 + orbitRadius * sin(angle);

      final orbitPaint = Paint()
        ..color = Colors.white.withOpacity(0.3)
        ..style = PaintingStyle.stroke;

      canvas.drawCircle(
          Offset(size.width / 2, size.height / 2), orbitRadius, orbitPaint);

      final highLightPaint = Paint()
        ..color = Colors.green.withOpacity(0.8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0;

      var rect = Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2), radius: orbitRadius);

      canvas.drawArc(rect, 0, angle, false, highLightPaint);

      canvas.drawCircle(Offset(x, y), radius, planetPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
