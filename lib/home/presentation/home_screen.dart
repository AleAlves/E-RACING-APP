import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/home/presentation/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/ui/view_state.dart';
import 'router/home_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<HomeViewModel>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: TextWidget(
            text: viewModel.title,
            style: Style.subtitle,
          ),
        ),
        body: navigate(),
      );
    });
  }

  @override
  Widget navigate() {
    return HomeNavigation.flow(viewModel);
  }
}
