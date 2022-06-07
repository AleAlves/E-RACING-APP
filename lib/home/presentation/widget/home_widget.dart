import 'package:e_racing_app/core/tools/routes.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/events_card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/league_thumb_collection_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/leagues_card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/profile_card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../home_view_model.dart';

class HomeWidget extends StatefulWidget {
  final HomeViewModel vm;

  const HomeWidget(this.vm, {Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> implements BaseSateWidget {
  @override
  void initState() {
    widget.vm.fetchProfile();
    widget.vm.fetchPlayerLeagues();
    widget.vm.fetchNotificationsCount();
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
        content: content(),
        state: widget.vm.state,
        onBackPressed: onBackPressed,
        scrollable: true);
  }

  @override
  Widget content() {
    return Column(
      children: [
        profileWidget(),
        notifications(),
        discoverWidget(),
        communitiesWidget(),
      ],
    );
  }

  Widget notifications() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: CardWidget(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16, left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                Icon(
                  Icons.notifications,
                  color: Theme.of(context).colorScheme.primary,
                ),
                  const SpacingWidget(LayoutSize.size8),
                const TextWidget(
                    text: "Notifications",
                    style: Style.title
                ),
              ],),
              widget.vm.notificationsCount == null ||
                      widget.vm.notificationsCount == "0"
                  ? const Icon(Icons.arrow_forward)
                  : Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                          child:  ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child:TextWidget(
                                text: widget.vm.notificationsCount,
                                style: Style.description,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondary,
                            weight: FontWeight.w900,),
                          ),),
                      ],
                    ),
            ],
          ),
        ),
        ready: true,
        onPressed: () {
          Modular.to.pushNamed(Routes.notifications);
        },
      ),
    );
  }

  Widget profileWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
      child: ProfileCardWidget(
        onPressed: () {
          Modular.to.pushNamed(Routes.profile);
        },
        profileModel: widget.vm.profileModel,
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
          child: TextWidget(text: "Discover", style: Style.subtitle),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: LeaguesCardWidget(onPressed: () {
            Modular.to.pushNamed(Routes.leagues);
          }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: EventsCardWidget(onPressed: () {
            Modular.to.pushNamed(Routes.leagues);
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
        const Padding(
          padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
          child: TextWidget(text: "Your communities", style: Style.subtitle),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Row(
            children: [
              LeagueThumbCollectionWidget(
                onPressed: () {
                  Modular.to.pushNamed(Routes.league);
                },
                leagues: widget.vm.leagues,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Future<bool> onBackPressed() async {
    return false;
  }
}
