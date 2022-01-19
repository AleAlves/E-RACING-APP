import 'package:e_racing_app/core/domain/base_usecase.dart';
import 'package:e_racing_app/core/data/http_request.dart';
import 'package:e_racing_app/core/model/shortcut_model.dart';
import 'package:e_racing_app/home/domain/model/league_model.dart';
import 'package:e_racing_app/league/presentation/ui/league_flow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FetchLeagueMenuUseCase<T> extends BaseUseCase<T?> {
  @override
  void invoke({required Function(T?) success, required Function error}) async {
    List<ShortcutModel> menu = [];
    menu.add(ShortcutModel(
        title: "Edit League", icon: Icons.edit, flow: LeagueFlow.edit));
    menu.add(ShortcutModel(
        title: "Members", icon: Icons.supervised_user_circle, deepLink: ""));
    menu.add(ShortcutModel(
        title: "Events", icon: Icons.emoji_events, deepLink: ""));
    menu.add(ShortcutModel(
        title: "Historic", icon: Icons.flag_sharp, deepLink: ""));
    success.call(menu as T);
  }
}
