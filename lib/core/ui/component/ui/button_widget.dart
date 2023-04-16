import 'package:e_racing_app/core/ui/component/state/loading_ripple.dart';
import 'package:e_racing_app/core/ui/component/ui/icon_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum ButtonType {
  primary,
  secondary,
  important,
  link,
  iconButton,
  iconBorderless
}

class ButtonWidget extends StatefulWidget {
  final String? label;
  final IconData? icon;
  final ButtonType type;
  final bool enabled;
  final Color? color;
  final Color? iconColor;
  final Color? labelColor;
  final double? iconRadius;
  final VoidCallback? onPressed;

  const ButtonWidget(
      {required this.enabled,
      required this.type,
      required this.onPressed,
      this.label,
      this.color,
      this.iconColor,
      this.labelColor,
      this.iconRadius = 24,
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
      case ButtonType.primary:
        return primary(context);
      case ButtonType.link:
        return link();
      case ButtonType.iconButton:
        return iconButton();
      case ButtonType.important:
        return important(context);
      case ButtonType.iconBorderless:
        return iconButtonBorderless();
      case ButtonType.secondary:
        return secondary(context);
    }
  }

  Widget link() {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: widget.enabled ? widget.onPressed : null,
        child: Row(
          children: [
            TextWidget(
              text: widget.label ?? '',
              color: widget.labelColor ?? Theme.of(context).colorScheme.primary,
              style: Style.caption,
            ),
            IconWidget(
              icon: widget.icon ?? Icons.arrow_forward_sharp,
              size: 14,
            )
          ],
        ),
      ),
    );
  }

  Widget primary(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
            side: const BorderSide(
              width: 0.1,
            ),
          ),
        ),
      ),
      onPressed: widget.enabled ? widget.onPressed : null,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: TextWidget(
          text: widget.label ?? '',
          color: widget.labelColor ?? Theme.of(context).colorScheme.onPrimary,
          style: Style.button,
        ),
      ),
    );
  }

  Widget important(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.secondaryContainer),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: const BorderSide(
                width: 0.1,
              ),
            ),
          ),
        ),
        onPressed: widget.enabled ? widget.onPressed : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: TextWidget(
                text: widget.label ?? '',
                style: Style.button,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
            widget.icon == null
                ? Container()
                : Row(
                    children: [
                      const SpacingWidget(LayoutSize.size16),
                      IconWidget(
                          icon: widget.icon,
                          size: 18,
                          color: widget.iconColor ??
                              Theme.of(context).colorScheme.onSecondary),
                    ],
                  )
          ],
        ),
      ),
    );
  }

  Widget secondary(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: const BorderSide(
                width: 0.1,
              ),
            ),
          ),
        ),
        onPressed: widget.enabled ? widget.onPressed : null,
        child: TextWidget(
          text: widget.label ?? '',
          style: Style.button,
        ),
      ),
    );
  }

  Widget iconButton() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: widget.iconRadius,
              child: Container(),
            ),
            IconButton(
              icon: FaIcon(widget.icon,
                  color: widget.iconColor ??
                      Theme.of(context).colorScheme.onPrimary),
              iconSize: widget.iconRadius,
              onPressed: widget.enabled ? widget.onPressed : null,
            ),
          ],
        ),
        const SpacingWidget(LayoutSize.size8),
        widget.label == null
            ? Container()
            : TextWidget(text: widget.label ?? '', style: Style.caption)
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
          child: IconButton(
              alignment: Alignment.center,
              icon: Icon(
                widget.icon,
                size: widget.iconRadius,
                color: widget.iconColor,
              ),
              onPressed: widget.enabled ? widget.onPressed : null),
        ),
        const SpacingWidget(LayoutSize.size8),
        widget.label == null
            ? Container()
            : TextWidget(text: widget.label ?? '', style: Style.caption)
      ],
    );
  }
}
