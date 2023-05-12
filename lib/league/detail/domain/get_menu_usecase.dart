import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/shortcut_model.dart';
import 'package:e_racing_app/event/event_router.dart';
import 'package:e_racing_app/league/LeagueRouter.dart';
import 'package:flutter/material.dart';

class GetMenuUseCase<T> extends BaseUseCase<T?> {
  @override
  void invoke({required Function(T?) success, required Function error}) async {
    List<ShortcutModel> menu = [];
    menu.add(ShortcutModel(
        title: "All events",
        subtitle: "Racing events such as tournaments, cups or single races",
        icon: Icons.sports_score,
        deepLink: EventRouter.list,
        highlight: true));
    menu.add(ShortcutModel(
        title: "Members",
        subtitle: "Drivers of this community",
        icon: Icons.supervised_user_circle,
        deepLink: LeagueRouter.members));
    menu.add(ShortcutModel(
        title: "Trophy room",
        subtitle: "The hall of honor of the champions of this community",
        icon: Icons.emoji_events,
        deepLink: LeagueRouter.trophies));
    success.call(menu as T);
  }
}
