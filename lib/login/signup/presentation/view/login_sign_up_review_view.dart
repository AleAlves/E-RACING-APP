import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/ui/component/ui/button_widget.dart';
import '../../../../core/ui/component/ui/country_picker_widget.dart';
import '../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../core/ui/component/ui/text_widget.dart';
import '../login_sign_up_view_model.dart';
import '../router/login_sign_up_navigation.dart';

class LoginSignUpReviewView extends StatefulWidget {
  final LoginSignUpViewModel viewModel;

  const LoginSignUpReviewView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginSignUpReviewViewState createState() => _LoginSignUpReviewViewState();
}

class _LoginSignUpReviewViewState extends State<LoginSignUpReviewView>
    implements BaseSateWidget {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
        alignment: Alignment.topLeft,
        body: content(),
        bottom: buttonWidget(),
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Widget content() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SpacingWidget(LayoutSize.size48),
          const TextWidget(text: "Review your account", style: Style.subtitle),
          const SpacingWidget(LayoutSize.size48),
          TextWidget(text: widget.viewModel.name, style: Style.subtitle),
          const SpacingWidget(LayoutSize.size16),
          TextWidget(text: widget.viewModel.surname, style: Style.subtitle),
          const SpacingWidget(LayoutSize.size16),
          TextWidget(text: widget.viewModel.email, style: Style.subtitle),
          const SpacingWidget(LayoutSize.size16),
          CountryPickerWidget(
            country: widget.viewModel.nationality,
            onCountrySelected: (code) {},
          )
        ],
      ),
    );
  }

  @override
  observers() {}

  Widget buttonWidget() {
    return ButtonWidget(
      enabled: true,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.signIn();
      },
      label: "Create account",
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.decreaseStep(LoginSignUpRouterSet.password);
    return false;
  }
}
