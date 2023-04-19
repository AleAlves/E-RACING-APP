import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'login_code_generate_view_model.dart';
import 'navigation/login_code_generate_navigation.dart';

class LoginCodeGenerateScreen extends StatefulWidget {
  const LoginCodeGenerateScreen({Key? key}) : super(key: key);

  @override
  _LoginCodeGenerateScreenState createState() =>
      _LoginCodeGenerateScreenState();
}

class _LoginCodeGenerateScreenState extends State<LoginCodeGenerateScreen>
    implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<LoginCodeGenerateViewModel>();

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
    return LoginGenerateCodeNavigation.flow(viewModel);
  }
}
