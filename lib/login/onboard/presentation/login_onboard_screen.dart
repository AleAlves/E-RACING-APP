import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../../core/ui/component/ui/text_widget.dart';
import 'login_onboard_view_model.dart';
import 'navigation/login_onboard_navigation.dart';

class LoginOnboardScreen extends StatefulWidget {
  const LoginOnboardScreen({Key? key}) : super(key: key);

  @override
  _LoginOnboardScreenState createState() => _LoginOnboardScreenState();
}

class _LoginOnboardScreenState extends State<LoginOnboardScreen>
    implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<LoginOnboardViewModel>();

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
        text: 'Pitlane Dash',
        style: Style.title,
      )),
      body: navigate(),
    );
  }

  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget navigate() {
    return LoginOnboardNavigation.flow(viewModel);
  }
}
