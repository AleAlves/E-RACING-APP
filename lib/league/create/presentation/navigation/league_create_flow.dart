import 'package:flutter/cupertino.dart';

import '../league_create_view_model.dart';
import '../view/league_create_banner_view.dart';
import '../view/league_create_description_view.dart';
import '../view/league_create_name_view.dart';
import '../view/league_create_review_view.dart';
import '../view/league_create_social_media_view.dart';
import '../view/league_create_status_view.dart';
import '../view/league_create_tags_view.dart';
import '../view/league_create_terms_view.dart';

enum LeagueCreateNavigator {
  terms,
  name,
  description,
  banner,
  tags,
  socialMedia,
  review,
  status,
  update,
  error
}

extension LeagueCreateNavigation on LeagueCreateNavigator {
  static Widget flow(LeagueCreateViewModel vm) {
    switch (vm.flow) {
      case LeagueCreateNavigator.terms:
        return LeagueCreateTermsView(vm);
      case LeagueCreateNavigator.name:
        return LeagueCreateNameView(vm);
      case LeagueCreateNavigator.description:
        return LeagueCreateDescriptionView(vm);
      case LeagueCreateNavigator.banner:
        return LeagueCreateBannerView(vm);
      case LeagueCreateNavigator.tags:
        return LeagueCreateTagsView(vm);
      case LeagueCreateNavigator.socialMedia:
        return LeagueCreateSocialMediaView(vm);
      case LeagueCreateNavigator.review:
        return LeagueCreateReviewView(vm);
      case LeagueCreateNavigator.status:
        return LeagueCreateStatusView(vm);
      default:
        return LeagueCreateTermsView(vm);
    }
  }
}
