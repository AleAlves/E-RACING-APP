import 'package:flutter/cupertino.dart';

class ShortcutModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final dynamic flow;
  final String? deepLink;
  final bool? highlight;

  ShortcutModel(
      {required this.title,
      required this.subtitle,
      required this.icon,
      this.flow,
      this.deepLink,
      this.highlight});
}
