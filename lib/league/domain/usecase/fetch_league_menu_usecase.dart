import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/shortcut_model.dart';
import 'package:e_racing_app/core/tools/routes.dart';
import 'package:flutter/material.dart';

class FetchLeagueMenuUseCase<T> extends BaseUseCase<T?> {
  @override
  void invoke({required Function(T?) success, required Function error}) async {
    List<ShortcutModel> menu = [];
    menu.add(ShortcutModel(
        title: "All events", icon: Icons.emoji_events, deepLink: Routes.events, highlight: true));
    menu.add(ShortcutModel(
        title: "Members", icon: Icons.supervised_user_circle, deepLink: ""));
    menu.add(ShortcutModel(
        title: "Historic", icon: Icons.flag_sharp, deepLink: ""));
    menu.add(ShortcutModel(
        title: "Chat", icon: Icons.chat, deepLink: ""));
    success.call(menu as T);
  }
}
