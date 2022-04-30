import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/login/domain/model/profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
          const SpacingWidget(LayoutSize.size8),
          Row(
            children: [
              Icon(
                Icons.emoji_events_sharp,
                color: Theme.of(context).colorScheme.primary,
                size: 48,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
               Padding(
                padding: const EdgeInsets.all(8),
                child: TextWidget(
                  text: "Search racing communities",
                  style: Style.description,
                  color: Theme.of(context).colorScheme.primaryVariant,
                ),
              ),
              Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.primaryVariant,
                size: 24,
              ),
            ],
          ),
          const SpacingWidget(LayoutSize.size8),
        ],
      ),
    );
  }
}
