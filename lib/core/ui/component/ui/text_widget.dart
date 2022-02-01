import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Style { description, title, subtitle, label, note }

class TextWidget extends StatelessWidget {
  final String text;
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
      text,
      textAlign: align,
      style: _getStyle(),
    );
  }

  TextStyle _getStyle() {
    switch (style) {
      case Style.title:
        return TextStyle(
          fontFamily: 'Roboto',
          overflow: TextOverflow.fade,
          fontWeight: FontWeight.w200,
          color: color,
          fontSize: 32.0,
        );
      case Style.subtitle:
        return TextStyle(
          fontFamily: 'Roboto',
          overflow: TextOverflow.fade,
          fontWeight: FontWeight.w200,
          fontSize: 24.0,
          color: color,
        );
      case Style.description:
        return TextStyle(
          fontFamily: 'Roboto',
          overflow: TextOverflow.fade,
          fontWeight: FontWeight.w300,
          fontSize: 18.0,
          color: color,
        );
      case Style.label:
        return TextStyle(
          fontFamily: 'Roboto',
          overflow: TextOverflow.fade,
          fontWeight: FontWeight.w100,
          fontSize: 12.0,
          color: color,
        );
      case Style.note:
        return TextStyle(
          fontFamily: 'Roboto',
          overflow: TextOverflow.fade,
          fontWeight: FontWeight.w300,
          fontSize: 10.0,
          color: color,
        );
    }
  }
}
