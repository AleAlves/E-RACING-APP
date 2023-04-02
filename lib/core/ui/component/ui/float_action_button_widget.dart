import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

import '../state/loading_shimmer.dart';

class FloatActionButtonWidget<T> extends StatefulWidget {
  final T flow;
  final IconData icon;
  final String title;
  final Function(T)? onPressed;

  const FloatActionButtonWidget(
      {required this.icon,
      required this.title,
      required this.flow,
      this.onPressed,
      Key? key})
      : super(key: key);

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }

  @override
  _FloatActionButtonWidgetState createState() =>
      _FloatActionButtonWidgetState();
}

class _FloatActionButtonWidgetState extends State<FloatActionButtonWidget> {
  bool _showWidget = true;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      setState(() {
        _showWidget = false;
      });
    });
    return normal(context);
  }

  Widget normal(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 120,
        child: Align(
            alignment: Alignment.bottomRight,
            child: Wrap(
              children: [
                Visibility(
                  visible: _showWidget,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextWidget(
                      text: widget.title,
                      style: Style.caption,
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    widget.onPressed?.call(widget.flow);
                  },
                  child: Icon(
                    widget.icon,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
