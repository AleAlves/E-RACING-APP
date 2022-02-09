import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Widget? child;
  final bool ready;
  final Color? color;
  final Color? markColor;
  final double? placeholderWidth;
  final double? placeholderHeight;
  final VoidCallback? onPressed;

  const CardWidget(
      {required this.child,
      this.onPressed,
      required this.ready,
      this.color,
      this.markColor,
      this.placeholderHeight,
      this.placeholderWidth,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ready
        ? Card(
            color: color,
            child: Stack(
              children: [
                InkWell(
                  onTap: onPressed,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: child,
                  ),
                ),
                ClipRRect(
                  borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(8.0)),
                  child: Container(
                    color: markColor,
                    width: MediaQuery.of(context).size.width / 25,
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                ),
              ],
            ))
        : loading(context);
  }

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }
}
