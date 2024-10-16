import 'package:flutter/material.dart';

enum Style { title, subtitle, paragraph, caption, button, error }

class TextWidget extends StatelessWidget {
  final String? text;
  final Style style;
  final TextAlign align;
  final Color? color;
  final FontWeight? weight;

  const TextWidget(
      {required this.text,
      required this.style,
      this.color,
      this.weight,
      this.align = TextAlign.center,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      softWrap: true,
      overflow: TextOverflow.clip,
      textAlign: align,
      style: _getStyle(context),
    );
  }

  TextStyle? _getStyle(BuildContext context) {
    switch (style) {
      case Style.title:
        return Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: color, fontWeight: weight, letterSpacing: 1.0);
      case Style.subtitle:
        return Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: color, fontWeight: weight, letterSpacing: 2.0);
      case Style.paragraph:
        return Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: color, fontWeight: weight, letterSpacing: 1.5);
      case Style.caption:
        return Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color:  color, fontSize: 14, fontWeight: weight, letterSpacing: 2.0);
      case Style.error:
        return Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: Colors.red, fontSize: 14, fontWeight: weight, letterSpacing: 2.0);
      case Style.button:
        return Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: color, fontSize: 16, fontWeight: FontWeight.normal, letterSpacing: 4.0);
    }
  }
}
