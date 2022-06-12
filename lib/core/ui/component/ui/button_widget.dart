import 'package:e_racing_app/core/ui/component/state/loading_ripple.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum ButtonType { primary,  secondary, important,link, iconButton, iconPure }

class ButtonWidget extends StatefulWidget {
  final String? label;
  final IconData? icon;
  final ButtonType type;
  final bool enabled;
  final Color? color;
  final Color? iconColor;
  final Color? labelColor;
  final VoidCallback? onPressed;

  const ButtonWidget(
      {required this.enabled,
      required this.type,
      required this.onPressed,
      this.label,
      this.color,
      this.iconColor,
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
      case ButtonType.primary:
        return normal(context);
      case ButtonType.link:
        return borderless();
      case ButtonType.iconButton:
        return iconButton();
      case ButtonType.important:
        return important(context);
      case ButtonType.iconPure:
        return iconButtonBorderless();
      case ButtonType.secondary:
        return discret(context);
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
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: const BorderSide(
                width: 0.5,
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
                color: widget.labelColor,
                style: Style.button,
              ),
            ),
            widget.icon == null ? Container() : Row(
              children: [
                const SpacingWidget(LayoutSize.size16),
                Icon(widget.icon, color: widget.iconColor,),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget important(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xff2a7522)),
          foregroundColor: MaterialStateProperty.all(const Color(0xff246b1c)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: const BorderSide(
                width: 0.5,
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
            widget.icon == null ? Container() : Row(
              children: [
                const SpacingWidget(LayoutSize.size16),
                Icon(widget.icon, color: widget.iconColor ?? Theme.of(context).colorScheme.onSecondary),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget discret(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.background),
          foregroundColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.onBackground),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: const BorderSide(
                width: 0.5,
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
              ),
            ),
            widget.icon == null ? Container() : Row(
              children: [
                const SpacingWidget(LayoutSize.size16),
                Icon(widget.icon, color: widget.iconColor,),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget iconButton() {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: widget.color,
          child: SizedBox(
            width: double.infinity,
            child: IconButton(
              icon: FaIcon(widget.icon, color: widget.iconColor,),
              iconSize: 24,
              onPressed: widget.enabled ? widget.onPressed : null,
            ),
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
                  color: widget.iconColor,
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
