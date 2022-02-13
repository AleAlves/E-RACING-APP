import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/float_action_button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/league_item_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
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

class _LeagueListWidgetState extends State<LeagueListWidget>
    implements BaseSateWidget {
  @override
  void initState() {
    widget.viewModel.fetchLeagues();
    widget.viewModel.fetchTags();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  observers() {}

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
        content: content(),
        scrollable: true,
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.setFlow(LeagueFlow.list);
    return false;
  }

  @override
  Widget content() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.viewModel.leagues?.length,
            itemBuilder: (context, index) {
              return LeagueItemWidget(
                  label: widget.viewModel.leagues?[index]?.name,
                  emblem: widget.viewModel.leagues?[index]?.emblem,
                  members: widget.viewModel.leagues?[index]?.members?.length,
                  capacity: widget.viewModel.leagues?[index]?.capacity,
                  tags: widget.viewModel.tags,
                  leagueTags: widget.viewModel.leagues?[index]?.tags,
                  onPressed: () {
                    widget.viewModel.id = widget.viewModel.leagues?[index]?.id;
                    widget.viewModel.setFlow(LeagueFlow.detail);
                  });
            },
          ),
        ),
        FloatActionButtonWidget<LeagueFlow>(
          flow: LeagueFlow.create,
          icon: Icons.add,
          onPressed: (flow) {
            widget.viewModel.setFlow(flow);
          },
        ),
      ],
    );
  }
}
