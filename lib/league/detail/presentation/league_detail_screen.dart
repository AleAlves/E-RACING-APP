import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'league_detail_view_model.dart';
import 'navigation/league_detail_navigation.dart';

class LeagueDetailScreen extends StatefulWidget {
  const LeagueDetailScreen({Key? key}) : super(key: key);

  @override
  _LeagueDetailScreenState createState() => _LeagueDetailScreenState();
}

class _LeagueDetailScreenState extends State<LeagueDetailScreen>
    implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<LeagueDetailViewModel>();

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
    super.initState();
  }

  @override
  Widget navigate() {
    return LeagueDetailNavigation.flow(viewModel);
  }
}
