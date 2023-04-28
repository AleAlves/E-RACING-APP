import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/ui/component/ui/chip_widget.dart';
import 'package:flutter/material.dart';

import '../../../ext/status_extensions.dart';

class EventProgressWidget extends StatefulWidget {
  final EventModel? event;
  final bool shapeless;

  const EventProgressWidget({this.event, this.shapeless = false, Key? key})
      : super(key: key);

  @override
  _EventProgressWidgetState createState() => _EventProgressWidgetState();
}

class _EventProgressWidgetState extends State<EventProgressWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => getStatusChip();

  Widget getStatusChip() {
    return ChipWidget(
      text: getEventStatus(widget.event?.state),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
    );
  }
}
