import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
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
  _EventCreateOptionWidgetState createState() =>
      _EventCreateOptionWidgetState();
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
        body: content(),
        scrollable: false,
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
          const SpacingWidget(LayoutSize.size32),
          const SpacingWidget(LayoutSize.size32),
          ButtonWidget(
            enabled: true,
            type: ButtonType.primary,
            onPressed: () {
              widget.viewModel.flow = EventFlow.createRace;
            },
            label: "Single race",
          ),
          const SpacingWidget(LayoutSize.size32),
          const TextWidget(text: "or", style: Style.subtitle),
          const SpacingWidget(LayoutSize.size32),
          ButtonWidget(
            enabled: true,
            type: ButtonType.primary,
            onPressed: () {
              widget.viewModel.flow = EventFlow.createEvent;
            },
            label: "Championship",
          ),
        ],
      ),
    );
  }
}
