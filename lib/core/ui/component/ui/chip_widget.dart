import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

class ChipWidget extends StatefulWidget {
  final String? text;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;
  final Color? color;
  final Color? textColor;

  const ChipWidget(
      {required this.text,
      this.padding,
      this.color,
      this.textColor,
      this.onPressed,
      Key? key})
      : super(key: key);

  @override
  _ChipWidgetState createState() => _ChipWidgetState();
}

class _ChipWidgetState extends State<ChipWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => content();

  Widget content() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(14.0)),
      child: Container(
        child: Padding(
          padding: widget.padding ??
              const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextWidget(
                  text: widget.text ?? '',
                  style: Style.caption,
                  color: widget.textColor ??
                      Theme.of(context).colorScheme.onBackground),
            ],
          ),
        ),
        color: widget.color ?? Theme.of(context).focusColor,
      ),
    );
  }
}
