import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';

class LeaguesCardWidget extends StatelessWidget {
  final VoidCallback? onPressed;

  const LeaguesCardWidget({this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: content(context),
      onPressed: onPressed,
      ready: true,
    );
  }

  Widget content(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.emoji_events_sharp,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SpacingWidget(LayoutSize.size8),
              const Padding(
                padding: EdgeInsets.all(8),
                child: TextWidget(
                  text: "Leagues",
                  style: Style.title,
                ),
              ),
            ],
          ),
          const SpacingWidget(LayoutSize.size8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: TextWidget(
                  text: "Racing communities",
                  style: Style.description,
                ),
              ),
              Icon(
                Icons.arrow_forward_sharp,
                color: Theme.of(context).colorScheme.onBackground,
                size: 24,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
