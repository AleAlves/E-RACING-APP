import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/scroll_widget.dart';
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
        child: Observer(
          builder: (_) {
            return ScrollWidget('Leagues', getContent());
          },
        ),
        onWillPop: _onBackPressed);
  }

  Widget getContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonWidget("Create league", ButtonType.normal, () {
          widget.viewModel.setFlow(LeagueFlow.create);
        }),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.viewModel.leagues?.length,
            itemBuilder: (context, index) {
              return CardWidget(widget.viewModel.leagues?[index]?.name,
                  widget.viewModel.leagues?[index]?.emblem);
            },
          ),
        ),
      ],
    );
  }

  Future<bool> _onBackPressed() async {
    widget.viewModel.setFlow(LeagueFlow.list);
    return false;
  }
}
