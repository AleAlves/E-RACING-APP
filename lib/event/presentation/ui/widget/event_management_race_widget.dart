import 'package:e_racing_app/core/ext/dialog_extension.dart';
import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_progress_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_race_results_collection_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_subscribers_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_subscriptions_panel_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/icon_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/ui/component/ui/float_action_button_widget.dart';
import '../../../event_view_model.dart';
import '../event_flow.dart';

class EventManagementRaceWidget extends StatefulWidget {
  final EventViewModel viewModel;

  const EventManagementRaceWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventManagementRaceWidgetState createState() =>
      _EventManagementRaceWidgetState();
}

class _EventManagementRaceWidgetState extends State<EventManagementRaceWidget>
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
      onBackPressed: onBackPressed,
      floatAction: FloatActionButtonWidget<EventFlow>(
        flow: EventFlow.delete,
        icon: Icons.delete_forever,
        title: "Delete",
        onPressed: (flow) {
          confirmationDialogExt(
              context: context,
              onPositive: () {},
              consentMessage: "Yes, I do",
              issueMessage: "Do you want to delete this event?");
        },
      ),
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.setFlow(EventFlow.eventDetail);
    return false;
  }

  @override
  Widget content() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SpacingWidget(LayoutSize.size8),
          eventStatus(),
          eventSubscriptions(),
          editEvent(),
          racesWidget(),
          subscribers(),
          const SpacingWidget(LayoutSize.size48)
        ],
      ),
    );
  }

  Widget editEvent() {
    return CardWidget(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: const [
                  IconWidget(icon: Icons.build),
                  SpacingWidget(LayoutSize.size8),
                  TextWidget(
                    text: "Edit",
                    style: Style.title,
                    align: TextAlign.left,
                  ),
                ],
              ),
              const SpacingWidget(LayoutSize.size16),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonWidget(
                    label: "Event",
                    type: ButtonType.primary,
                    onPressed: () {
                      widget.viewModel.setFlow(EventFlow.managementEditEvent);
                    },
                    enabled: widget.viewModel.event?.state == EventState.idle,
                  ),
                ),
              ),
              const SpacingWidget(LayoutSize.size16),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonWidget(
                    label: "Races",
                    type: ButtonType.primary,
                    onPressed: () {
                      widget.viewModel
                          .setFlow(EventFlow.managementEditRaceList);
                    },
                    enabled: widget.viewModel.event?.state == EventState.idle,
                  ),
                ),
              ),
              const SpacingWidget(LayoutSize.size8),
            ],
          ),
        ),
        ready: true);
  }

  Widget eventSubscriptions() {
    return CardWidget(
      ready: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
      ),
    );
  }

  Widget eventStatus() {
    return CardWidget(
      ready: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: const [
                IconWidget(icon: Icons.sports_score),
                SpacingWidget(LayoutSize.size8),
                TextWidget(
                  text: "State",
                  style: Style.title,
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
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ButtonWidget(
                  label: _getStatus()?.second,
                  type: ButtonType.primary,
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
            ),
            const SpacingWidget(LayoutSize.size8),
          ],
        ),
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
