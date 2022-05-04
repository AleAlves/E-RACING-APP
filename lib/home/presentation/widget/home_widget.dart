import 'package:e_racing_app/core/tools/routes.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/events_card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/league_thumb_collection_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/leagues_card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/profile_card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/cupertino.dart';
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
        discoverWidget(),
        activitiesWidget()
      ],
    );
  }

  Widget profileWidget(){
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

  Widget discoverWidget(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: TextWidget(
              text: "Discover",
              style: Style.subtitle
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: LeaguesCardWidget(onPressed: (){
            Modular.to.pushNamed(Routes.leagues);
          }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: EventsCardWidget(onPressed: (){
            Modular.to.pushNamed(Routes.leagues);
          }),
        ),
      ],
    );
  }

  Widget activitiesWidget(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: TextWidget(
              text: "Your places",
              style: Style.subtitle
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: CardWidget(
            ready: true,
              child: LeagueThumbCollectionWidget(leagues: widget.vm.leagues,)),
        )
      ],
    );
  }

  @override
  Future<bool> onBackPressed() async {
    Modular.to.pop();
    return false;
  }
}
