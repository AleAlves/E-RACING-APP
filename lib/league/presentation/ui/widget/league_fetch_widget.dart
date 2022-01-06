import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/league/presentation/league_view_model.dart';
import 'package:e_racing_app/league/presentation/ui/league_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LeagueListWidget extends StatefulWidget {
  final LeagueViewModel viewModel;

  const LeagueListWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueListWidgetState createState() => _LeagueListWidgetState();
}

class _LeagueListWidgetState extends State<LeagueListWidget> {
  @override
  void initState() {
    widget.viewModel.fetchLeagues();
    widget.viewModel.fetchTags();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Observer(
          builder: (_) {
            return ViewStateWidget(
                getContent(), widget.viewModel.state, _onBackPressed);
          },
        ),
        onWillPop: _onBackPressed);
  }

  Widget getContent() {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.viewModel.leagues?.length,
              itemBuilder: (context, index) {
                return CardWidget(
                    widget.viewModel.leagues?[index]?.name,
                    widget.viewModel.leagues?[index]?.emblem,
                    widget.viewModel.tags,
                    widget.viewModel.leagues?[index]?.tags, () {
                  widget.viewModel.id = widget.viewModel.leagues?[index]?.id;
                  widget.viewModel.setFlow(LeagueFlow.edit);
                });
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            widget.viewModel.setFlow(LeagueFlow.create);
          },
          child: const Icon(Icons.add),
        ));
  }

  Future<bool> _onBackPressed() async {
    widget.viewModel.setFlow(LeagueFlow.list);
    return false;
  }
}
