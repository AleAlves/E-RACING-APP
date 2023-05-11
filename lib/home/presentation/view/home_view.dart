import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/profile_card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/event_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/ui/component/state/loading_shimmer.dart';
import '../../../core/ui/component/ui/league_card_small_widget.dart';
import '../../../core/ui/component/ui/menu_card_widget.dart';
import '../../../league/LeagueRouter.dart';
import '../home_view_model.dart';

class HomeView extends StatefulWidget {
  final HomeViewModel viewModel;

  const HomeView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> implements BaseSateWidget {
  @override
  void initState() {
    observers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  observers() {
    widget.viewModel.getProfile();
    widget.viewModel.getPlayerLeagues();
    widget.viewModel.getNotificationsCount();
  }

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
        body: content(),
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Widget content() {
    return Column(
      children: [
        const SpacingWidget(LayoutSize.size24),
        profileWidget(),
        discoverWidget(),
        communitiesWidget()
      ],
    );
  }

  Widget profileWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: ProfileCardWidget(
        onPressed: () {
          widget.viewModel.goToProfile();
        },
        viewModel: widget.viewModel,
      ),
    );
  }

  Widget discoverWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: TextWidget(text: "Discover", style: Style.title),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: MenuCardWidget(
              icon: Icons.emoji_events_sharp,
              title: "Community",
              subtitle: "Join a group and start racing",
              onPressed: () {
                Modular.to.pushNamed(LeagueRouter.list);
              }),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: MenuCardWidget(
                icon: Icons.sports_score_sharp,
                title: "Racing events",
                subtitle: "Find the ideal racing activities for you",
                onPressed: () {
                  Modular.to.pushNamed(EventRouter.search);
                })),
      ],
    );
  }

  Widget communitiesWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.viewModel.leagues.isEmpty
            ? const LoadingShimmer()
            : const Padding(
                padding: EdgeInsets.all(16),
                child:
                    TextWidget(text: "Your communities", style: Style.subtitle),
              ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
          child: LeagueCardSmallWidget(
              leagues: widget.viewModel.leagues,
              onPressed: (leagueId) {
                widget.viewModel.goToLeague(leagueId);
              }),
        ),
      ],
    );
  }

  @override
  Future<bool> onBackPressed() async {
    return false;
  }
}
