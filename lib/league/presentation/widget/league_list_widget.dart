import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/league/presentation/league_view_model.dart';
import 'package:e_racing_app/league/presentation/ui/league_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../league_view_model.dart';


class LeagueListWidget extends StatefulWidget {

  final LeagueViewModel viewModel;

  const LeagueListWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueListWidgetState createState() => _LeagueListWidgetState();
}

class _LeagueListWidgetState extends State<LeagueListWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonWidget("Create league", ButtonType.normal, () {
              widget.viewModel.flow = LeagueFlow.create;
            }),
            Observer(builder: (_) {
              return Container();
            }),
          ],
        ),
        onWillPop: _onBackPressed);
  }

  Future<bool> _onBackPressed() async {
    return false;
  }
}
