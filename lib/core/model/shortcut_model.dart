import 'package:flutter/cupertino.dart';

class ShortcutModel {
  final String title;
  final IconData icon;
  final dynamic flow;
  final String? deepLink;

  ShortcutModel(
      {required this.title, required this.icon, this.flow, this.deepLink});
}
