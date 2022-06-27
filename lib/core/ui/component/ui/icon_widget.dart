import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

class IconWidget extends StatefulWidget {
  final IconData? icon;
  final IconData? background;
  final Color? backgroundColor;
  final double? size;
  final Color? color;
  final bool borderless;

  const IconWidget(
      {required this.icon,
      this.background,
      this.backgroundColor,
      this.size,
      this.color,
      this.borderless = true,
      Key? key})
      : super(key: key);

  @override
  _IconWidgetState createState() => _IconWidgetState();
}

class _IconWidgetState extends State<IconWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => content();

  Widget content() {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (widget.borderless)
          Container()
        else
          Icon(widget.background ?? Icons.circle,
              size: (widget.size ?? 24) + ((widget.size ?? 24) / 100 + 5),
              color: widget.backgroundColor ?? Theme.of(context).focusColor),
        Icon(
          widget.icon,
          size: widget.size,
          color: widget.color,
        ),
      ],
    );
  }
}
