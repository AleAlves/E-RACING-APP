import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';

class TextFormWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller;
  final bool obscure;

  const TextFormWidget(this.label, this.icon, this.controller, this.validator,
      {this.obscure = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscure,
        decoration: InputDecoration(
          filled: true,
          fillColor: ERcaingApp.color[10],
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: Icon(icon),
        ),
      ),
    );
  }
}
