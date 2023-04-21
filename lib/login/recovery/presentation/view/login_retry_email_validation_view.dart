import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../login_password_recovery_view_model.dart';
import '../navigation/login_password_recovery_navigation.dart';

class LoginRetryEmailValidationView extends StatefulWidget {
  final LoginPasswordRecoveryViewModel viewModel;

  const LoginRetryEmailValidationView(this.viewModel, {Key? key})
      : super(key: key);

  @override
  _LoginRetryEmailValidationViewState createState() =>
      _LoginRetryEmailValidationViewState();
}

class _LoginRetryEmailValidationViewState
    extends State<LoginRetryEmailValidationView> implements BaseSateWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void initState() {
    _emailController.text = '';
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
      onBackPressed: onBackPressed,
      state: widget.viewModel.state,
    );
  }

  @override
  observers() {}

  @override
  Widget content() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpacingWidget(LayoutSize.size128),
          Form(
              child: Column(
                children: [
                  const TextWidget(
                      text: "Resend email validation", style: Style.paragraph),
                  const SpacingWidget(LayoutSize.size48),
                  InputTextWidget(
                      enabled: true,
                      label: "Email",
                      icon: Icons.mail,
                      controller: _emailController,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty == true ||
                            !value.contains("@")) {
                          return 'valid email needed';
                        }
                        return null;
                      }),
                ],
              ),
              key: _formKey),
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
          widget.viewModel.retryMailValidation(_emailController.text);
        }
      },
      label: "Recover",
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.onNavigate(LoginPasswordRecoveryNavigationSet.recover);
    return false;
  }
}
