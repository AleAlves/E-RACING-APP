import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../event_view_model.dart';
import '../event_flow.dart';

class EventDetailRaceWidget extends StatefulWidget {
  final EventViewModel viewModel;

  const EventDetailRaceWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _EventDetailRaceWidgetState createState() => _EventDetailRaceWidgetState();
}

class _EventDetailRaceWidgetState extends State<EventDetailRaceWidget>
    implements BaseSateWidget {

  @override
  void initState() {
    observers();
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
    widget.viewModel.setFlow(EventFlows.list);
    return false;
  }

  @override
  Widget content() {
    return const TextWidget(text: "race detail", style: Style.title);
  }
}
