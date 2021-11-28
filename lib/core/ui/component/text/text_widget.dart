import 'package:flutter/cupertino.dart';

enum Style {
  description,
  title,
  subtitle,
  label,
}

class TextWidget extends StatelessWidget {

  final String text;
  final Style style;
  final TextAlign align;

  const TextWidget(this.text, this.style, {this.align = TextAlign.center, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: align,
        style: _getStyle(),
      ),
    );
  }

  TextStyle _getStyle(){
    switch(style){
      case Style.title:
        return const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w300,
          fontSize: 48.0,
        );
      case Style.subtitle:
        return const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w300,
          fontSize: 28.0,
        );
      case Style.description:
        return const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w300,
          fontSize: 18.0,
        );
      case Style.label:
        return const TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w300,
          fontSize: 14.0,
        );
    }
  }
}