import 'package:e_racing_app/core/ext/access_extension.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/float_action_button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/league_card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/league_member_card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/league/presentation/league_view_model.dart';
import 'package:e_racing_app/league/presentation/ui/league_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LeagueMembersWidget extends StatefulWidget {
  final LeagueViewModel viewModel;

  const LeagueMembersWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueMembersWidgetState createState() => _LeagueMembersWidgetState();
}

class _LeagueMembersWidgetState extends State<LeagueMembersWidget>
    implements BaseSateWidget {
  @override
  void initState() {
    widget.viewModel.fetchMembers();
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
    widget.viewModel.setFlow(LeagueFlow.detail);
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
            itemCount: widget.viewModel.members?.length,
            itemBuilder: (context, index) {
              return EventMemberCardWidget(
                member: widget.viewModel.members?[index],
                isHost: isLeagueManager(widget.viewModel.league),
                onRemove: (id) {
                    widget.viewModel.removeMember(id ?? '');
              },
              );
            },
          ),
        ),
      ],
    );
  }
}
