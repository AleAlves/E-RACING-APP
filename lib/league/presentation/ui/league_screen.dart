import 'package:e_racing_app/core/ui/component/custom_brackground.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/league/presentation/league_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'league_flow.dart';

class LeagueScreen extends StatefulWidget {
  const LeagueScreen({Key? key}) : super(key: key);

  @override
  _LeagueScreenState createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueScreen> implements BaseScreen {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<LeagueViewModel>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Leagues'),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: CustomPaint(
              painter: CustomBackground(),
            ),
          ),
          Observer(builder: (_) {
            return navigate();
          })
        ],
      ),
    );
  }

  @override
  Widget navigate() {
    return LeagueNavigation.flow(viewModel);
  }
}
