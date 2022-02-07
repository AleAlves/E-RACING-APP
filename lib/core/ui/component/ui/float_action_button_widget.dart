import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';

class FloatActionButtonWidget<T> extends StatelessWidget {
  final T flow;
  final IconData icon;
  final Function(T)? onPressed;

  const FloatActionButtonWidget(
      {required this.icon, required this.flow, this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return normal(context);
  }

  Widget normal(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 120,
        child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                onPressed?.call(flow);
              },
              child: Icon(
                icon,
                color: Colors.white,
              ),
            )),
      ),
    );
  }
}
