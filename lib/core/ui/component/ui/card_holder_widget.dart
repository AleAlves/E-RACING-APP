import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CardHolderWidget extends StatelessWidget {
  final Widget? widget;
  final VoidCallback? onPressed;

  const CardHolderWidget(
      {required this.widget, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget,
        )
      ),
    );
  }
}
