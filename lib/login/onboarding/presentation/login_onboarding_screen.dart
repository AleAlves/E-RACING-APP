import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'login_onboarding_view_model.dart';
import 'navigation/login_onboarding_navigation.dart';

class LoginOnboarding extends StatefulWidget {
  const LoginOnboarding({Key? key}) : super(key: key);

  @override
  _LoginOnboardingState createState() => _LoginOnboardingState();
}

class _LoginOnboardingState extends State<LoginOnboarding>
    implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<LoginOnboardingViewModel>();

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
    return LoginOnboardingNavigation.flow(viewModel);
  }
}
