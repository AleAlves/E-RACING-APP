import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/model/shortcut_model.dart';
import 'package:e_racing_app/core/navigation/routes.dart';
import 'package:flutter/material.dart';

import '../presentation/ui/navigation/league_flow.dart';

class FetchLeagueMenuUseCase<T> extends BaseUseCase<T?> {
  @override
  void invoke({required Function(T?) success, required Function error}) async {
    List<ShortcutModel> menu = [];
    menu.add(ShortcutModel(
        title: "All events",
        subtitle: "Racing events such as tournaments, cups or single races",
        icon: Icons.emoji_events,
        deepLink: Routes.events,
        highlight: true));
    menu.add(ShortcutModel(
        title: "Members",
        subtitle: "Drivers of this community",
        icon: Icons.supervised_user_circle,
        flow: LeagueFlow.members));
    menu.add(ShortcutModel(
        title: "Trophy room",
        subtitle: "The hall of honor of the champions of this community",
        icon: Icons.military_tech_sharp,
        deepLink: ""));
    success.call(menu as T);
  }
}
