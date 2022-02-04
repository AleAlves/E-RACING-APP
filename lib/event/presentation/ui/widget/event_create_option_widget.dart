import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/event/presentation/ui/event_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../event_view_model.dart';

class EventCreateOptionWidget extends StatefulWidget {
  final EventViewModel viewModel;

  const EventCreateOptionWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventCreateOptionWidgetState createState() => _EventCreateOptionWidgetState();
}

class _EventCreateOptionWidgetState extends State<EventCreateOptionWidget>
    implements BaseSateWidget {
  @override
  void initState() {
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
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextWidget(text: "Choose a type of event", style: Style.title),
          const BoundWidget(BoundType.huge),
          const BoundWidget(BoundType.huge),
          ButtonWidget(
            enabled: true,
            type: ButtonType.normal,
            onPressed: () {
              widget.viewModel.flow = EventFlows.createRace;
            },
            label: "Single race",
          ),
          const BoundWidget(BoundType.huge),
          const TextWidget(text: "or", style: Style.subtitle),
          const BoundWidget(BoundType.huge),
          ButtonWidget(
            enabled: true,
            type: ButtonType.normal,
            onPressed: () {
              widget.viewModel.flow = EventFlows.createEvent;
            },
            label: "Championship",
          ),
        ],
      ),
    );
  }
}