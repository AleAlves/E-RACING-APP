import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/ui/component/ui/chip_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';
import '../../../ext/status_extensions.dart';
import 'spacing_widget.dart';
import 'card_widget.dart';

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
  Widget build(BuildContext context) {
    late Widget idle;
    late Widget onGoing;
    late Widget ready;
    late Widget finished;
    var track = Theme.of(context).colorScheme.primary;
    var base = Theme.of(context).colorScheme.primary;
    var bar1Size = 6.0;
    var bar2Size = 6.0;

    switch (widget.event?.state) {
      case EventState.idle:
        idle = getStatusChip();
        ready = Icon(
          Icons.radio_button_off,
          color: base,
        );
        onGoing = Icon(
          Icons.radio_button_off,
          color: base,
        );
        finished = Icon(
          Icons.radio_button_off,
          color: base,
        );
        break;
      case EventState.ready:
        idle = Icon(
          Icons.circle,
          color: track,
        );
        ready = getStatusChip();
        onGoing = Icon(
          Icons.radio_button_off,
          color: base,
        );
        finished = Icon(
          Icons.radio_button_off,
          color: base,
        );
        break;
      case EventState.ongoing:
        idle = Icon(
          Icons.circle,
          color: track,
        );
        ready = Icon(
          Icons.circle,
          color: track,
        );
        onGoing = getStatusChip();
        finished = Icon(
          Icons.radio_button_off,
          color: base,
        );
        break;
      case EventState.finished:
        idle = Icon(
          Icons.circle,
          color: track,
        );
        ready = Icon(
          Icons.circle,
          color: track,
        );
        onGoing = Icon(
          Icons.circle,
          color: track,
        );
        finished = getStatusChip();
        break;
      default:
        break;
    }
    return progress(idle, ready, onGoing, finished, bar1Size, bar2Size);
  }

  Widget progress(Widget idle, Widget ready, Widget onGoing, Widget finished,
      double bar1Size, double bar2size) {
    return CardWidget(
      child: SizedBox(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SpacingWidget(LayoutSize.size8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              idle,
              const SpacingWidget(LayoutSize.size2),
              Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50))),
                  width: MediaQuery.of(context).size.width / 7,
                  height: bar1Size),
              const SpacingWidget(LayoutSize.size2),
              ready,
              const SpacingWidget(LayoutSize.size2),
              Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50))),
                  width: MediaQuery.of(context).size.width / 7,
                  height: bar1Size),
              const SpacingWidget(LayoutSize.size2),
              onGoing,
              const SpacingWidget(LayoutSize.size2),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(50))),
                width: MediaQuery.of(context).size.width / 7,
                height: bar2size,
              ),
              const SpacingWidget(LayoutSize.size2),
              finished,
            ],
          ),
          const SpacingWidget(LayoutSize.size8),
        ],
      )),
      ready: true,
      shapeLess: widget.shapeless,
    );
  }

  Widget getStatusChip() {
    return ChipWidget(label: getEventStatus(widget.event?.state));
  }
}
