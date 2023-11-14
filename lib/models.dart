import 'package:flutter/material.dart';

class Planet {
  String planetRemotes;
  double distance;
  double orbitRadius;
  Color color;
  double angle = 0.0;

  Planet({
    required this.planetRemotes,
    required this.distance,
    required this.orbitRadius,
    required this.color,
  });
}
