import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../login_code_generate_view_model.dart';
import '../view/login_code_generate_view.dart';

enum LoginGenerateCodeNavigationSet { home }

extension LoginGenerateCodeNavigation on LoginGenerateCodeNavigationSet {
  static Widget flow(LoginCodeGenerateViewModel viewModel) {
    switch (viewModel.flow) {
      case LoginGenerateCodeNavigationSet.home:
        return LoginCodeGenerateView(viewModel);
    }
  }
}
