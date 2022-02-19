import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_admin_panel_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_progress_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../event_view_model.dart';
import '../event_flow.dart';

class EventHostPanelWidget extends StatefulWidget {
  final EventViewModel viewModel;

  const EventHostPanelWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventHostPanelWidgetState createState() => _EventHostPanelWidgetState();
}

class _EventHostPanelWidgetState extends State<EventHostPanelWidget>
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
          eventSubscriptions(),
          editEvent(),
          eventStatus(),
        ],
      ),
    );
  }

  Widget editEvent() {
    return CardWidget(
        shapeLess: true,
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
                label: "Edit event",
                type: ButtonType.normal,
                onPressed: () {
                  widget.viewModel.setFlow(EventFlows.manager);
                },
                enabled: true,
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
            child: EventAdminPanel(
              minWidth: MediaQuery.of(context).size.width,
              event: widget.viewModel.event,
              onToogle: () {
                widget.viewModel.toogleSubscriptions();
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
                    showAlert("Are you sure you want to start this event?", () {
                      widget.viewModel.startEvent();
                    });
                    break;
                  case EventState.ongoing:
                    showAlert("Are you sure you want to finish this event?", () {
                      widget.viewModel.finishEvent();
                    });
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

  showAlert(String message, Function() onPositive) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) =>
            StatefulBuilder(builder: (BuildContext context, myState) {
              return SizedBox(
                child: Wrap(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const SpacingWidget(LayoutSize.size16),
                            TextWidget(text: message, style: Style.subtitle),
                            const SpacingWidget(LayoutSize.size48),
                            ButtonWidget(
                              label: "Yes I do",
                              type: ButtonType.important,
                              onPressed: () {
                                onPositive.call();
                                Navigator.of(context).pop();
                              },
                              enabled: true,
                            ),
                            const SpacingWidget(LayoutSize.size24),
                            ButtonWidget(
                              label: "No I don't",
                              type: ButtonType.normal,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              enabled: true,
                            ),
                            const SpacingWidget(LayoutSize.size16),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }));
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
