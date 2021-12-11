import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../league_view_model.dart';
import '../ui/league_flow.dart';

class LeagueStatusWidget extends StatefulWidget {
  final LeagueViewModel viewModel;

  const LeagueStatusWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueStatusWidgetState createState() => _LeagueStatusWidgetState();
}

class _LeagueStatusWidgetState extends State<LeagueStatusWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            content(),
            Observer(builder: (_) {
              return Container();
            }),
          ],
        ),
        onWillPop: _onBackPressed);
  }

  Widget content() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget(widget.viewModel.status?.message ?? '', Style.description),
          const BoundWidget(BoundType.medium),
          ButtonWidget(widget.viewModel.status?.action ?? '', ButtonType.normal,
              () {
            widget.viewModel.flow = LeagueFlow.list;
          })
        ],
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    widget.viewModel.flow = LeagueFlow.list;
    return false;
  }
}
