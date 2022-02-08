import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Style { description, title, subtitle, label, note, shadow }

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
      textAlign: align,
      style: _getStyle(context),
    );
  }

  TextStyle _getStyle(BuildContext context) {
    switch (style) {
      case Style.title:
        return TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          color: color,
          fontSize: 24.0,
        );
      case Style.subtitle:
        return TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          fontSize: 18.0,
          color: color,
        );
      case Style.description:
        return TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
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
            fontSize: 18.0,
            color: color,
            shadows: [
              Shadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 1),
                  blurRadius: 0)
            ]);
        break;
    }
  }
}
