import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/main.dart';
import 'package:flutter/material.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../login_view_model.dart';

class Login2FAWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const Login2FAWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _Login2FAWidgetState createState() => _Login2FAWidgetState();
}

class _Login2FAWidgetState extends State<Login2FAWidget>
    implements BaseSateWidget {
  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() {
    return Observer(builder: (_) => viewState());
  }

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
      content: content(),
      onBackPressed: onBackPressed,
      state: widget.viewModel.state,
    );
  }

  @override
  observers() {}

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.loginAutomatically = false;
    widget.viewModel.flow = LoginWidgetFlow.login;
    return false;
  }

  @override
  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const TextWidget("Second Step Verification", Style.description),
        const BoundWidget(BoundType.medium),
        OtpTextField(
          autoFocus: true,
          numberOfFields: 6,
          borderColor: ERcaingApp.color,
          showFieldAsBox: true,
          onCodeChanged: (String code) {},
          onSubmit: (String code) {
            widget.viewModel.login2fa(code);
          },
        ),
        const BoundWidget(BoundType.huge),
        ButtonWidget(
          type: ButtonType.borderless,
          onPressed: () {
            widget.viewModel.flow = LoginWidgetFlow.resetCode;
          },
          label: "I can't access",
        ),
      ],
    );
  }
}
