import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ButtonType { normal, borderless}

class ButtonWidget extends StatelessWidget {
  final String label;
  final ButtonType type;
  final VoidCallback? onPressed;

  const ButtonWidget(this.label, this.type, this.onPressed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch(type){
      case ButtonType.normal:
        return normal(context);
      case ButtonType.borderless:
        return borderless(onPressed);
    }
  }

  Widget borderless(onPressed) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }

  Widget normal(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
