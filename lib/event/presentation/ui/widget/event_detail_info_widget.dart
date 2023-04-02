import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/icon_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/ext/access_extension.dart';
import '../../../../core/ui/component/ui/button_widget.dart';
import '../../../../core/ui/component/ui/scoring_widget.dart';
import '../../../../core/ui/component/ui/settings_widget.dart';
import '../../../../core/ui/component/ui/spacing_widget.dart';
import '../../../../core/ui/component/ui/teams_widget.dart';
import '../../../event_view_model.dart';
import '../event_flow.dart';

class EventDetailInfoWidget extends StatefulWidget {
  final EventViewModel viewModel;

  const EventDetailInfoWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventDetailInfoWidgetState createState() => _EventDetailInfoWidgetState();
}

class _EventDetailInfoWidgetState extends State<EventDetailInfoWidget>
    implements BaseSateWidget {
  @override
  void initState() {
    super.initState();
    widget.viewModel.state = ViewState.ready;
  }

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
        body: content(),
        scrollable: true,
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  Widget content() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [rules(), settings(), teams(), scoring()],
        ),
      ),
    );
  }

  Widget rules() {
    return (widget.viewModel.event?.rules?.isNotEmpty ?? false)
        ? CardWidget(
            ready: true,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      IconWidget(icon: Icons.sports),
                      SpacingWidget(LayoutSize.size8),
                      TextWidget(
                          text: "Rules",
                          style: Style.title,
                          align: TextAlign.justify),
                    ],
                  ),
                  const SpacingWidget(LayoutSize.size16),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextWidget(
                      text: widget.viewModel.event?.rules ?? '',
                      style: Style.paragraph,
                      align: TextAlign.justify,
                    ),
                  ),
                  const SpacingWidget(LayoutSize.size16),
                ],
              ),
            ),
          )
        : Container();
  }

  Widget teams() {
    var teams = widget.viewModel.event?.teamsEnabled ?? false;
    return teams
        ? CardWidget(
            ready: true,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      IconWidget(icon: Icons.group),
                      SpacingWidget(LayoutSize.size8),
                      TextWidget(
                          text: "Teams",
                          style: Style.title,
                          align: TextAlign.start),
                    ],
                  ),
                  const SpacingWidget(LayoutSize.size16),
                  TeamsWidget(
                    users: widget.viewModel.users,
                    teams: widget.viewModel.event?.teams,
                    maxCrew: widget.viewModel.event?.teamsMaxCrew,
                    classes: widget.viewModel.event?.classes,
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
                              label: "Create new team",
                              type: ButtonType.primary,
                              labelColor:
                                  Theme.of(context).colorScheme.onPrimary,
                              icon: Icons.add,
                              onPressed: () {
                                widget.viewModel.setFlow(EventFlow.createTeam);
                              },
                              enabled: widget.viewModel.event != null,
                            ),
                          ),
                        )
                      : Container(),
                  const SpacingWidget(LayoutSize.size16),
                ],
              ),
            ),
          )
        : Container();
  }

  Widget scoring() {
    return CardWidget(
      ready: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                IconWidget(
                  icon: Icons.format_list_numbered,
                ),
                SpacingWidget(LayoutSize.size8),
                TextWidget(
                    text: "Score system",
                    style: Style.title,
                    align: TextAlign.start),
              ],
            ),
            const SpacingWidget(LayoutSize.size16),
            ScoringWidget(
              scoring: widget.viewModel.event?.scoring,
              editing: false,
              onScore: (wow) {},
            ),
            const SpacingWidget(LayoutSize.size16),
          ],
        ),
      ),
    );
  }

  Widget settings() {
    var hasSettings = widget.viewModel.event?.settings?.isNotEmpty ?? false;
    return hasSettings
        ? CardWidget(
            ready: true,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      IconWidget(icon: Icons.tune),
                      SpacingWidget(LayoutSize.size8),
                      TextWidget(
                          text: "Settings",
                          style: Style.title,
                          align: TextAlign.start),
                    ],
                  ),
                  const SpacingWidget(LayoutSize.size16),
                  SettingsWidget(settings: widget.viewModel.event?.settings),
                ],
              ),
            ),
          )
        : Container();
  }

  @override
  observers() {}

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.setFlow(EventFlow.eventDetail);
    return false;
  }
}
