import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/float_action_button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/league_card_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/league/presentation/league_view_model.dart';
import 'package:e_racing_app/league/presentation/ui/league_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/ext/access_extension.dart';

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
        onBackPressed: onBackPressed,
        floatAction: FloatActionButtonWidget<LeagueFlow>(
          flow: LeagueFlow.create,
          icon: Icons.add,
          onPressed: (flow) {
            widget.viewModel.setFlow(flow);
          },
        ));
  }

  @override
  Future<bool> onBackPressed() async {
    Modular.to.pop();
    return false;
  }

  @override
  Widget content() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.viewModel.leagues?.length,
        itemBuilder: (context, index) {
          return LeagueCardWidget(
              label: widget.viewModel.leagues?[index]?.name,
              emblem: widget.viewModel.leagues?[index]?.emblem,
              members: widget.viewModel.leagues?[index]?.members?.length,
              capacity: widget.viewModel.leagues?[index]?.capacity,
              hasMembership: isLeagueMember(widget.viewModel.leagues?[index]),
              tags: widget.viewModel.tags,
              leagueTags: widget.viewModel.leagues?[index]?.tags,
              onPressed: () {
                Session.instance
                    .setLeagueId(widget.viewModel.leagues?[index]?.id);
                widget.viewModel.setFlow(LeagueFlow.detail);
              });
        },
      ),
    );
  }
}
