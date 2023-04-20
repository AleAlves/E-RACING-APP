import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'login_sign_in_view_model.dart';
import 'navigation/login_sign_in_navigation.dart';

class LoginSignInScreen extends StatefulWidget {
  const LoginSignInScreen({Key? key}) : super(key: key);

  @override
  _LoginSignInScreenState createState() => _LoginSignInScreenState();
}

class _LoginSignInScreenState extends State<LoginSignInScreen>
    implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<LoginSignInViewModel>();

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
        title: const Text('Sign In'),
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
    return LoginSignInNavigation.flow(viewModel);
  }
}
