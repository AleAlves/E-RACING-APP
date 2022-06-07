import 'package:e_racing_app/core/ext/access_extension.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/banner_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_race_collection_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/simple_standings_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_progress_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/subscription_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/presentation/ui/event_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
        content: content(),
        scrollable: true,
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
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
            const SpacingWidget(LayoutSize.size2),
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
            const SpacingWidget(LayoutSize.size2),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: adminPanel(),
            ),
            const SpacingWidget(LayoutSize.size8),
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
          BannerWidget(
            media: widget.viewModel.media,
          ),
          title(),
          status(),
          const SpacingWidget(LayoutSize.size16),
          subscription(),
          const SpacingWidget(LayoutSize.size8),
        ],
      ),
    );
  }

  Widget title() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: TextWidget(
              text: widget.viewModel.event?.title, style: Style.title),
        ));
  }

  Widget eventInfo() {
    return CardWidget(
      onPressed: () {
        widget.viewModel.setFlow(EventFlow.eventDetailInfo);
      },
      ready: true,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: TextWidget(
                          text: "Event information",
                          style: Style.title,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Icon(Icons.chevron_right)
            ],
          ),
        ],
      ),
    );
  }

  Widget adminPanel() {
    return isEventHost(widget.viewModel.event)
        ? CardWidget(
            child: Column(
              children: [
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextWidget(
                        text: "Management",
                        style: Style.title,
                        align: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                const SpacingWidget(LayoutSize.size16),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    child: ButtonWidget(
                      label: "Manager area",
                      type: ButtonType.discret,
                      onPressed: () {
                        widget.viewModel.setFlow(EventFlow.manager);
                      },
                      enabled: true,
                    ),
                  ),
                ),
                const SpacingWidget(LayoutSize.size8),
              ],
            ),
            ready: true)
        : Container();
  }

  Widget status() {
    return EventProgressWidget(
      shapeless: true,
      event: widget.viewModel.event,
    );
  }

  Widget subscription() {
    return widget.viewModel.event?.joinable == true
        ? SubscriptionWidget(
            classes: widget.viewModel.event?.classes,
            onSubscribe: (id) {
              widget.viewModel.subscribe(id);
            },
            onUnsubscribe: (id) {
              widget.viewModel.unsubscribe(id);
            },
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
