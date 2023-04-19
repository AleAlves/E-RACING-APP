import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'login_password_reset_view_model.dart';
import 'navigation/login_password_reset_navigation.dart';

class LoginPasswordResetScreen extends StatefulWidget {
  const LoginPasswordResetScreen({Key? key}) : super(key: key);

  @override
  _LoginPasswordResetScreenState createState() =>
      _LoginPasswordResetScreenState();
}

class _LoginPasswordResetScreenState extends State<LoginPasswordResetScreen>
    implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<LoginPasswordResetViewModel>();

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
    return LoginPasswordResetNavigation.flow(viewModel);
  }
}
