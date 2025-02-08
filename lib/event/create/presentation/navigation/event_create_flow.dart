import 'package:e_racing_app/event/create/presentation/ui/view/event_create_race_list_view.dart';
import 'package:e_racing_app/event/create/presentation/ui/view/event_create_settings_view.dart';
import 'package:flutter/cupertino.dart';

import '../event_create_view_model.dart';
import '../ui/view/event_create_banner_view.dart';
import '../ui/view/event_create_classes_view.dart';
import '../ui/view/event_create_name_view.dart';
import '../ui/view/event_create_options_view.dart';
import '../ui/view/event_create_fee_view.dart';
import '../ui/view/event_create_race_view.dart';
import '../ui/view/event_create_review_view.dart';
import '../ui/view/event_create_rules_view.dart';
import '../ui/view/event_create_score_view.dart';
import '../ui/view/event_create_status_view.dart';
import '../ui/view/event_create_tags_view.dart';
import '../ui/view/event_create_terms_view.dart';
import '../ui/view/event_review_view.dart';

enum EventCreateNavigator {
  eventTerms,
  eventName,
  eventOptions,
  eventPayment,
  eventRules,
  eventScore,
  eventBanner,
  eventClasses,
  eventTags,
  eventSettings,
  eventRaceList,
  eventRaceCreation,
  eventRaceEditing,
  eventReview,
  eventStatus
}

extension EventCreateNavigation on EventCreateNavigator {
  static Widget flow(EventCreateViewModel viewModel) {
    switch (viewModel.flow) {
      case EventCreateNavigator.eventTerms:
        return EventCreateTermsView(viewModel);
      case EventCreateNavigator.eventName:
        return EventCreateNameView(viewModel);
      case EventCreateNavigator.eventOptions:
        return EventOptionsView(viewModel);
      case EventCreateNavigator.eventPayment:
        return LeagueEventFeeView(viewModel);
      case EventCreateNavigator.eventRules:
        return LeagueEventRulesView(viewModel);
      case EventCreateNavigator.eventScore:
        return EventCreateScoreView(viewModel);
      case EventCreateNavigator.eventBanner:
        return EventCreateBannerView(viewModel);
      case EventCreateNavigator.eventClasses:
        return EventCreateClassesView(viewModel);
      case EventCreateNavigator.eventTags:
        return EventCreateTagsView(viewModel);
      case EventCreateNavigator.eventSettings:
        return EventCreateSettingsView(viewModel);
      // case EventCreateNavigator.eventRaceList:
      //   return EventCreateRaceListView(viewModel);
      // case EventCreateNavigator.eventRaceCreation:
      //   return EventCreateRaceView(viewModel);
      // case EventCreateNavigator.eventRaceEditing:
      //   return EventCreateRaceView(viewModel);
      case EventCreateNavigator.eventReview:
        return EventReviewView(viewModel);
      case EventCreateNavigator.eventStatus:
        return EventCreateStatusView(viewModel);
      default:
        return Container();
    }
  }
}
