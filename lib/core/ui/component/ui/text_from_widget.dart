import 'package:e_racing_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum BorderType { normal, none }

enum InputType { text, number, multilines, password }

class InputTextWidget extends StatelessWidget {
  final String label;
  final IconData? icon;
  final BorderType borderType;
  final InputType inputType;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final Function(String)? onChange;

  const InputTextWidget(
      {this.borderType = BorderType.normal,
      this.inputType = InputType.text,
      this.icon,
      this.onChange,
      required this.label,
      required this.controller,
      required this.validator,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    InputDecoration? border;

    switch (borderType) {
      case BorderType.normal:
        border = InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: ERcaingApp.color.shade900,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: ERcaingApp.color.shade900,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: ERcaingApp.color.shade900,
              width: 1.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: ERcaingApp.color.shade900,
              width: 1.0,
            ),
          ),
        );
        break;
      case BorderType.none:
        border = null;
        break;
    }

    switch (inputType) {
      case InputType.text:
        return Align(
          alignment: Alignment.center,
          child: TextFormField(
            controller: controller,
            validator: validator,
            onChanged: onChange,
            decoration: border,
          ),
        );
      case InputType.number:
        return Align(
          alignment: Alignment.center,
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: controller,
            validator: validator,
            onChanged: onChange,
            decoration: border,
          ),
        );
      case InputType.password:
        return Align(
          alignment: Alignment.center,
          child: TextFormField(
            controller: controller,
            validator: validator,
            onChanged: onChange,
            obscureText: true,
            decoration: border,
          ),
        );
      case InputType.multilines:
        return Align(
          alignment: Alignment.center,
          child: TextFormField(
            controller: controller,
            validator: validator,
            onChanged: onChange,
            minLines: 5,
            maxLines: 10,
            decoration: border,
          ),
        );
    }
  }
}
