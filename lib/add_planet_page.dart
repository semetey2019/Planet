import 'package:flutter/material.dart';
import 'package:kun_systemasy/models.dart';

class AddPlanetScreen extends StatefulWidget {
  const AddPlanetScreen({Key? key}) : super(key: key);

  @override
  _AddPlanetScreenState createState() => _AddPlanetScreenState();
}

class _AddPlanetScreenState extends State<AddPlanetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _orbitRadiusController = TextEditingController();
  final _colorController = TextEditingController();
  final _distanceController = TextEditingController();
  final _planetNameController = TextEditingController();

  @override
  void dispose() {
    _orbitRadiusController.dispose();
    _colorController.dispose();
    _distanceController.dispose();
    _planetNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Planet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _orbitRadiusController,
                decoration: const InputDecoration(
                  labelText: 'Radius',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a radius';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _colorController,
                decoration: const InputDecoration(
                  labelText: 'Color',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a color';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _distanceController,
                decoration: const InputDecoration(
                  labelText: 'Distance',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a distance';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _planetNameController,
                decoration: const InputDecoration(
                  labelText: 'Rotation Speed',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a rotation speed';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Planet planet = Planet(
                      distance: double.parse(_orbitRadiusController.text),
                      color: Color(int.parse(_colorController.text)),
                      planetName: _planetNameController.text,
                      orbitRadius: double.parse(_distanceController.text),
                    );
                    Navigator.pop(context, planet);
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
