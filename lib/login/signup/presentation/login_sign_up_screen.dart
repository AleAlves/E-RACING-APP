import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../../core/ui/component/ui/text_widget.dart';
import 'login_sign_up_view_model.dart';
import 'navigation/login_sign_up_navigation.dart';

class LoginSignUpScreen extends StatefulWidget {
  const LoginSignUpScreen({Key? key}) : super(key: key);

  @override
  _LoginSignUpScreenState createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen>
    implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<LoginSignUpViewModel>();

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => scaffold());

  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget scaffold() {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: TextWidget(
          text: viewModel.title,
          style: Style.paragraph,
        ),
      ),
      body: navigate(),
    );
  }

  @override
  Widget navigate() {
    return LoginSignUpNavigation.flow(viewModel);
  }
}
