import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/event_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/tools/session.dart';
import '../../../core/ui/component/state/loading_shimmer.dart';
import '../../../core/ui/component/ui/button_widget.dart';
import '../../../core/ui/component/ui/league_card_small_widget.dart';
import '../../../core/ui/component/ui/menu_card_widget.dart';
import '../../../core/ui/component/ui/profile_card_widget.dart';
import '../../../league/LeagueRouter.dart';
import '../home_view_model.dart';

class HomeView extends StatefulWidget {
  final HomeViewModel viewModel;

  const HomeView(this.viewModel, {super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> implements BaseSateWidget {
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
        const SpacingWidget(LayoutSize.size48),
        profileWidget(),
        communities(),
        managerWidget(),
        discoverWidget(),
        const SpacingWidget(LayoutSize.size16)
      ],
    );
  }

  Widget notifications() {
    return Stack(
      children: [
        ButtonWidget(
            enabled: true,
            icon: Icons.notifications_none,
            iconColor: Theme.of(context).colorScheme.onSurface,
            type: ButtonType.iconShapeless,
            onPressed: () {
              widget.viewModel.goToPushNotifications();
            }),
        widget.viewModel.notificationsCount == null ||
                widget.viewModel.notificationsCount == "0"
            ? Container()
            : Positioned(
                left: -5,
                top: 2,
                child: Row(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                      child: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: TextWidget(
                            text: widget.viewModel.notificationsCount,
                            style: Style.paragraph,
                            color: Theme.of(context).colorScheme.onSecondary,
                            weight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }

  Widget profileWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ProfileCardWidget(
            onPressed: () {
              widget.viewModel.goToProfile();
            },
            viewModel: widget.viewModel,
          ),
          notifications()
        ],
      ),
    );
  }

  Widget managerWidget() {
    return Session.instance.getUser()?.signature?.level?.isManager == true
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: TextWidget(text: "Management", style: Style.title),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Column(
                  children: [
                    MenuCardWidget(
                        icon: Icons.groups,
                        title: "Create a community",
                        subtitle: "",
                        onPressed: () {
                          Modular.to.pushNamed(LeagueRouter.create);
                        }),
                    MenuCardWidget(
                        icon: Icons.settings_suggest,
                        title: "Create an event",
                        subtitle: "",
                        onPressed: () {
                          Modular.to.pushNamed(LeagueRouter.owned);
                        })
                  ],
                ),
              ),
            ],
          )
        : Container();
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
              icon: Icons.group_sharp,
              title: "Community",
              subtitle: "Join a group and start racing",
              onPressed: () {
                Modular.to.pushNamed(LeagueRouter.list);
              }),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: MenuCardWidget(
                icon: Icons.emoji_events_sharp,
                title: "Racing events",
                subtitle: "Find the ideal racing activities for you",
                onPressed: () {
                  Modular.to.pushNamed(EventRouter.search);
                })),
      ],
    );
  }

  Widget communities() {
    return widget.viewModel.communities == null
        ? communitiesSkeleton()
        : communitiesWidget();
  }

  Widget communitiesSkeleton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoadingShimmer(
            height: MediaQuery.of(context).size.height * 0.03,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          LoadingShimmer(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          LoadingShimmer(
            height: MediaQuery.of(context).size.height * 0.1,
          )
        ],
      ),
    );
  }

  Widget communitiesWidget() {
    return widget.viewModel.communities?.isEmpty == true
        ? communitiesEmpty()
        : communitiesContent();
  }

  Widget communitiesEmpty() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SpacingWidget(LayoutSize.size48),
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              children: const [
                TextWidget(
                    text: "You're not member of any community yet",
                    style: Style.subtitle),
              ],
            ),
          ),
          const SpacingWidget(LayoutSize.size16),
          ButtonWidget(
              enabled: true,
              type: ButtonType.link,
              label: "Start searching",
              onPressed: () {
                Modular.to.pushNamed(LeagueRouter.list);
              })
        ],
      ),
    );
  }

  Widget communitiesContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextWidget(text: "Your communities", style: Style.title),
        ),
        LeagueCardSmallWidget(
            leagues: widget.viewModel.communities,
            onPressed: (leagueId) {
              widget.viewModel.goToLeague(leagueId);
            })
      ],
    );
  }

  @override
  Future<bool> onBackPressed() async {
    return false;
  }
}
