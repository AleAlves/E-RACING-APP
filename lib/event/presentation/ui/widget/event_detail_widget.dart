import 'package:e_racing_app/core/ext/access_extension.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/banner_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_race_collection_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/simple_standings_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_progress_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/expanded_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/scoring_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/settings_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/subscription_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/teams_widget.dart';
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
    widget.viewModel.setFlow(EventFlows.list);
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
              child: adminPanel(),
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
          information()
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

  Widget adminPanel() {
    return isEventHost(widget.viewModel.event)
        ? CardWidget(
            child: Column(
              children: [
                Row(
                  children: const [
                    Icon(Icons.manage_accounts),
                    SpacingWidget(LayoutSize.size8),
                    TextWidget(
                      text: "Management",
                      style: Style.subtitle,
                      align: TextAlign.left,
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
                      type: ButtonType.normal,
                      onPressed: () {
                        widget.viewModel.setFlow(EventFlows.manager);
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

  Widget information() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: ExpandedWidget(
          shapeless: true,
          expandIcon: Icons.visibility_outlined,
          collapseIcon: Icons.visibility_off_outlined,
          iniExpanded: !isSubscriber(widget.viewModel.event?.classes),
          header: Row(
            children: const [
              TextWidget(
                text: "Event",
                style: Style.title,
                align: TextAlign.left,
              ),
            ],
          ),
          body: [
            subscription(),
            const SpacingWidget(LayoutSize.size2),
            teams(),
            const SpacingWidget(LayoutSize.size2),
            rules(),
            const SpacingWidget(LayoutSize.size2),
            scoring(),
            const SpacingWidget(LayoutSize.size2),
            settings(),
            const SpacingWidget(LayoutSize.size2),
          ],
          ready: true),
    );
  }

  Widget rules() {
    return (widget.viewModel.event?.rules?.isNotEmpty ?? false)
        ? ExpandedWidget(
            shapeless: true,
            ready: widget.viewModel.event != null,
            header: Row(
              children: const [
                Icon(Icons.gavel),
                SpacingWidget(LayoutSize.size16),
                TextWidget(
                  text: "Rules",
                  style: Style.subtitle,
                  align: TextAlign.left,
                ),
              ],
            ),
            body: [
              const SpacingWidget(LayoutSize.size16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextWidget(
                  text: widget.viewModel.event?.rules ?? '',
                  style: Style.description,
                  align: TextAlign.start,
                ),
              ),
              const SpacingWidget(LayoutSize.size16),
            ],
          )
        : Container();
  }

  Widget scoring() {
    return ExpandedWidget(
      shapeless: true,
      ready: widget.viewModel.event != null,
      header: Row(
        children: const [
          Icon(
            Icons.format_list_numbered_outlined,
          ),
          SpacingWidget(LayoutSize.size16),
          TextWidget(
            text: "Score system",
            style: Style.subtitle,
            align: TextAlign.left,
          ),
        ],
      ),
      body: [
        ScoringWidget(
          scoring: widget.viewModel.event?.scoring,
          editing: false,
          onScore: (wow) {},
        ),
        const SpacingWidget(LayoutSize.size16),
      ],
    );
  }

  Widget settings() {
    var hasSettings = widget.viewModel.event?.settings?.isNotEmpty ?? false;
    return hasSettings
        ? ExpandedWidget(
            shapeless: true,
            ready: widget.viewModel.event != null,
            header: Row(
              children: const [
                Icon(
                  Icons.settings,
                ),
                SpacingWidget(LayoutSize.size16),
                TextWidget(
                  text: "Settings",
                  style: Style.subtitle,
                  align: TextAlign.left,
                ),
              ],
            ),
            body: [
              const SpacingWidget(LayoutSize.size16),
              SettingsWidget(settings: widget.viewModel.event?.settings),
              const SpacingWidget(LayoutSize.size16),
            ],
          )
        : Container();
  }

  Widget teams() {
    var teams = widget.viewModel.event?.teamsEnabled ?? false;
    return teams
        ? ExpandedWidget(
            shapeless: true,
            ready: widget.viewModel.event != null,
            header: Row(
              children: const [
                Icon(Icons.group),
                SpacingWidget(LayoutSize.size16),
                TextWidget(
                  text: "Teams",
                  style: Style.subtitle,
                  align: TextAlign.left,
                ),
              ],
            ),
            body: [
              const SpacingWidget(LayoutSize.size16),
              TeamsWidget(
                users: widget.viewModel.users,
                teams: widget.viewModel.event?.teams,
                maxCrew: widget.viewModel.event?.teamsMaxCrew,
                isSubscriber: isSubscriber(widget.viewModel.event?.classes),
                onLeave: (id) {
                  widget.viewModel.leaveTeam(id);
                  Navigator.of(context).pop();
                },
                onJoin: (id) {
                  widget.viewModel.joinTeam(id);
                  Navigator.of(context).pop();
                },
                onDelete: (id) {
                  widget.viewModel.deleteTeam(id);
                  Navigator.of(context).pop();
                },
              ),
              isSubscriberOrHost(widget.viewModel.event)
                  ? Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ButtonWidget(
                          label: "New team",
                          type: ButtonType.icon,
                          icon: Icons.add,
                          onPressed: () {
                            widget.viewModel.setFlow(EventFlows.createTeam);
                          },
                          enabled: widget.viewModel.event != null,
                        ),
                      ),
                    )
                  : Container(),
              const SpacingWidget(LayoutSize.size16),
            ],
          )
        : Container();
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
        widget.viewModel.setFlow(EventFlows.fullStandings);
      },
    );
  }
}
