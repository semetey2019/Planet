// import 'package:flutter/material.dart';

// class AddPlanetForm extends StatefulWidget {
//   const AddPlanetForm({Key? key, required this.onSubmit}) : super(key: key);

//   final void Function(String planetName, double radius, double orbitRadius,
//       Color color, double orbitDuration) onSubmit;

//   @override
//   _AddPlanetFormState createState() => _AddPlanetFormState();
// }

// class _AddPlanetFormState extends State<AddPlanetForm> {
//   final _formKey = GlobalKey<FormState>();
//   late TextEditingController _planetNameController;
//   late TextEditingController _radiusController;
//   late TextEditingController _orbitRadiusController;
//   late TextEditingController _orbitDurationController;
//   Color _selectedColor = Colors.grey;

//   @override
//   void initState() {
//     super.initState();
//     _planetNameController = TextEditingController();
//     _radiusController = TextEditingController();
//     _orbitRadiusController = TextEditingController();
//     _orbitDurationController = TextEditingController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Add a New Planet'),
//       content: SingleChildScrollView(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _planetNameController,
//                 decoration: InputDecoration(labelText: 'Planet Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a planet name';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _radiusController,
//                 decoration: InputDecoration(labelText: 'Radius'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a radius';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _orbitRadiusController,
//                 decoration: InputDecoration(labelText: 'Orbit Radius'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter an orbit radius';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _orbitDurationController,
//                 decoration: InputDecoration(labelText: 'Orbit Duration'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter an orbit duration';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 10),
//               Text('Select Color:'),
//               SizedBox(height: 5),
//               ColorPicker(
//                 onSelectColor: (color) {
//                   setState(() {
//                     _selectedColor = color;
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             if (_formKey.currentState!.validate()) {
//               widget.onSubmit(
//                 _planetNameController.text,
//                 double.parse(_radiusController.text),
//                 double.parse(_orbitRadiusController.text),
//                 _selectedColor,
//                 double.parse(_orbitDurationController.text),
//               );
//               Navigator.pop(context);
//             }
//           },
//           child: Text('Add Planet'),
//         ),
//       ],
//     );
//   }
// }

// class ColorPicker extends StatelessWidget {
//   final void Function(Color color) onSelectColor;

// const ColorPicker({Key? key, required this.onSelectColor}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       children: [
//         _ColorOption(color: Colors.grey, onSelectColor: onSelectColor),
//         _ColorOption(color: Colors.orangeAccent, onSelectColor: onSelectColor),
//         _ColorOption(color: Colors.blue, onSelectColor: onSelectColor),
//         _ColorOption(color: Colors.red, onSelectColor: onSelectColor),
//         _ColorOption(color: Colors.brown, onSelectColor: onSelectColor),
//         _ColorOption(color: Colors.yellow, onSelectColor: onSelectColor),
//         _ColorOption(color: Colors.lightBlue, onSelectColor: onSelectColor),
//         _ColorOption(color: Colors.blue.shade900, onSelectColor: onSelectColor),
//       ],
//     );
//   }
// }

// class _ColorOption extends StatelessWidget {
//   final Color color;
//   final void Function(Color color) onSelectColor;

//   const _ColorOption(
//       {Key? key, required this.color, required this.onSelectColor})
//       : super(key: key);

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
      duration: const Duration(milliseconds: 200),
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
