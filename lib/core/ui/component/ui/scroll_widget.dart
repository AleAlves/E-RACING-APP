import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScrollWidget extends StatelessWidget {
  final Widget content;

  const ScrollWidget(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: content,
    );
  }
}
