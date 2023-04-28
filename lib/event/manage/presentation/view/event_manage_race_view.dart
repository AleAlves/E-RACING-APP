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
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/tools/session.dart';
import '../../../../core/ui/component/ui/float_action_button_widget.dart';
import '../../../event_router.dart';
import '../event_manage_view_model.dart';
import '../router/event_manage_router.dart';

class EventManageRaceView extends StatefulWidget {
  final EventManageViewModel viewModel;

  const EventManageRaceView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventManageRaceViewState createState() => _EventManageRaceViewState();
}

class _EventManageRaceViewState extends State<EventManageRaceView>
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
      body: content(),
      state: widget.viewModel.state,
      onBackPressed: onBackPressed,
      floatAction: FloatActionButtonWidget(
        icon: Icons.edit,
        title: "Edit",
        onPressed: () {
          Modular.to.pushNamed(EventRouter.update);
        },
      ),
    );
  }

  @override
  Future<bool> onBackPressed() async {
    Modular.to.pop();
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
          racesWidget(),
          subscribers(),
        ],
      ),
    );
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
                  widget.viewModel.toggleSubscriptions();
                },
                onToogleMembership: () {
                  widget.viewModel.toggleMembersOnly();
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
              children: [
                const IconWidget(icon: Icons.sports_score),
                const SpacingWidget(LayoutSize.size8),
                const TextWidget(
                  text: "Current state: ",
                  style: Style.title,
                  align: TextAlign.left,
                ),
                const SpacingWidget(LayoutSize.size8),
                EventProgressWidget(
                  shapeless: true,
                  event: widget.viewModel.event,
                ),
              ],
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
                            // widget.viewModel.startEvent();
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
                            // widget.viewModel.finishEvent();
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
        widget.viewModel.removeRegister(classId, userId);
      },
      classes: widget.viewModel.event?.classes,
      users: widget.viewModel.users,
    );
  }

  Widget racesWidget() {
    return EventRaceResultsCollection(
        onRaceCardPressed: (id) {
          Session.instance.setRaceId(id);
          widget.viewModel.onRoute(EventManageRouter.race);
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
