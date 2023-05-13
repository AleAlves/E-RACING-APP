import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/session_model.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:flutter/material.dart';

import '../ui/component/ui/text_widget.dart';

IconData? getIcon(EventType? type) {
  switch (type) {
    case EventType.race:
      return Icons.sports_score;
    case EventType.championship:
      return Icons.emoji_events;
    default:
      return Icons.sports_score;
  }
}

Color? getColor(EventType? type, BuildContext context) {
  switch (type) {
    case EventType.race:
      return Theme.of(context).colorScheme.secondaryContainer;
    case EventType.championship:
      return Theme.of(context).colorScheme.primaryContainer;
    default:
      return Colors.red;
  }
}

String? getSesionTypeFirstLetter(SessionType? type) {
  switch (type) {
    case SessionType.race:
      return "R";
    case SessionType.practice:
      return "P";
    case SessionType.qualify:
      return "Q";
    case SessionType.warmup:
      return "W";
    default:
      return "";
  }
}

Widget getSesion(SessionType? type) {
  switch (type) {
    case SessionType.race:
      return Row(
        children: const [
          Icon(
            Icons.circle,
            color: Color(0xFF378F1B),
            size: 8,
          ),
          SpacingWidget(LayoutSize.size8),
          SpacingWidget(LayoutSize.size2),
          TextWidget(
            text: "Race",
            style: Style.caption,
          )
        ],
      );
    case SessionType.practice:
      return Row(
        children: const [
          Icon(
            Icons.circle,
            color: Color(0xFF136091),
            size: 8,
          ),
          SpacingWidget(LayoutSize.size8),
          TextWidget(
            text: "Practice",
            style: Style.caption,
          )
        ],
      );
    case SessionType.qualify:
      return Row(
        children: const [
          Icon(
            Icons.circle,
            color: Color(0xFFE06E3D),
            size: 8,
          ),
          SpacingWidget(LayoutSize.size8),
          TextWidget(
            text: "Qualify",
            style: Style.caption,
          )
        ],
      );
    case SessionType.warmup:
      return Row(
        children: const [
          Icon(
            Icons.circle,
            color: Color(0xFF9B2222),
            size: 8,
          ),
          SpacingWidget(LayoutSize.size8),
          TextWidget(
            text: "Warmup",
            style: Style.caption,
          )
        ],
      );
    default:
      return const Icon(Icons.error);
  }
}
