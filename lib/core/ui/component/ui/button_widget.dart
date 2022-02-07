import 'package:e_racing_app/core/ui/component/state/loading_ripple.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ButtonType { normal, borderless, icon, iconBorderless, important }

class ButtonWidget extends StatefulWidget {
  final String? label;
  final IconData? icon;
  final ButtonType type;
  final bool enabled;
  final Color? buttonColor;
  final Color? labelColor;
  final VoidCallback? onPressed;

  const ButtonWidget(
      {required this.enabled,
      required this.type,
      required this.onPressed,
      this.label,
      this.buttonColor,
      this.labelColor,
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
      case ButtonType.iconBorderless:
        return iconButtonBorderless();
    }
  }

  Widget borderless() {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: widget.enabled ? widget.onPressed : null,
        child: TextWidget(
          text: widget.label ?? '',
          color: widget.labelColor,
          style: Style.shadow,
        ),
      ),
    );
  }

  Widget normal(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary:
                widget.enabled ? widget.buttonColor : ERcaingApp.color.shade50),
        onPressed: widget.enabled ? widget.onPressed : null,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextWidget(
            text: widget.label ?? '',
            color: widget.labelColor,
            style: Style.subtitle,
          ),
        ),
      ),
    );
  }

  Widget important(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: widget.enabled
                ? Theme.of(context).colorScheme.secondary
                : ERcaingApp.color.shade50),
        onPressed: widget.enabled ? widget.onPressed : null,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextWidget(
            text: widget.label ?? '',
            color: Theme.of(context).colorScheme.onSecondary,
            style: Style.subtitle,
          ),
        ),
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
            color: widget.buttonColor ?? ERcaingApp.color.shade500,
            shape: const CircleBorder(),
          ),
          child: Center(
            child: IconButton(
                icon: Icon(
                  widget.icon,
                  size: 24,
                ),
                color: ERcaingApp.base,
                onPressed: widget.enabled ? widget.onPressed : null),
          ),
        ),
        const SpacingWidget(LayoutSize.size8),
        widget.label == null
            ? Container()
            : TextWidget(text: widget.label ?? '', style: Style.label)
      ],
    );
  }

  Widget iconButtonBorderless() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: const ShapeDecoration(
            color: Colors.transparent,
            shape: CircleBorder(),
          ),
          child: Center(
            child: IconButton(
                icon: Icon(
                  widget.icon,
                  size: 24,
                ),
                onPressed: widget.enabled ? widget.onPressed : null),
          ),
        ),
        const SpacingWidget(LayoutSize.size8),
        widget.label == null
            ? Container()
            : TextWidget(text: widget.label ?? '', style: Style.label)
      ],
    );
  }
}
