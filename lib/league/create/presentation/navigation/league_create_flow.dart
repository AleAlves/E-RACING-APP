import 'package:e_racing_app/league/create/presentation/ui/view/league_create_name_view.dart';
import 'package:flutter/cupertino.dart';

import '../league_create_view_model.dart';
import '../ui/view/league_create_banner_view.dart';
import '../ui/view/league_create_description_view.dart';
import '../ui/view/league_create_finish_view.dart';
import '../ui/view/league_create_social_media_view.dart';
import '../ui/view/league_create_tags_view.dart';
import '../ui/view/league_create_terms_view.dart';

enum LeagueCreateNavigator {
  terms,
  name,
  description,
  banner,
  tags,
  socialMedia,
  finish,
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
      case LeagueCreateNavigator.finish:
        return LeagueCreateFinishView(vm);
      default:
        return LeagueCreateTermsView(vm);
    }
  }
}
