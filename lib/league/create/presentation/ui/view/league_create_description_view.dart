import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/ui/component/state/view_state_widget.dart';
import '../../../../../core/ui/view_state.dart';
import '../../league_create_view_model.dart';

class LeagueCreateNameView extends StatefulWidget {
  final LeagueCreateViewModel viewModel;

  const LeagueCreateNameView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LeagueCreateNameViewState createState() => _LeagueCreateNameViewState();
}

class _LeagueCreateNameViewState extends State<LeagueCreateNameView>
    implements BaseSateWidget {
  var isSwitched = false;

  @override
  void initState() {
    observers();
    super.initState();
    widget.viewModel.fetchTerms();
  }

  @override
  Widget build(BuildContext context) {
    return mainObserver();
  }

  @override
  Observer mainObserver() {
    return Observer(builder: (_) => viewState());
  }

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
      body: content(),
      scrollable: true,
      onBackPressed: onBackPressed,
      state: ViewState.ready,
    );
  }

  @override
  Widget content() {
    return Container();
  }

  @override
  observers() {}

  @override
  Future<bool> onBackPressed() async {
    Modular.to.pop();
    return false;
  }
}
