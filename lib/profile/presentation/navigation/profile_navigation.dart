import 'package:e_racing_app/core/ui/component/ui/status_view.dart';
import 'package:e_racing_app/profile/presentation/profile_view_model.dart';
import 'package:flutter/cupertino.dart';

import '../view/profile_update_view.dart';

enum ProfileNavigationSet {
  home,
  status,
}

extension ProfileNavigation on ProfileNavigationSet {
  static Widget flow(ProfileViewModel viewModel) {
    switch (viewModel.flow) {
      case ProfileNavigationSet.home:
        return ProfileUpdateView(viewModel);
      case ProfileNavigationSet.status:
        return StatusView(viewModel);
      default:
        return ProfileUpdateView(viewModel);
    }
  }
}
