import 'package:e_racing_app/league/create/presentation/ui/view/league_create_name_view.dart';
import 'package:flutter/cupertino.dart';

import '../league_create_view_model.dart';
import '../ui/view/league_create_terms_view.dart';

enum LeagueCreateNavigator {
  terms,
  name,
  description,
  banner,
  tags,
  socialMedia,
  finish,
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
        return LeagueCreateTermsView(vm);
      case LeagueCreateNavigator.banner:
        return LeagueCreateTermsView(vm);
      case LeagueCreateNavigator.tags:
        return LeagueCreateTermsView(vm);
      case LeagueCreateNavigator.socialMedia:
        return LeagueCreateTermsView(vm);
      case LeagueCreateNavigator.finish:
        return LeagueCreateTermsView(vm);
      default:
        return LeagueCreateTermsView(vm);
    }
  }
}
