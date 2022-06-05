import 'package:e_racing_app/core/ext/event_iconography_extension.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/float_action_button_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../event_view_model.dart';
import '../event_flow.dart';

class EventListWidget extends StatefulWidget {
  final EventViewModel viewModel;

  const EventListWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventListWidgetState createState() => _EventListWidgetState();
}

class _EventListWidgetState extends State<EventListWidget>
    implements BaseSateWidget {
  @override
  void initState() {
    widget.viewModel.fetchEvents();
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
    Modular.to.pop();
    return false;
  }

  @override
  Widget content() {
    return Stack(
      children: [
        Column(
          children: [
            const SpacingWidget(LayoutSize.size8),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.viewModel.events?.length,
                itemBuilder: (context, index) {
                  return EventCardWidget(
                    icon: getIcon(widget.viewModel.events?[index]?.type),
                    color: getColor(widget.viewModel.events?[index]?.type),
                    event: widget.viewModel.events?[index],
                    onPressed: () {
                      Session.instance.setEventId(widget.viewModel.events?[index]?.id);
                      widget.viewModel.setFlow(EventFlow.eventDetail);
                    },
                  );
                },
              ),
            ),
          ],
        ),
        FloatActionButtonWidget<EventFlow>(
          flow: EventFlow.create,
          icon: Icons.add,
          onPressed: (flow) {
            widget.viewModel.setFlow(flow);
          },
        ),
      ],
    );
  }
}
