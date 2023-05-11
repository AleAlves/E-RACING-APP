import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/league_member_card_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../league_member_view_model.dart';

class LeagueMembersView extends StatefulWidget {
  final LeagueMemberViewModel viewModel;

  const LeagueMembersView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueMembersViewState createState() => _LeagueMembersViewState();
}

class _LeagueMembersViewState extends State<LeagueMembersView>
    implements BaseSateWidget {
  @override
  void initState() {
    widget.viewModel.fetchMembers();
    widget.viewModel.title = "Members";
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
        body: content(),
        scrollable: true,
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Future<bool> onBackPressed() async {
    Modular.to.pop();
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
              return LeagueMemberCardWidget(
                member: widget.viewModel.members?[index],
                isHost: true,
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
