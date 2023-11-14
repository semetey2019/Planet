import 'package:flutter/material.dart';

class AddPlanetForm extends StatefulWidget {
  const AddPlanetForm({Key? key, required this.onSubmit}) : super(key: key);

  final void Function(String planetName, double radius, double orbitRadius,
      Color color, double orbitDuration) onSubmit;

  @override
  _AddPlanetFormState createState() => _AddPlanetFormState();
}

class _AddPlanetFormState extends State<AddPlanetForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _planetNameController;
  late TextEditingController _radiusController;
  late TextEditingController _orbitRadiusController;
  late TextEditingController _orbitDurationController;
  Color _selectedColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _planetNameController = TextEditingController();
    _radiusController = TextEditingController();
    _orbitRadiusController = TextEditingController();
    _orbitDurationController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a New Planet'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _planetNameController,
                decoration: const InputDecoration(labelText: 'Planet Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a planet name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _radiusController,
                decoration: const InputDecoration(labelText: 'Radius'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a radius';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _orbitRadiusController,
                decoration: const InputDecoration(labelText: 'Orbit Radius'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an orbit radius';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _orbitDurationController,
                decoration: const InputDecoration(labelText: 'Orbit Duration'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an orbit duration';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              const Text('Select Color:'),
              const SizedBox(height: 5),
              ColorPicker(
                onSelectColor: (color) {
                  setState(() {
                    _selectedColor = color;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onSubmit(
                _planetNameController.text,
                double.parse(_radiusController.text),
                double.parse(_orbitRadiusController.text),
                _selectedColor,
                double.parse(_orbitDurationController.text),
              );
              Navigator.pop(context);
            }
          },
          child: const Text('Add Planet'),
        ),
      ],
    );
  }
}

class ColorPicker extends StatelessWidget {
  final void Function(Color color) onSelectColor;

  const ColorPicker({Key? key, required this.onSelectColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        _ColorOption(color: Colors.grey, onSelectColor: onSelectColor),
        _ColorOption(color: Colors.orangeAccent, onSelectColor: onSelectColor),
        _ColorOption(color: Colors.blue, onSelectColor: onSelectColor),
        _ColorOption(color: Colors.red, onSelectColor: onSelectColor),
        _ColorOption(color: Colors.brown, onSelectColor: onSelectColor),
        _ColorOption(color: Colors.yellow, onSelectColor: onSelectColor),
        _ColorOption(color: Colors.lightBlue, onSelectColor: onSelectColor),
        _ColorOption(color: Colors.blue.shade900, onSelectColor: onSelectColor),
      ],
    );
  }
}

class _ColorOption extends StatelessWidget {
  final Color color;
  final void Function(Color color) onSelectColor;

  const _ColorOption(
      {Key? key, required this.color, required this.onSelectColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelectColor(color);
      },
      child: Container(
        width: 30,
        height: 30,
        color: color,
        margin: const EdgeInsets.all(5),
      ),
    );
  }
}
