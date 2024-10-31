import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../core/ui/component/ui/text_widget.dart';
import 'app_view_model.dart';
import 'navigation/app_navigation.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<AppViewModel>();

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
        text: 'Race pit',
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
    return AppNavigation.flow(viewModel);
  }
}
