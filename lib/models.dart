import 'package:flutter/material.dart';

class Planet {
  String planetName;
  double distance;
  double orbitRadius;
  Color color;
  double angle = 0.0;
  double orbitDuration;

  Planet({
    required this.planetName,
    required this.distance,
    required this.orbitRadius,
    required this.color,
    required this.orbitDuration,
  });
}
