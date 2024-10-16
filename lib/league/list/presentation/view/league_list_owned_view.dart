import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/ui/component/ui/spacing_widget.dart';
import '../league_list_view_model.dart';

class LeagueListOwnedView extends StatefulWidget {
  final LeagueListViewModel viewModel;

  const LeagueListOwnedView(this.viewModel, {super.key});

  @override
  LeagueListOwnedViewState createState() => LeagueListOwnedViewState();
}

class LeagueListOwnedViewState extends State<LeagueListOwnedView>
    implements BaseSateWidget {
  @override
  void initState() {
    widget.viewModel.getOwnedLeagues();
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
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 0),
      child: Column(
        children: [const SpacingWidget(LayoutSize.size32), leagueWidget()],
      ),
    );
  }

  Widget leagueWidget() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.viewModel.leagues?.length,
      itemBuilder: (context, index) {
        return CardWidget(
          arrowed: true,
          ready: true,
          onPressed: () {
            var id = widget.viewModel.leagues?[index]?.id;
            widget.viewModel.toEventCreation(id);
          },
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: TextWidget(
              text: widget.viewModel.leagues?[index]?.name,
              style: Style.subtitle,
            ),
          ),
        );
      },
    );
  }
}
