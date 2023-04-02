import 'package:e_racing_app/core/tools/routes.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/events_card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/leagues_card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/profile_card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/tools/session.dart';
import '../../../core/ui/component/state/loading_shimmer.dart';
import '../../../core/ui/component/ui/icon_widget.dart';
import '../../../core/ui/component/ui/league_card_small_widget.dart';
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
              widget.vm.notificationsCount == null ||
                      widget.vm.notificationsCount == "0"
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
                                text: widget.vm.notificationsCount,
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
          Modular.to.pushNamed(Routes.notifications);
        },
      ),
    );
  }

  Widget profileWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
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
          child: TextWidget(text: "Start racing", style: Style.subtitle),
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
            Modular.to.pushNamed(Routes.eventFilter);
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
        widget.vm.leagues == null
            ? const LoadingShimmer()
            : const Padding(
                padding: EdgeInsets.all(16),
                child:
                    TextWidget(text: "Your communities", style: Style.subtitle),
              ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.vm.leagues?.length,
            itemBuilder: (context, index) {
              return LeagueCardSmallWidget(
                  label: widget.vm.leagues?[index]?.name,
                  emblem: widget.vm.leagues?[index]?.banner,
                  onPressed: () {
                    Session.instance.setLeagueId(widget.vm.leagues?[index]?.id);
                    Modular.to.pushNamed(Routes.league);
                  });
            },
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
