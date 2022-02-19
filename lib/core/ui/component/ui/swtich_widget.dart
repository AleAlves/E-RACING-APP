import 'package:e_racing_app/core/ui/component/state/loading_ripple.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'card_widget.dart';

enum SwitchType { normal }

class SwitchWidget extends StatefulWidget {
  final String? positiveLabel;
  final String? negativeLabel;
  final IconData? icon;
  final SwitchType type;
  final Function(bool)? onPressed;
  final bool? enabled;

  const SwitchWidget(
      {this.enabled = false,
      this.type = SwitchType.normal,
      required this.onPressed,
      required this.positiveLabel,
      required this.negativeLabel,
      this.icon,
      Key? key})
      : super(key: key);

  Widget loading(BuildContext context) {
    return const LoadingRipple();
  }

  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case SwitchType.normal:
        return normal(context);
    }
  }

  Widget normal(BuildContext context) {
    return CardWidget(
      ready: true,
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextWidget(
                text: widget.enabled == true
                    ? widget.positiveLabel
                    : widget.negativeLabel,
                style: Style.description),
            Switch(
              activeColor: Theme.of(context).colorScheme.primary,
              onChanged: (bool value) {
                setState(() {
                  widget.onPressed?.call(value);
                });
              },
              value: widget.enabled == true,
            ),
          ],
        ),
      ),
    );
  }
}
