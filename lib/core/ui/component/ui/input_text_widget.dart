import 'package:flutter/material.dart';

enum BorderType { normal, none }

enum InputType { text, capital, number, multilines, password }

class InputTextWidget extends StatelessWidget {
  final String label;
  final IconData? icon;
  final BorderType borderType;
  final InputType inputType;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final bool enabled;

  const InputTextWidget(
      {this.borderType = BorderType.normal,
      this.inputType = InputType.text,
      this.enabled = false,
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
          filled: true,
          fillColor: Theme.of(context).focusColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
              width: 1.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
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
            enabled: enabled,
            controller: controller,
            validator: validator,
            onChanged: onChange,
            decoration: border,
          ),
        );
      case InputType.capital:
        return Align(
          alignment: Alignment.center,
          child: TextFormField(
            enabled: enabled,
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
            enabled: enabled,
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
            enabled: enabled,
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
            enabled: enabled,
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
