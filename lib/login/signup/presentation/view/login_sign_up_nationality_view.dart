import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/country_picker_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/ui/component/ui/text_widget.dart';
import '../login_sign_up_view_model.dart';
import '../router/login_sign_up_navigation.dart';

class LoginSignUpNationalityView extends StatefulWidget {
  final LoginSignUpViewModel viewModel;

  const LoginSignUpNationalityView(this.viewModel, {Key? key})
      : super(key: key);

  @override
  _LoginSignUpNationalityViewState createState() =>
      _LoginSignUpNationalityViewState();
}

class _LoginSignUpNationalityViewState extends State<LoginSignUpNationalityView>
    implements BaseSateWidget {
  final _formKey = GlobalKey<FormState>();
  late String? country = "BR";

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
        body: content(),
        bottom: buttonWidget(),
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Widget content() {
    return Form(
      child: signinForm(),
      key: _formKey,
    );
  }

  Widget signinForm() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpacingWidget(LayoutSize.size48),
          const TextWidget(text: "Where are you from?", style: Style.subtitle),
          const SpacingWidget(LayoutSize.size48),
          CardWidget(
            highlight: true,
            ready: true,
            shapeLess: true,
            child: CountryPickerWidget(
              onCountrySelected: (code) {
                country = code;
              },
            ),
          ),
          const SpacingWidget(LayoutSize.size16),
        ],
      ),
    );
  }

  Widget buttonWidget() {
    return ButtonWidget(
      enabled: true,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.setNationality(country);
      },
      label: "Next",
    );
  }

  @override
  observers() {}

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.decreaseStep(LoginSignUpRouterSet.email);
    return false;
  }
}
