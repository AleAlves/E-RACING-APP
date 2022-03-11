import 'package:e_racing_app/core/model/event_model.dart';
import 'package:flutter/material.dart';

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

Color? getColor(EventType? type) {
  switch (type) {
    case EventType.race:
      return const Color(0xFF311AA0);
    case EventType.championship:
      return const Color(0xFF1AA01C);
    default:
      return const Color(0xFF1AA01C);
  }
}