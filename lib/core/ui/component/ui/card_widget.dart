import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:flutter/material.dart';

import 'icon_widget.dart';

class CardWidget extends StatelessWidget {
  final Widget? child;
  final Widget? childLeft;
  final Widget? childRight;
  final bool ready;
  final bool arrowed;
  final bool highlight;
  final Color? color;
  final Color? childLeftColor;
  final bool shapeLess;
  final EdgeInsetsGeometry padding;
  final double? placeholderWidth;
  final double? placeholderHeight;
  final VoidCallback? onPressed;

  const CardWidget(
      {required this.child,
      this.childLeft,
      this.childRight,
      this.onPressed,
      required this.ready,
      this.color,
      this.childLeftColor,
      this.padding = const EdgeInsets.all(8),
      this.highlight = false,
      this.shapeLess = false,
      this.arrowed = false,
      this.placeholderHeight = 100,
      this.placeholderWidth,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ready
        ? Center(
            child: Card(
              shape: shapeLess
                  ? null
                  : RoundedRectangleBorder(
                      side: BorderSide(
                          width: 0.2, color: Theme.of(context).focusColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
              color: color,
              shadowColor: shapeLess ? Colors.transparent : null,
              child: IntrinsicHeight(
                child: InkWell(
                  onTap: onPressed,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      childLeft == null
                          ? Container()
                          : Container(
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                color: childLeftColor ??
                                    Theme.of(context).focusColor,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    bottomLeft: Radius.circular(5.0)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          10,
                                      child: childLeft)
                                ],
                              ),
                            ),
                      Expanded(child: Padding(padding: padding, child: child)),
                      childRight == null
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: childRight,
                            ),
                      arrowed
                          ? const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: IconWidget(
                                icon: Icons.chevron_right,
                                borderless: true,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
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
