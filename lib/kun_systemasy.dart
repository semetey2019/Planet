import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kun_systemasy/add_planet_page.dart';
import 'package:kun_systemasy/models.dart';

class KunSistemasy extends StatefulWidget {
  const KunSistemasy({Key? key}) : super(key: key);

  @override
  State<KunSistemasy> createState() => _KunSistemasyState();
}

class _KunSistemasyState extends State<KunSistemasy>
    with TickerProviderStateMixin {
  late List<Planet> _planets;
  late List<AnimationController> _planetControllers;
  late AnimationController _sunAnimationController;

  @override
  void initState() {
    _sunAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      upperBound: 2 * pi,
    );

    _planets = [];
    _planetControllers = [];

    _sunAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _sunAnimationController.repeat();
      }
    });
    _sunAnimationController.forward();

    super.initState();
  }

  addRepeatListener(AnimationController controller) {
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.repeat();
      }
    });
    controller.forward();
  }

  AnimationController _createController(double durationInDays) {
    return AnimationController(
      vsync: this,
      duration: Duration(milliseconds: ((durationInDays / 365) * 1000).floor()),
      upperBound: 2 * pi,
    )..forward();
  }

  @override
  void dispose() {
    for (AnimationController c in _planetControllers) {
      c.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: InteractiveViewer(
        maxScale: 10,
        child: AnimatedBuilder(
          animation: _sunAnimationController,
          builder: (context, child) {
            for (int i = 0; i < _planets.length; i++) {
              _planets[i].angle = _planetControllers[i].value;
            }
            return CustomPaint(
              painter: SolarSystemFullPainter(_planets),
              child: Container(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Planet? planet = await showDialog(
            context: context,
            builder: (context) => AddPlanetForm(
              onSubmit: (String planetName, double radius, double orbitRadius,
                  Color color, double orbitDuration) {
                _addPlanet(Planet(
                  planetName: planetName,
                  distance: radius,
                  orbitRadius: orbitRadius,
                  color: color,
                  orbitDuration: orbitDuration,
                ));
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addPlanet(Planet planet) {
    setState(() {
      _planets.add(planet);
      AnimationController newController =
          _createController(planet.orbitDuration);
      _planetControllers.add(newController);
      addRepeatListener(newController);
      _planets[_planets.length - 1].angle = newController.value;
    });
  }
}

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
