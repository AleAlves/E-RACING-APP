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

  TextStyle? _getStyle(BuildContext context) {
    switch (style) {
      case Style.title:
        return Theme.of(context).textTheme.headline4?.copyWith(color: color);
      case Style.subtitle:
        return Theme.of(context).textTheme.headline5?.copyWith(color: color);
      case Style.paragraph:
        return Theme.of(context).textTheme.bodyLarge?.copyWith(color: color);
      case Style.caption:
        return Theme.of(context)
            .textTheme
            .caption
            ?.copyWith(color: color, fontSize: 14);
      case Style.error:
        return Theme.of(context)
            .textTheme
            .caption
            ?.copyWith(color: Colors.red, fontSize: 14);
      case Style.button:
        return Theme.of(context)
            .textTheme
            .button
            ?.copyWith(color: color, fontSize: 14);
    }
  }
}
