import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/league/list/presentation/router/league_list_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'league_list_view_model.dart';

class LeagueListScreen extends StatefulWidget {
  final LeagueListRouterSet? router;

  const LeagueListScreen({this.router, Key? key}) : super(key: key);

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
          style: Style.title,
        ),
      ),
      body: navigate(),
    );
  }

  @override
  void initState() {
    viewModel.flow = widget.router;
    super.initState();
  }

  @override
  Widget navigate() {
    return LeagueListRouting.flow(viewModel);
  }
}
