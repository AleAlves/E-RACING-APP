import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Style { description, title, subtitle, button, label, note, shadow }

class TextWidget extends StatelessWidget {
  final String? text;
  final Style style;
  final TextAlign align;
  final Color? color;

  const TextWidget(
      {required this.text,
      required this.style,
      this.color,
      this.align = TextAlign.center,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      softWrap: true,
      overflow: TextOverflow.fade,
      textAlign: align,
      style: _getStyle(context),
    );
  }

  TextStyle _getStyle(BuildContext context) {
    switch (style) {
      case Style.title:
        return TextStyle(
          fontFamily: 'Roboto',
          color: color,
          fontSize: 28.0,
        );
      case Style.subtitle:
        return TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          fontSize: 20.0,
          color: color
        );
      case Style.description:
        return TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
          color: color,
        );
      case Style.label:
        return const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          fontSize: 12.0,
        );
      case Style.note:
        return TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          fontSize: 10.0,
          color: color,
        );
      case Style.shadow:
        return TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.underline,
            fontSize: 18.0,
            color: color,
            shadows: [
              Shadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 1),
                  blurRadius: 0)
            ]);
        break;
      case Style.button:
        return TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
          color: color,
          fontSize: 18.0,
        );
    }
  }
}
