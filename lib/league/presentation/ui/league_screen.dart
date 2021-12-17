import 'package:e_racing_app/core/ui/component/custom_brackground.dart';
import 'package:e_racing_app/core/ui/component/state/loading_ripple.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/league/presentation/league_view_model.dart';
import 'package:e_racing_app/league/presentation/widget/league_create_widget.dart';
import 'package:e_racing_app/league/presentation/widget/league_fetch_widget.dart';
import 'package:e_racing_app/league/presentation/widget/league_status_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'league_flow.dart';

class LeagueScreen extends StatefulWidget {
  const LeagueScreen({Key? key}) : super(key: key);

  @override
  _LeagueScreenState createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final LeagueViewModel viewModel = LeagueViewModel();

  @override
  void initState() {
    viewModel.fetchLeagues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: "dropdownvalue",
      icon: const Icon(Icons.keyboard_arrow_down),
      items: ['dropdownvalue', 'wow'].map((String items) {
        return DropdownMenuItem(value: items, child: Text(items));
      }).toList(),
      onChanged: (value) {
        setState(() {});
      },
    );
  }

  Widget navigation() {
    switch (viewModel.state) {
      case ViewState.loading:
        return const LoadingRipple();
      case ViewState.ready:
        switch (viewModel.flow) {
          case LeagueFlow.list:
            return LeagueListWidget(viewModel);
          case LeagueFlow.create:
            return LeagueCreateWidget(viewModel);
          case LeagueFlow.delete:
            return LeagueCreateWidget(viewModel);
          case LeagueFlow.edit:
            return LeagueCreateWidget(viewModel);
          case LeagueFlow.join:
            return LeagueCreateWidget(viewModel);
          case LeagueFlow.error:
            return LeagueCreateWidget(viewModel);
          case LeagueFlow.status:
            return LeagueStatusWidget(viewModel);
          default:
            return LeagueCreateWidget(viewModel);
        }
      case ViewState.error:
        return LeagueCreateWidget(viewModel);
      case ViewState.navigation:
        return LeagueCreateWidget(viewModel);
    }
  }
}
