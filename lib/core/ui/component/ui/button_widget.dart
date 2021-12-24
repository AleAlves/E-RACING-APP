import 'package:e_racing_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ButtonType { normal, borderless, icon }

class ButtonWidget extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final ButtonType type;
  final VoidCallback? onPressed;

  const ButtonWidget(this.type, this.onPressed,
      {this.label, this.icon, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ButtonType.normal:
        return normal(context);
      case ButtonType.borderless:
        return borderless(onPressed);
      case ButtonType.icon:
        return iconButton(onPressed);
    }
  }

  Widget borderless(onPressed) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: onPressed,
        child: Text(label ?? ''),
      ),
    );
  }

  Widget normal(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label ?? ''),
      ),
    );
  }

  Widget iconButton(onPressed) {
    return Container(
      decoration: const ShapeDecoration(
        color: ERcaingApp.color,
        shape: CircleBorder(),
      ),
      child: IconButton(
          icon: Icon(icon),
          color: ERcaingApp.color[10],
          tooltip: label,
          onPressed: onPressed),
    );
  }
}
