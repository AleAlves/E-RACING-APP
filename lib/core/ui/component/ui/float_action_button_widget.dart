import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

import '../state/loading_shimmer.dart';

class FloatActionButtonWidget extends StatefulWidget {
  final IconData icon;
  final String title;
  final Function onPressed;

  const FloatActionButtonWidget(
      {required this.icon,
      required this.title,
      required this.onPressed,
      super.key});

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }

  @override
  FloatActionButtonWidgetState createState() =>
      FloatActionButtonWidgetState();
}

class FloatActionButtonWidgetState extends State<FloatActionButtonWidget> {
  final bool _showWidget = true;

  @override
  Widget build(BuildContext context) {
    return normal(context);
  }

  Widget normal(BuildContext context) {
    return Align(
        alignment: Alignment.bottomRight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: _showWidget,
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: TextWidget(
                  text: widget.title,
                  style: Style.caption,
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                widget.onPressed.call();
              },
              child: Icon(
                widget.icon,
                color: Colors.white,
              ),
            ),
          ],
        ));
  }
}
