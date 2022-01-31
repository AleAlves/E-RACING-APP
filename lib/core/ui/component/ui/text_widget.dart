import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';

enum Style { description, title, subtitle, label, note }

class TextWidget extends StatelessWidget {
  final String text;
  final Style style;
  final TextAlign align;

  const TextWidget(
      {required this.text,
      required this.style,
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
        return const TextStyle(
          fontFamily: 'Roboto',
          overflow: TextOverflow.fade,
          fontWeight: FontWeight.w300,
          fontSize: 32.0,
        );
      case Style.subtitle:
        return const TextStyle(
          fontFamily: 'Roboto',
          overflow: TextOverflow.fade,
          fontWeight: FontWeight.w300,
          fontSize: 24.0,
        );
      case Style.description:
        return const TextStyle(
          fontFamily: 'Roboto',
          overflow: TextOverflow.fade,
          fontWeight: FontWeight.w300,
          fontSize: 18.0,
        );
      case Style.label:
        return const TextStyle(
          fontFamily: 'Roboto',
          overflow: TextOverflow.fade,
          fontWeight: FontWeight.w300,
          fontSize: 12.0,
        );
      case Style.note:
        return const TextStyle(
          fontFamily: 'Roboto',
          overflow: TextOverflow.fade,
          fontWeight: FontWeight.w300,
          fontSize: 10.0,
        );
    }
  }
}
