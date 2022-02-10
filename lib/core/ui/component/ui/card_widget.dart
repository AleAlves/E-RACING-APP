import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Widget? child;
  final bool ready;
  final Color? color;
  final Color? markColor;
  final EdgeInsetsGeometry padding;
  final double? placeholderWidth;
  final double? placeholderHeight;
  final VoidCallback? onPressed;

  const CardWidget(
      {required this.child,
      this.onPressed,
      required this.ready,
      this.color,
      this.padding = const EdgeInsets.all(16.0),
      this.markColor,
      this.placeholderHeight,
      this.placeholderWidth,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ready
        ? Stack(
            children: [
              Card(
                  color: color,
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: onPressed,
                        child: Padding(
                          padding: padding,
                          child: child,
                        ),
                      ),
                    ],
                  )),
            ],
          )
        : loading(context);
  }

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }
}
