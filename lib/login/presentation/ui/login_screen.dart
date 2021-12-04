import 'package:e_racing_app/core/ui/component/state/loading_ripple.dart';
import 'package:e_racing_app/league/presentation/ui/league_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:e_racing_app/core/ui/component/custom_brackground.dart';
import 'package:e_racing_app/login/presentation/widget/login_error_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
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
            return navigation();
          })
        ],
      ),
    );
  }

  Widget navigation() {
    switch (viewModel.state) {
      case ViewState.loading:
        return const LoadingRipple();
      case ViewState.ready:
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
            return  LoginStatusWidget(viewModel);
          case LoginFlow.toogle2fa:
            return LoginToogle2FAWidget(viewModel);
          case LoginFlow.otpQr:
            return LoginOtpQRWidget(viewModel);
        }
      case ViewState.error:
        return LoginErrorWidget(viewModel);
      case ViewState.navigation:
        _navigateToNextScreen(context);
        return Container();
    }
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LeagueScreen()));
  }
}
