import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/banner_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_progress_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/expanded_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/float_action_button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/scoring_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/settings_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/subscription_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/teams_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/presentation/ui/event_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

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
  final List<ReactionDisposer> _disposers = [];

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
            const BoundWidget(BoundType.size2),
            banner(),
            const BoundWidget(BoundType.size2),
            title(),
            const BoundWidget(BoundType.size2),
            status(),
            const BoundWidget(BoundType.size2),
            information(),
            const BoundWidget(BoundType.size2),
            subscription(),
            const BoundWidget(BoundType.size2),
            teams()
          ],
        ),
        FloatActionButtonWidget<EventFlows>(
          flow: EventFlows.create,
          icon: Icons.build,
          onPressed: (flow) {
            widget.viewModel.setFlow(flow);
          },
        ),
      ],
    );
  }

  Widget banner() {
    return BannerWidget(
      media: widget.viewModel.media,
    );
  }

  Widget title() {
    return CardWidget(
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextWidget(
                text: widget.viewModel.event?.title, style: Style.title),
          )),
      ready: true,
    );
  }

  Widget status() {
    return EventProgressWidget(
      state: widget.viewModel.event?.state,
    );
  }

  Widget information() {
    return ExpandedWidget(
        header: Row(
          children: const [
            TextWidget(
              text: "Informations",
              style: Style.subtitle,
              align: TextAlign.left,
            ),
          ],
        ),
        body: [
          rules(),
          const BoundWidget(BoundType.size2),
          scoring(),
          const BoundWidget(BoundType.size2),
          settings(),
          const BoundWidget(BoundType.size2),
        ],
        ready: true);
  }

  Widget rules() {
    return ExpandedWidget(
      cardless: true,
      ready: widget.viewModel.event != null,
      header: Row(
        children: const [
          Icon(Icons.gavel),
          BoundWidget(BoundType.size16),
          TextWidget(
            text: "Rules",
            style: Style.subtitle,
            align: TextAlign.left,
          ),
        ],
      ),
      body: [
        const BoundWidget(BoundType.size16),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextWidget(
            text: widget.viewModel.event?.rules ?? '',
            style: Style.description,
            align: TextAlign.start,
          ),
        ),
        const BoundWidget(BoundType.size16),
      ],
    );
  }

  Widget scoring() {
    return ExpandedWidget(
      cardless: true,
      ready: widget.viewModel.event != null,
      header: Row(
        children: const [
          Icon(
            Icons.format_list_numbered_outlined,
          ),
          BoundWidget(BoundType.size16),
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
        const BoundWidget(BoundType.size16),
      ],
    );
  }

  Widget settings() {
    return ExpandedWidget(
      cardless: true,
      ready: widget.viewModel.event != null,
      header: Row(
        children: const [
          Icon(
            Icons.settings,
          ),
          BoundWidget(BoundType.size16),
          TextWidget(
            text: "Settings",
            style: Style.subtitle,
            align: TextAlign.left,
          ),
        ],
      ),
      body: [
        const BoundWidget(BoundType.size16),
        SettingsWidget(settings: widget.viewModel.event?.settings),
        const BoundWidget(BoundType.size16),
      ],
    );
  }

  Widget teams() {
    var teams = widget.viewModel.event?.teamsEnabled ?? false;
    return teams
        ? ExpandedWidget(
            ready: widget.viewModel.event != null,
            header: Row(
              children: const [
                TextWidget(
                  text: "Teams",
                  style: Style.subtitle,
                  align: TextAlign.left,
                ),
              ],
            ),
            body: [
              const BoundWidget(BoundType.size16),
              TeamsWidget(
                teams: widget.viewModel.event?.teams,
                maxCrew: widget.viewModel.event?.teamsMaxCrew,
                onLeave: (id) {
                  widget.viewModel.leaveTeam(id);
                  Navigator.of(context).pop();
                },
                onJoin: (id) {
                  widget.viewModel.joinTeam(id);
                  Navigator.of(context).pop();
                },
                onDelete: (id){
                  widget.viewModel.deleteTeam(id);
                  Navigator.of(context).pop();
                },
              ),
              Padding(
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
              ),
              const BoundWidget(BoundType.size16),
            ],
          )
        : Container();
  }

  Widget subscription() {
    return SubscriptionWidget(
      classes: widget.viewModel.event?.classes,
      onSubscribe: (id) {
        widget.viewModel.subscribe(id);
      },
      onUnsubscribe: (id) {
        widget.viewModel.unsubscribe(id);
      },
    );
  }
}
