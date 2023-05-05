import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'league_list_view_model.dart';
import 'navigation/league_list_navigation.dart';

class LeagueListScreen extends StatefulWidget {
  const LeagueListScreen({Key? key}) : super(key: key);

  @override
  _LeagueListScreenState createState() => _LeagueListScreenState();
}

class _LeagueListScreenState extends State<LeagueListScreen>
    implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<LeagueListViewModel>();

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
          style: Style.subtitle,
        ),
      ),
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
    return LeagueListNavigation.flow(viewModel);
  }
}
