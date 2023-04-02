import 'package:e_racing_app/core/ext/access_extension.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/banner_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_progress_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_race_collection_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/simple_standings_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/subscription_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/presentation/ui/event_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/ui/component/ui/float_action_button_widget.dart';
import '../../../../core/ui/component/ui/share_widget.dart';
import '../../../../core/ui/component/ui/status_widget.dart';
import '../../../event_view_model.dart';
import '../event_flow.dart';

class EventDetailWidget extends StatefulWidget {
  final EventViewModel viewModel;

  const EventDetailWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventDetailWidgetState createState() => _EventDetailWidgetState();
}

class _EventDetailWidgetState extends State<EventDetailWidget>
    implements BaseSateWidget {
  @override
  void initState() {
    widget.viewModel.getEvent();
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
      scrollable: true,
      state: widget.viewModel.state,
      onBackPressed: onBackPressed,
      floatAction: adminOption(),
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.setFlow(EventFlow.list);
    return false;
  }

  @override
  Widget content() {
    return Stack(
      children: [
        Column(
          children: [
            const SpacingWidget(LayoutSize.size16),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: banner(),
            ),
            const SpacingWidget(LayoutSize.size2),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: eventInfo(),
            ),
            const SpacingWidget(LayoutSize.size2),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: races(),
            ),
            const SpacingWidget(LayoutSize.size2),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: standings(),
            ),
            const SpacingWidget(LayoutSize.size48),
          ],
        ),
      ],
    );
  }

  Widget banner() {
    return CardWidget(
      padding: EdgeInsets.zero,
      ready: true,
      child: Column(
        children: [
          Stack(
            children: [
              BannerWidget(
                media: widget.viewModel.media,
              ),
              Positioned(
                top: 0,
                right: 0,
                child: ShareWidget(
                    size: 16.0,
                    background: Theme.of(context).colorScheme.secondary,
                    color: Theme.of(context).colorScheme.onSecondary,
                    model: widget.viewModel.share),
              )
            ],
          ),
          const SpacingWidget(LayoutSize.size8),
          title(),
          const SpacingWidget(LayoutSize.size16),
          subscription(),
        ],
      ),
    );
  }

  Widget title() {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextWidget(
              text: widget.viewModel.event?.title, style: Style.title),
        ),
      ],
    );
  }

  Widget eventInfo() {
    return CardWidget(
      arrowed: true,
      childLeft: Icon(
        Icons.info_outline,
        color: Theme.of(context).colorScheme.onBackground,
      ),
      onPressed: () {
        widget.viewModel.setFlow(EventFlow.eventDetailInfo);
      },
      ready: true,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SpacingWidget(LayoutSize.size8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextWidget(
                      text: "Event",
                      style: Style.subtitle,
                    ),
                    StatusWidget(
                      state: widget.viewModel.event?.state,
                      orientation: StatusOrientation.horizontal,
                    ),
                    Container()
                  ],
                ),
                const SpacingWidget(LayoutSize.size8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  FloatActionButtonWidget? adminOption() {
    return isEventHost(widget.viewModel.event)
        ? FloatActionButtonWidget(
            icon: Icons.manage_accounts,
            title: "Manage",
            onPressed: () {
              widget.viewModel.setFlow(EventFlow.manager);
            },
          )
        : null;
  }

  Widget status() {
    return EventProgressWidget(
      shapeless: true,
      event: widget.viewModel.event,
    );
  }

  Widget subscription() {
    return widget.viewModel.event?.joinable == true
        ? Column(
            children: [
              SubscriptionWidget(
                classes: widget.viewModel.event?.classes,
                onSubscribe: (id) {
                  widget.viewModel.subscribe(id);
                },
                onUnsubscribe: (id) {
                  widget.viewModel.unsubscribe(id);
                },
              ),
              const SpacingWidget(LayoutSize.size16),
            ],
          )
        : Container();
  }

  Widget races() {
    return EventRaceCollection(
        onRaceCardPressed: (id) {
          widget.viewModel.toRaceDetail(id);
        },
        races: widget.viewModel.event?.races);
  }

  Widget standings() {
    return SimpleStandingsWidget(
      standings: widget.viewModel.standings,
      onRaceCardPressed: (id) {},
      onFullStandingsPressed: () {
        widget.viewModel.setFlow(EventFlow.fullStandings);
      },
    );
  }
}
