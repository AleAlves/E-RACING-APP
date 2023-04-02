import 'package:e_racing_app/core/ext/event_iconography_extension.dart';
import 'package:e_racing_app/core/tools/session.dart';
import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/event_card_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/float_action_button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../event_view_model.dart';
import '../event_flow.dart';

class EventListFilteredWidget extends StatefulWidget {
  final EventViewModel viewModel;

  const EventListFilteredWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventListFilteredWidgetState createState() =>
      _EventListFilteredWidgetState();
}

class _EventListFilteredWidgetState extends State<EventListFilteredWidget>
    implements BaseSateWidget {
  @override
  void initState() {
    widget.viewModel.fetchEventsFiltered();
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
      scrollable: true,
      state: widget.viewModel.state,
      onBackPressed: onBackPressed,
      floatAction: FloatActionButtonWidget(
        icon: Icons.add,
        title: "Create Event",
        onPressed: () {
          widget.viewModel.setFlow(EventFlow.create);
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
    return Column(
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
                  Session.instance
                      .setEventId(widget.viewModel.events?[index]?.id);
                  widget.viewModel.setFlow(EventFlow.eventDetail);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
