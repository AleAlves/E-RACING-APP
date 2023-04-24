import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/ui/component/ui/share_widget.dart';
import '../league_view_model.dart';
import 'navigation/league_member_navigation.dart';

class LeagueScreen extends StatefulWidget {
  final LeagueDetailNavigationSet flow;

  const LeagueScreen(this.flow, {Key? key}) : super(key: key);

  @override
  _LeagueScreenState createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueScreen> implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<LeagueViewModel>();

  @override
  void initState() {
    viewModel.setFlow(widget.flow);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Leagues'),
          actions: [
            ShareWidget(
              model: viewModel.share,
            )
          ],
        ),
        body: navigate(),
      );
    });
  }

  @override
  Widget navigate() {
    return LeagueMemberNavigation.flow(viewModel);
  }
}
