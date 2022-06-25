import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/session_model.dart';
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

Widget getSesionIcon(SessionType? type) {
  switch (type) {
    case SessionType.race:
      return const Icon(
        Icons.circle,
        color: Color(0xFF378F1B),
        size: 12,
      );
    case SessionType.practice:
      return const Icon(
        Icons.circle,
        color: Color(0xFF136091),
        size: 12,
      );
    case SessionType.qualify:
      return const Icon(
        Icons.circle,
        color: Color(0xFFE06E3D),
        size: 12,
      );
    case SessionType.warmup:
      return const Icon(
        Icons.circle,
        color: Color(0xFF9B2222),
        size: 12,
      );
    default:
      return const Icon(Icons.error);
  }
}
