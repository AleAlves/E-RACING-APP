

import 'package:e_racing_app/profile/presentation/profile_view_model.dart';
import 'package:e_racing_app/profile/presentation/ui/widget/profile_widget.dart';
import 'package:flutter/cupertino.dart';

enum ProfileFlow {
  home,
  error,
}

extension ProfileNavigation on ProfileFlow {
  static Widget flow(ProfileViewModel vm) {
    switch (vm.flow) {
      case ProfileFlow.home:
        return ProfileWidget(vm);
      default:
        return ProfileWidget(vm);
    }
  }
}