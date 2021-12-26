import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/league/presentation/ui/league_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:e_racing_app/core/ui/component/custom_brackground.dart';
import 'package:e_racing_app/login/presentation/widget/login_2fa_otp_qr_widget.dart';
import 'package:e_racing_app/login/presentation/widget/login_2fa_otp_widget.dart';
import 'package:e_racing_app/login/presentation/widget/login_2fa_toogle_widget.dart';
import 'package:e_racing_app/login/presentation/widget/login_forgot_widget.dart';
import 'package:e_racing_app/login/presentation/widget/login_form_widget.dart';
import 'package:e_racing_app/login/presentation/widget/login_initial_widget.dart';
import 'package:e_racing_app/login/presentation/widget/login_reset_widget.dart';
import 'package:e_racing_app/login/presentation/widget/login_signin_widget.dart';
import 'package:e_racing_app/login/presentation/widget/login_status_widget.dart';

import '../login_view_model.dart';
import 'login_flow.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final LoginViewModel viewModel = LoginViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.getPublickey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('E-racing'),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: CustomPaint(
              painter: CustomBackground(),
            ),
          ),
          Observer(builder: (_) {
            return navigation(_);
          })
        ],
      ),
    );
  }

  Widget navigation(_) {
    switch (viewModel.flow) {
      case LoginFlow.initial:
        return LoginInitialWidget(viewModel);
      case LoginFlow.login:
        return LoginFormWidget(viewModel);
      case LoginFlow.signin:
        return LoginSigninWidget(viewModel);
      case LoginFlow.login2fa:
        return Login2FAWidget(viewModel);
      case LoginFlow.forgot:
        return LoginForgotWidget(viewModel);
      case LoginFlow.mailRegistration:
        return LoginStatusWidget(viewModel);
      case LoginFlow.reset:
        return LoginResetWidget(viewModel);
      case LoginFlow.resetCode:
        return LoginForgotWidget(viewModel);
      case LoginFlow.status:
        return LoginStatusWidget(viewModel);
      case LoginFlow.toogle2fa:
        return LoginToogle2FAWidget(viewModel);
      case LoginFlow.otpQr:
        return LoginOtpQRWidget(viewModel);
      case LoginFlow.next:
        return test(context);
    }
  }

  Widget test(BuildContext context) {
    return Center(
      child: ButtonWidget(
        ButtonType.normal,
        () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LeagueScreen()));
        },
        label: "next",
      ),
    );
  }
}
