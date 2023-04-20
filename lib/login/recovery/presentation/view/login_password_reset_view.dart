import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../login_password_recovery_view_model.dart';

class LoginPasswordResetView extends StatefulWidget {
  final LoginPasswordRecoveryViewModel viewModel;

  const LoginPasswordResetView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginForgotWidgetState createState() => _LoginForgotWidgetState();
}

class _LoginForgotWidgetState extends State<LoginPasswordResetView>
    implements BaseSateWidget {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _mailController = TextEditingController();
  final _codeController = TextEditingController();
  late String password = "";

  @override
  void initState() {
    _mailController.text = '';
    _passwordController.text = '';
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
  observers() {}

  @override
  Widget content() {
    return Form(
      child: resetForm(),
      key: _formKey,
    );
  }

  Widget resetForm() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpacingWidget(LayoutSize.size128),
          const TextWidget(
              text: "Use the code we've sent you by email",
              style: Style.paragraph),
          const SpacingWidget(LayoutSize.size48),
          InputTextWidget(
              enabled: true,
              label: 'Validation code',
              icon: Icons.security,
              controller: _codeController,
              validator: (value) {
                if (value == null || value.isEmpty == true) {
                  return 'Validation code needed';
                }
                return null;
              }),
          const SpacingWidget(LayoutSize.size16),
          InputTextWidget(
            enabled: true,
            label: 'Password',
            icon: Icons.vpn_key,
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
          const SpacingWidget(LayoutSize.size16),
          InputTextWidget(
            enabled: true,
            label: 'Confirm password',
            icon: Icons.vpn_key,
            controller: _passwordConfirmationController,
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
        ],
      ),
    );
  }

  Widget buttonWidget() {
    return ButtonWidget(
      enabled: true,
      type: ButtonType.primary,
      onPressed: () {
        if (_formKey.currentState?.validate() == true) {
          widget.viewModel
              .reset(_passwordController.text, _codeController.text);
        }
      },
      label: 'Create new password',
    );
  }

  @override
  Future<bool> onBackPressed() async {
    // widget.viewModel.flow = LoginWidgetFlow.login;
    return false;
  }
}
