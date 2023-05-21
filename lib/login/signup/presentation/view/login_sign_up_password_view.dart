import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/icon_widget.dart';
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
  bool lengthRule = false;
  bool letterAndNumberRule = false;
  bool specialCharRule = false;
  bool passwordConfirmationRule = false;
  RegExp lettersRegex = RegExp(r'[a-zA-Z]');
  RegExp numbersRegex = RegExp(r'\d');
  RegExp specialCharRegex = RegExp(r'[\^$*.\[\]{}()?\-"!@#%&/\,><:;_~`+='
      "'"
      ']');

  @override
  void initState() {
    observers();
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
  observers() {
    _passwordController.text = widget.viewModel.password ?? '';
    _passwordConfirmController.text = widget.viewModel.password ?? '';
    _passwordController.addListener(() {
      setState(() {
        _runValidations();
      });
    });
    _passwordConfirmController.addListener(() {
      setState(() {
        _runValidations();
      });
    });
    _runValidations();
  }

  _runValidations() {
    lengthRule = _passwordController.text.length >= 8;
    letterAndNumberRule = lettersRegex.hasMatch(_passwordController.text) &&
        numbersRegex.hasMatch(_passwordController.text);
    specialCharRule = _passwordController.text.contains(specialCharRegex);
    passwordConfirmationRule =
        _passwordConfirmController.text == _passwordController.text &&
            _passwordConfirmController.text.isNotEmpty;
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
          rulesValidation(),
          const SpacingWidget(LayoutSize.size32),
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
              align: TextAlign.start),
          const SpacingWidget(LayoutSize.size16),
          InputTextWidget(
            enabled: lengthRule && letterAndNumberRule && specialCharRule,
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

  Widget rulesValidation() {
    return Column(
      children: [
        Row(
          children: [
            getRuleStatus(lengthRule),
            const SpacingWidget(LayoutSize.size8),
            const TextWidget(
              text: "At least 8 Characters long",
              style: Style.caption,
              align: TextAlign.start,
            ),
          ],
        ),
        const SpacingWidget(LayoutSize.size8),
        Row(
          children: [
            getRuleStatus(letterAndNumberRule),
            const SpacingWidget(LayoutSize.size8),
            const TextWidget(
              text: "letters and numbers",
              style: Style.caption,
              align: TextAlign.start,
            ),
          ],
        ),
        const SpacingWidget(LayoutSize.size8),
        Row(
          children: [
            getRuleStatus(specialCharRule),
            const SpacingWidget(LayoutSize.size8),
            const TextWidget(
              text: "spacial character",
              style: Style.caption,
              align: TextAlign.start,
            ),
          ],
        ),
        const SpacingWidget(LayoutSize.size8),
        Row(
          children: [
            getRuleStatus(passwordConfirmationRule),
            const SpacingWidget(LayoutSize.size8),
            const TextWidget(
              text: "Password confirmation",
              style: Style.caption,
              align: TextAlign.start,
            ),
          ],
        ),
      ],
    );
  }

  Widget getRuleStatus(bool rule) {
    if (rule) {
      return const IconWidget(
        icon: Icons.check_circle_rounded,
        color: Colors.green,
      );
    } else {
      return const IconWidget(
        icon: Icons.error,
        color: Colors.red,
      );
    }
  }

  Widget buttonWidget() {
    return ButtonWidget(
      enabled: lengthRule &&
          letterAndNumberRule &&
          specialCharRule &&
          passwordConfirmationRule,
      type: ButtonType.primary,
      onPressed: () {
        widget.viewModel.setPassword(_passwordConfirmController.text);
      },
      label: "Next",
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.decreaseStep(LoginSignUpRouterSet.tags);
    return false;
  }
}
