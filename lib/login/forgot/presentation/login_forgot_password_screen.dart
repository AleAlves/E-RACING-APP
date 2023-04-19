import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'login_forgot_password_view_model.dart';
import 'navigation/login_forgot_password_navigation.dart';

class LoginForgotPasswordScreen extends StatefulWidget {
  const LoginForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _LoginForgotPasswordScreenState createState() =>
      _LoginForgotPasswordScreenState();
}

class _LoginForgotPasswordScreenState extends State<LoginForgotPasswordScreen>
    implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<LoginForgotPasswordViewModel>();

  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
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
          Observer(builder: (_) {
            return navigate();
          })
        ],
      ),
    );
  }

  @override
  Widget navigate() {
    return LoginForgotPasswordNavigation.flow(viewModel);
  }
}
