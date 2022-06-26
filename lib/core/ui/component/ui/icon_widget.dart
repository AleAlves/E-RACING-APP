import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

class IconWidget extends StatefulWidget {
  final IconData? icon;
  final double? size;
  final Color? color;

  const IconWidget(
      {required this.icon, this.size, this.color, Key? key})
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
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            widget.icon,
            size: (widget.size ?? 24) + 2,
            color:  const Color(0xFF797979),
          ),
          Icon(
            widget.icon,
            size: widget.size,
            color: widget.color,
          ),
        ],
      ),
    );
  }
}
