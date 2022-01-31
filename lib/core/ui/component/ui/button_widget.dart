import 'package:e_racing_app/core/ui/component/state/loading_ripple.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ButtonType { normal, borderless, icon, important }

class ButtonWidget extends StatefulWidget {
  final String? label;
  final IconData? icon;
  final ButtonType type;
  final bool enabled;
  final VoidCallback? onPressed;

  const ButtonWidget(
      {required this.enabled,
      required this.type,
      required this.onPressed,
      this.label,
      this.icon,
      Key? key})
      : super(key: key);

  Widget loading(BuildContext context) {
    return const LoadingRipple();
  }

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case ButtonType.normal:
        return normal(context);
      case ButtonType.borderless:
        return borderless();
      case ButtonType.icon:
        return iconButton();
      case ButtonType.important:
        return important(context);
    }
  }

  Widget borderless() {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: widget.enabled ? widget.onPressed : null,
        child: Text(widget.label ?? ''),
      ),
    );
  }

  Widget normal(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary:
                widget.enabled ? ERcaingApp.color : ERcaingApp.color.shade50),
        onPressed: widget.enabled ? widget.onPressed : null,
        child: Text(widget.label ?? ''),
      ),
    );
  }

  Widget important(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: widget.enabled
                ? ERcaingApp.ascent
                : ERcaingApp.color.shade50),
        onPressed: widget.enabled ? widget.onPressed : null,
        child: Text(widget.label ?? ''),
      ),
    );
  }

  Widget iconButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: ShapeDecoration(
            color: widget.enabled ? ERcaingApp.color : ERcaingApp.color.shade50,
            shape: const CircleBorder(),
          ),
          child: Center(
            child: IconButton(
                icon: Icon(
                  widget.icon,
                  size: 24,
                ),
                color: Colors.black87,
                onPressed: widget.enabled ? widget.onPressed : null),
          ),
        ),
        const BoundWidget(BoundType.small),
        widget.label == null
            ? Container()
            : TextWidget(text: widget.label ?? '', style: Style.label)
      ],
    );
  }
}
