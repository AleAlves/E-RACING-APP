import 'dart:math';
import 'dart:ui';

import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:flutter/material.dart';

Pair<Color, Color> getPodiumColor(int? position) {
  switch (position) {
    case 1:
      return Pair(const Color(0xFFC6A23D), Colors.black);
    case 2:
      return Pair(const Color(0xFFBAB9B9), Colors.black);
    case 3:
      return Pair(const Color(0xFFDC8A61), Colors.black);
    default:
      return Pair(null, null);
  }
}

Color getTypeColor(EventType? type) {
  switch (type) {
    case EventType.championship:
      return const Color(0xFF7A2491);
    case EventType.race:
      return const Color(0xFF295483);
    default:
      return Colors.red;
  }
}

Color getClassColor(int _index) {
  switch (_index) {
    case 1:
      return const Color(0xFFB600B2);
    case 2:
      return const Color(0xFF00E0E0);
    case 3:
      return const Color(0xFF6B8725);
    case 4:
      return const Color(0xFFE80051);
    case 5:
      return const Color(0xFF00E0E0);
    case 6:
      return const Color(0xFF58003F);
    case 7:
      return const Color(0xFFF52C00);
    case 8:
      return const Color(0xFF1E205C);
    case 9:
      return const Color(0xFF236A00);
    case 10:
      return const Color(0xFFB0ABFF);
    default:
      return const Color(0xFF1F6DC1);
  }
}

Color getTeamColor(int _index) {
  switch (_index) {
    case 0:
      return const Color(0xFFB600B2);
    case 1:
      return const Color(0xFF55B600);
    case 2:
      return const Color(0xFF00E0E0);
    case 3:
      return const Color(0xFFA30000);
    case 4:
      return const Color(0xFF001FE8);
    case 5:
      return const Color(0xFF8300E0);
    case 6:
      return const Color(0xFF58003F);
    case 7:
      return const Color(0xFFF52C00);
    case 8:
      return const Color(0xFF1E205C);
    case 9:
      return const Color(0xFFFF8E00);
    case 10:
      return const Color(0xFFB0ABFF);
    case 11:
      return const Color(0xFF00583C);
    case 12:
      return const Color(0xFFB600B2);
    case 13:
      return const Color(0xFF00E0E0);
    case 14:
      return const Color(0xFF3BA300);
    case 15:
      return const Color(0xFFE80051);
    case 16:
      return const Color(0xFF00E0E0);
    case 17:
      return const Color(0xFF58003F);
    case 18:
      return const Color(0xFFF52C00);
    case 19:
      return const Color(0xFF1E205C);
    case 20:
      return const Color(0xFF236A00);
    case 21:
      return const Color(0xFFB0ABFF);
    case 22:
      return const Color(0xFF710000);
    case 23:
      return const Color(0xFF98FFFF);
    case 24:
      return const Color(0xFFDE9212);
    case 25:
      return const Color(0xFF00B603);
    default:
      return const Color(0xFFE50000);
  }
}

Color randomColor(int length) {
  return Color(Random().nextInt(0xffffffff));
}
