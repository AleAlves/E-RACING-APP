import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ButtonType { normal, borderless, icon, important }

class ButtonWidget extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final ButtonType type;
  final VoidCallback? onPressed;

  const ButtonWidget(
      {required this.type,
      required this.onPressed,
      this.label,
      this.icon,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ButtonType.normal:
        return normal(context);
      case ButtonType.borderless:
        return borderless(onPressed);
      case ButtonType.icon:
        return iconButton(onPressed);
      case ButtonType.important:
        return important(context);
    }
  }

  Widget borderless(onPressed) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: onPressed,
        child: Text(label ?? ''),
      ),
    );
  }

  Widget normal(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label ?? ''),
      ),
    );
  }

  Widget important(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: ERcaingApp.color.shade200),
        onPressed: onPressed,
        child: Text(label ?? ''),
      ),
    );
  }

  Widget iconButton(onPressed) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: const ShapeDecoration(
            color: ERcaingApp.color,
            shape: CircleBorder(),
          ),
          child: Center(
            child: IconButton(
                icon: Icon(icon, size: 16,),
                color: ERcaingApp.color.shade100,
                onPressed: onPressed),
          ),
        ),
        const BoundWidget(BoundType.small),
        TextWidget(label ?? '', Style.label)
      ],
    );
  }
}
