import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
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

class _LeagueStatusWidgetState extends State<LeagueStatusWidget> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return ViewStateWidget(
          _content(), widget.viewModel.state, _onBackPressed);
    });
  }

  Widget _content() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget(widget.viewModel.status?.message ?? '', Style.description),
          const BoundWidget(BoundType.medium),
          ButtonWidget(
            ButtonType.normal,
            () {
              widget.viewModel.setFlow(LeagueFlow.list);
            },
            label: widget.viewModel.status?.action ?? '',
          )
        ],
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    widget.viewModel.setFlow(LeagueFlow.list);
    return false;
  }
}
