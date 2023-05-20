import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui/component/ui/status_view.dart';
import '../login_sign_up_view_model.dart';
import '../view/login_sign_up_email_view.dart';
import '../view/login_sign_up_name_view.dart';
import '../view/login_sign_up_nationality_view.dart';
import '../view/login_sign_up_password_view.dart';
import '../view/login_sign_up_review_view.dart';
import '../view/login_sign_up_tags_view.dart';
import '../view/login_sign_up_terms_view.dart';

enum LoginSignUpRouterSet {
  terms,
  name,
  email,
  nationality,
  tags,
  password,
  review,
  status
}

extension LoginSignUpRouter on LoginSignUpRouterSet {
  static Widget flow(LoginSignUpViewModel viewModel) {
    switch (viewModel.flow) {
      case LoginSignUpRouterSet.terms:
        return LoginSignUpTermsView(viewModel);
      case LoginSignUpRouterSet.name:
        return LoginSignUpNameView(viewModel);
      case LoginSignUpRouterSet.email:
        return LoginSignUpMailView(viewModel);
      case LoginSignUpRouterSet.nationality:
        return LoginSignUpNationalityView(viewModel);
      case LoginSignUpRouterSet.tags:
        return LoginSignUpTagsView(viewModel);
      case LoginSignUpRouterSet.password:
        return LoginSignUpPasswordView(viewModel);
      case LoginSignUpRouterSet.review:
        return LoginSignUpReviewView(viewModel);
      case LoginSignUpRouterSet.status:
      default:
        return StatusView(viewModel);
    }
  }
}
