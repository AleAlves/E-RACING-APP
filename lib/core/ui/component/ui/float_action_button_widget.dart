import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

class FloatActionButtonWidget<T> extends StatelessWidget {
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
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextWidget(
                    text: title,
                    style: Style.caption,
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    onPressed?.call(flow);
                  },
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
