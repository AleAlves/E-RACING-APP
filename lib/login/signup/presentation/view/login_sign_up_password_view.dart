import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/ui/component/ui/text_widget.dart';
import '../login_sign_up_view_model.dart';
import '../router/login_sign_up_navigation.dart';

class LoginSignUpPasswordView extends StatefulWidget {
  final LoginSignUpViewModel viewModel;

  const LoginSignUpPasswordView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginSignUpPasswordViewState createState() =>
      _LoginSignUpPasswordViewState();
}

class _LoginSignUpPasswordViewState extends State<LoginSignUpPasswordView>
    implements BaseSateWidget {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  late String password = "";

  @override
  void initState() {
    _passwordController.text = '';
    _passwordConfirmController.text = '';
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SpacingWidget(LayoutSize.size48),
          const TextWidget(
              text: "Craft yourself a password", style: Style.subtitle),
          const SpacingWidget(LayoutSize.size16),
          const TextWidget(
            text: "- 8 Characters long",
            style: Style.caption,
            align: TextAlign.start,
          ),
          const TextWidget(
            text: "- letters and numbers",
            style: Style.caption,
            align: TextAlign.start,
          ),
          const TextWidget(
            text: "- spacial character",
            style: Style.caption,
            align: TextAlign.start,
          ),
          const SpacingWidget(LayoutSize.size16),
          InputTextWidget(
            enabled: true,
            label: 'Password',
            controller: _passwordController,
            validator: (value) {
              if (value == null || value.isEmpty == true) {
                return 'Password needed';
              }
              if (value.length < 8) {
                return 'Password too short';
              } else {
                password = value;
              }
              return null;
            },
            inputType: InputType.password,
          ),
          const SpacingWidget(LayoutSize.size32),
          const TextWidget(
            text: "Then repeat it",
            style: Style.caption,
            align: TextAlign.start,
          ),
          const SpacingWidget(LayoutSize.size16),
          InputTextWidget(
            enabled: true,
            label: 'Confirm password',
            controller: _passwordConfirmController,
            validator: (value) {
              if (value == null || value.isEmpty == true) {
                return 'Password needed';
              } else if (value != password) {
                return 'Password not the same';
              }
              return null;
            },
            inputType: InputType.password,
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
        widget.viewModel.setPassword(_passwordConfirmController.text);
      },
      label: "Next",
    );
  }

  @override
  observers() {}

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.decreaseStep(LoginSignUpRouterSet.tags);
    return false;
  }
}
