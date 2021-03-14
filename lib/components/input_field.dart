import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType keyboardType;

  const InputField({
    Key key,
    @required this.controller,
    @required this.label,
    @required this.hint,
    this.icon,
    this.keyboardType = TextInputType.text,
  })  : assert(controller != null),
        assert(label != null),
        assert(hint != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon) : null,
          labelText: label,
          hintText: hint,
        ),
        style: TextStyle(
          fontSize: 24.0,
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}
