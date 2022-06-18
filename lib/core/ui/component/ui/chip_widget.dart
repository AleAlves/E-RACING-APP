import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

class ChipWidget extends StatefulWidget {
  final String? label;
  final VoidCallback? onPressed;

  const ChipWidget({required this.label, this.onPressed, Key? key})
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
          padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextWidget(
                  text: widget.label ?? '',
                  style: Style.note,
                  color: Theme.of(context).colorScheme.onPrimary),
            ],
          ),
        ),
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
