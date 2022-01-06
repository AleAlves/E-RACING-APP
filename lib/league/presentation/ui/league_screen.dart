import 'package:e_racing_app/core/ui/component/custom_brackground.dart';
import 'package:e_racing_app/core/ui/component/ui/scroll_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/league/presentation/league_view_model.dart';
import 'package:e_racing_app/league/presentation/ui/widget/league_create_widget.dart';
import 'package:e_racing_app/league/presentation/ui/widget/league_fetch_widget.dart';
import 'package:e_racing_app/league/presentation/ui/widget/league_status_widget.dart';
import 'package:e_racing_app/league/presentation/ui/widget/league_update_widget.dart';
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

class _LeagueScreenState extends State<LeagueScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final viewModel = Modular.get<LeagueViewModel>();
  ViewState? curentState;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ScrollWidget(
          'Leagues',
          Expanded(
            child: Stack(
              children: [
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: CustomBackground(),
                  ),
                ),
                Observer(builder: (_) {
                  return navigation();
                })
              ],
            ),
          )),
    );
  }

  Widget navigation() {
    switch (viewModel.flow) {
      case LeagueFlow.list:
        return LeagueListWidget(viewModel);
      case LeagueFlow.create:
        return LeagueCreateWidget(viewModel);
      case LeagueFlow.delete:
        return LeagueCreateWidget(viewModel);
      case LeagueFlow.edit:
        return LeagueUpdateWidget(viewModel);
      case LeagueFlow.join:
        return LeagueCreateWidget(viewModel);
      case LeagueFlow.error:
        return LeagueCreateWidget(viewModel);
      case LeagueFlow.status:
        return LeagueStatusWidget(viewModel);
      default:
        return LeagueCreateWidget(viewModel);
    }
  }
}
