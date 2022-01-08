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
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return ViewStateWidget(
          content: content(),
          state: widget.viewModel.state,
          onBackPressed: _onBackPressed);
    });
  }

  Future<bool> _onBackPressed() async {
    widget.viewModel.setFlow(LeagueFlow.list);
    return false;
  }

  @override
  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextWidget(widget.viewModel.status?.message ?? '', Style.description),
        const BoundWidget(BoundType.medium),
        ButtonWidget(
          type: ButtonType.normal,
          onPressed: () {
            widget.viewModel.setFlow(LeagueFlow.list);
          },
          label: widget.viewModel.status?.action ?? '',
        )
      ],
    );
  }
}
