import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CardHolderWidget extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onPressed;

  const CardHolderWidget(
      {required this.child, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: child,
        )
      ),
    );
  }
}
