import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Widget? child;
  final bool ready;
  final Color? color;
  final Color? markColor;
  final bool shapeLess;
  final bool marked;
  final double markWidth;
  final EdgeInsetsGeometry padding;
  final double? placeholderWidth;
  final double? placeholderHeight;
  final VoidCallback? onPressed;

  const CardWidget(
      {required this.child,
      this.onPressed,
      required this.ready,
      this.color,
      this.markWidth = 10.0,
      this.markColor,
      this.padding = const EdgeInsets.all(8.0),
      this.shapeLess = false,
      this.marked = false,
      this.placeholderHeight = 100,
      this.placeholderWidth,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ready
        ? Stack(
            children: [
              Card(
                  shape: shapeLess
                      ? null
                      : RoundedRectangleBorder(
                          side: BorderSide(width: 0.1, color: Theme.of(context).hoverColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                  color: color,
                  shadowColor: shapeLess ? Colors.transparent : null,
                  child: Stack(
                    children: [
                      if(marked) Positioned(
                        child: Container(
                          width: markWidth,
                          decoration: BoxDecoration(
                            color: markColor ?? Theme.of(context).colorScheme.primary,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                bottomLeft: Radius.circular(5.0)),
                          ),
                        ),
                        top: 0.0,
                        left: 0.0,
                        bottom: 0.0,
                      ) else Container(),
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
    return Card(
        child: LoadingShimmer(
      height: placeholderHeight,
    ));
  }
}
