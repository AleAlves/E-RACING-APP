import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/main.dart';
import 'package:flutter/material.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../login_view_model.dart';

class Login2FAWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const Login2FAWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _Login2FAWidgetState createState() => _Login2FAWidgetState();
}

class _Login2FAWidgetState extends State<Login2FAWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextWidget("Second Step Verification", Style.description),
            const BoundWidget(BoundType.medium),
            OtpTextField(
              autoFocus: true,
              numberOfFields: 6,
              borderColor: ERcaingApp.color,
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              //runs when a code is typed in
              onCodeChanged: (String code) {
                //handle validation or checks here
              },
              //runs when every textfield is filled
              onSubmit: (String code) {
                widget.viewModel.login2fa(code);
              }, // end onSubmit
            ),
            const BoundWidget(BoundType.huge),
            ButtonWidget("I can't access", ButtonType.borderless, (){
              widget.viewModel.flow = LoginFlow.resetCode;
            }),
          ],
        ),
        onWillPop: _onBackPressed);
  }

  Future<bool> _onBackPressed() async {
    widget.viewModel.loginAutomatically = false;
    widget.viewModel.flow = LoginFlow.login;
    return false;
  }
}
