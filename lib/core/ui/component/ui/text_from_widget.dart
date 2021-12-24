import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum BorderType { normal, none }

class TextFormWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final BorderType borderType;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller;
  final bool obscure;

  const TextFormWidget(this.label, this.icon, this.controller, this.validator,
      {this.borderType = BorderType.normal, this.obscure = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    InputDecoration? border;
    
    switch(borderType){
      case BorderType.normal:
        border = InputDecoration(
          labelText: label,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              width: 0.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              width: 0.5,
            ),
          ),
        );
        break;
      case BorderType.none:
        border = null;
        break;
    }
    
    return Align(
      alignment: Alignment.center,
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscure,
        decoration: border,
      ),
    );
  }
}
