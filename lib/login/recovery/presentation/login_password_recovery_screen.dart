import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../../core/ui/component/ui/text_widget.dart';
import 'login_password_recovery_view_model.dart';
import 'navigation/login_password_recovery_navigation.dart';

class LoginPasswordRecoveryScreen extends StatefulWidget {
  const LoginPasswordRecoveryScreen({Key? key}) : super(key: key);

  @override
  _LoginPasswordRecoveryScreenState createState() =>
      _LoginPasswordRecoveryScreenState();
}

class _LoginPasswordRecoveryScreenState
    extends State<LoginPasswordRecoveryScreen> implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<LoginPasswordRecoveryViewModel>();

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => scaffold());

  @override
  Widget scaffold() {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: TextWidget(
              text: viewModel.title,
              style: Style.title,
            )
        ),
        body: navigate());
  }

  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget navigate() {
    return LoginPasswordRecoveryNavigation.flow(viewModel);
  }
}
