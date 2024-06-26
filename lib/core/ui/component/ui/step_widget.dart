import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

class StepWidget extends StatefulWidget {
  final String title;
  final bool pending;

  const StepWidget({required this.title, this.pending = false, Key? key})
      : super(key: key);

  @override
  _StepWidgetState createState() => _StepWidgetState();
}

class _StepWidgetState extends State<StepWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => content();

  Widget content() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(
          text: widget.title,
          style: Style.paragraph,
        ),
        widget.pending
            ? Row(
                children: const [
                  TextWidget(
                    text: "Pending",
                    style: Style.caption,
                  ),
                  SpacingWidget(LayoutSize.size8),
                  Icon(
                    Icons.warning,
                    color: Colors.orange,
                    size: 16,
                  ),
                ],
              )
            : Container()
      ],
    );
  }
}
