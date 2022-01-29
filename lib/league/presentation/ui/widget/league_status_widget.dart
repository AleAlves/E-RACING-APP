import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../league_view_model.dart';
import '../league_flow.dart';

class LeagueStatusWidget extends StatefulWidget {
  final LeagueViewModel viewModel;

  const LeagueStatusWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueStatusWidgetState createState() => _LeagueStatusWidgetState();
}

class _LeagueStatusWidgetState extends State<LeagueStatusWidget>
    implements BaseSateWidget {
  @override
  void initState() {
    super.initState();
    widget.viewModel.state = ViewState.ready;
  }

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
        content: content(),
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Widget content() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget(
              text: widget.viewModel.status?.message ?? '',
              style: Style.description),
          const BoundWidget(BoundType.medium),
          ButtonWidget(
            enabled: true,
            type: ButtonType.normal,
            onPressed: () {
              widget.viewModel.setFlow(widget.viewModel.status?.next);
            },
            label: widget.viewModel.status?.action ?? '',
          )
        ],
      ),
    );
  }

  @override
  observers() {}

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.setFlow(LeagueFlow.list);
    return false;
  }
}
