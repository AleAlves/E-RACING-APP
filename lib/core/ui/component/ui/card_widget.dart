import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Widget? child;
  final bool ready;
  final double? placeholderWidth;
  final double? placeholderHeight;
  final VoidCallback? onPressed;

  const CardWidget(
      {required this.child,
        required this.onPressed,
        required this.ready,
        this.placeholderHeight,
        this.placeholderWidth,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: ready
          ? Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: child,
          ))
          : loading(context),
    );
  }

  Widget loading(BuildContext context) {
    return const Card(
        child: LoadingShimmer());
  }
}