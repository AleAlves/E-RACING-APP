import 'package:e_racing_app/event/create/presentation/ui/view/event_create_broadcast_view.dart';
import 'package:e_racing_app/event/create/presentation/ui/view/event_create_races_view.dart';
import 'package:e_racing_app/event/create/presentation/ui/view/event_create_settings_view.dart';
import 'package:flutter/cupertino.dart';

import '../event_create_view_model.dart';
import '../ui/view/event_create_banner_view.dart';
import '../ui/view/event_create_classes_view.dart';
import '../ui/view/event_create_name_view.dart';
import '../ui/view/event_create_options_view.dart';
import '../ui/view/event_create_rules_view.dart';
import '../ui/view/event_create_score_view.dart';
import '../ui/view/event_create_tags_view.dart';
import '../ui/view/event_create_terms_view.dart';

enum EventCreateNavigator {
  terms,
  name,
  rules,
  options,
  score,
  banner,
  classes,
  tags,
  settings,
  broadcast,
  races
}

extension EventCreateNavigation on EventCreateNavigator {
  static Widget flow(EventCreateViewModel viewModel) {
    switch (viewModel.flow) {
      case EventCreateNavigator.terms:
        return EventCreateTermsView(viewModel);
      case EventCreateNavigator.name:
        return EventCreateNameView(viewModel);
      case EventCreateNavigator.rules:
        return LeagueEventRulesView(viewModel);
      case EventCreateNavigator.options:
        return EventCreateOptionsView(viewModel);
      case EventCreateNavigator.score:
        return EventCreateScoreView(viewModel);
      case EventCreateNavigator.banner:
        return EventCreateBannerView(viewModel);
      case EventCreateNavigator.classes:
        return EventCreateClassesView(viewModel);
      case EventCreateNavigator.tags:
        return EventCreateTagsView(viewModel);
      case EventCreateNavigator.settings:
        return EventCreateSettingsView(viewModel);
      case EventCreateNavigator.broadcast:
        return EventCreateBroadcastView(viewModel);
      case EventCreateNavigator.races:
        return EventCreateRacesView(viewModel);
      default:
        return EventCreateNameView(viewModel);
    }
  }
}
