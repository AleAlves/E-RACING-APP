import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/events_card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/leagues_card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/profile_card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/event_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/ui/component/state/loading_shimmer.dart';
import '../../../core/ui/component/ui/icon_widget.dart';
import '../../../core/ui/component/ui/league_card_small_widget.dart';
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
        profileWidget(),
        notifications(),
        discoverWidget(),
        communitiesWidget()
      ],
    );
  }

  Widget notifications() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: CardWidget(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 16, bottom: 16, left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconWidget(
                    icon: Icons.notifications,
                    borderless: true,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SpacingWidget(LayoutSize.size8),
                  const TextWidget(text: "Notifications", style: Style.title),
                ],
              ),
              widget.viewModel.notificationsCount == null ||
                      widget.viewModel.notificationsCount == "0"
                  ? const IconWidget(
                      icon: Icons.chevron_right,
                      borderless: false,
                    )
                  : Row(
                      children: [
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: TextWidget(
                                text: widget.viewModel.notificationsCount,
                                style: Style.paragraph,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                weight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
        ready: true,
        onPressed: () {
          widget.viewModel.goToPushNotifications();
        },
      ),
    );
  }

  Widget profileWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: ProfileCardWidget(
        onPressed: () {
          widget.viewModel.goToProfile();
        },
        profileModel: widget.viewModel.profileModel,
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
          child: TextWidget(text: "Start racing", style: Style.subtitle),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: LeaguesCardWidget(onPressed: () {
            Modular.to.pushNamed(LeagueRouter.list);
          }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: EventsCardWidget(onPressed: () {
            Modular.to.pushNamed(EventRouter.search);
          }),
        ),
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
