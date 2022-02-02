import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/float_action_button_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
    widget.viewModel.fetchEvents();
    widget.viewModel.fetchTags();
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
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.viewModel.events?.length,
          itemBuilder: (context, index) {
            return EventCardWidget(
              icon: _getIcon(widget.viewModel.events?[index]?.type),
              color: _getColor(widget.viewModel.events?[index]?.type),
              event: widget.viewModel.events?[index],
            );
          },
        ),
        FloatActionButtonWidget<EventFlows>(
          flow: EventFlows.create,
          icon: Icons.add,
          onPressed: (flow) {
            widget.viewModel.setFlow(flow);
          },
        ),
      ],
    );
  }

  IconData? _getIcon(EventType? type) {
    switch (type) {
      case EventType.race:
        return Icons.sports_score;
      case EventType.championship:
        return Icons.emoji_events;
      default:
        return Icons.sports_score;
    }
  }

  Color? _getColor(EventType? type) {
    switch (type) {
      case EventType.race:
        return const Color(0xFF311AA0);
      case EventType.championship:
        return const Color(0xFF1AA01C);
      default:
        return const Color(0xFF1AA01C);
    }
  }
}
