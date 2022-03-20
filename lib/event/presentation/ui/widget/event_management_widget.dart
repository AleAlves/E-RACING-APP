import 'package:e_racing_app/core/ext/dialog_extension.dart';
import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_race_results_collection_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_subscribers_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_subscriptions_panel_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_progress_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../event_view_model.dart';
import '../event_flow.dart';

class EventManagementWidget extends StatefulWidget {
  final EventViewModel viewModel;

  const EventManagementWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventManagementWidgetState createState() => _EventManagementWidgetState();
}

class _EventManagementWidgetState extends State<EventManagementWidget>
    implements BaseSateWidget {
  @override
  void initState() {
    observers();
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
        state: widget.viewModel.state,
        scrollable: true,
        onBackPressed: onBackPressed);
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.setFlow(EventFlows.eventDetail);
    return false;
  }

  @override
  Widget content() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          eventStatus(),
          eventSubscriptions(),
          editEvent(),
          racesWidget(),
          subscribers(),
          excludeEvent()
        ],
      ),
    );
  }

  Widget editEvent() {
    return CardWidget(
        child: Column(
          children: [
            Row(
              children: const [
                Icon(Icons.build),
                SpacingWidget(LayoutSize.size8),
                TextWidget(
                  text: "Edit",
                  style: Style.subtitle,
                  align: TextAlign.left,
                ),
              ],
            ),
            const SpacingWidget(LayoutSize.size16),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ButtonWidget(
                label: "Event",
                type: ButtonType.normal,
                onPressed: () {
                  widget.viewModel.setFlow(EventFlows.managementEditEvent);
                },
                enabled: widget.viewModel.event?.state == EventState.idle,
              ),
            ),
            const SpacingWidget(LayoutSize.size48),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ButtonWidget(
                label: "Races",
                type: ButtonType.normal,
                onPressed: () {
                  widget.viewModel.setFlow(EventFlows.managementEditRaceList);
                },
                enabled: widget.viewModel.event?.state == EventState.idle,
              ),
            ),
            const SpacingWidget(LayoutSize.size8),
          ],
        ),
        ready: true);
  }

  Widget eventSubscriptions() {
    return CardWidget(
      ready: true,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: EventSubscriptionsPanelWidget(
              minWidth: MediaQuery.of(context).size.width,
              event: widget.viewModel.event,
              onToogle: () {
                widget.viewModel.toogleSubscriptions();
              },
              onToogleMembership: () {
                widget.viewModel.toogleMembersOnly();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget eventStatus() {
    return CardWidget(
      ready: true,
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.sports_score),
              SpacingWidget(LayoutSize.size8),
              TextWidget(
                text: "State",
                style: Style.subtitle,
                align: TextAlign.left,
              ),
            ],
          ),
          const SpacingWidget(LayoutSize.size8),
          EventProgressWidget(
            shapeless: true,
            event: widget.viewModel.event,
          ),
          const SpacingWidget(LayoutSize.size16),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ButtonWidget(
              label: _getStatus()?.second,
              type: ButtonType.normal,
              onPressed: () {
                switch (widget.viewModel.event?.state) {
                  case EventState.idle:
                    confirmationDialogExt(
                      context: context,
                      issueMessage:
                          "Are you sure you want to start this event? you won't be able to edit the event nor the races settings",
                      consentMessage: "Yes, I do",
                      onPositive: () {
                        widget.viewModel.startEvent();
                      },
                    );
                    break;
                  case EventState.ongoing:
                    confirmationDialogExt(
                      context: context,
                      issueMessage:
                          "Are you sure you want to finish this event?",
                      consentMessage: "Yes, I do",
                      onPositive: () {
                        widget.viewModel.finishEvent();
                      },
                    );
                    break;
                  case EventState.finished:
                    break;
                  default:
                    break;
                }
              },
              enabled: _getStatus()?.first ?? false,
            ),
          ),
          const SpacingWidget(LayoutSize.size8),
        ],
      ),
    );
  }

  Widget subscribers() {
    return EventSubscribersWidget(
      onRemove: (classId, userId) {
        widget.viewModel.removeSubscription(classId, userId);
      },
      classes: widget.viewModel.event?.classes,
      users: widget.viewModel.users,
    );
  }

  Widget excludeEvent() {
    return CardWidget(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ButtonWidget(
                label: "Delete this event",
                type: ButtonType.important,
                onPressed: () {
                  confirmationDialogExt(
                      context: context,
                      onPositive: () {},
                      consentMessage: "Yes, I do",
                      issueMessage:
                          "Are you sure you want to delete this event?");
                },
                enabled: true,
              ),
            ),
            const SpacingWidget(LayoutSize.size8),
          ],
        ),
        ready: true);
  }

  Widget racesWidget() {
    return EventRaceResultsCollection(
        onRaceCardPressed: (id) {
          widget.viewModel.toRaceResults(id);
        },
        races: widget.viewModel.event?.races);
  }

  Pair<bool, String>? _getStatus() {
    switch (widget.viewModel.event?.state) {
      case EventState.idle:
        return Pair(true, "Start");
      case EventState.ongoing:
        return Pair(true, "Finish");
      case EventState.finished:
        return Pair(false, "Finished");
      default:
        return Pair(false, "unknow");
    }
  }
}
