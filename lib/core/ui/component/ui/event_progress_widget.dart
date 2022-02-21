import 'package:e_racing_app/core/ext/status_extensions.dart';
import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/ext/access_extension.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    late Icon idle;
    late Icon onGoing;
    late Icon finished;
    var track = Colors.green;
    var base = Theme.of(context).colorScheme.primary;

    switch (widget.event?.state) {
      case EventState.idle:
        idle = Icon(
          Icons.circle,
          color: track,
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
      case EventState.ongoing:
        idle = Icon(
          Icons.circle,
          color: track,
        );
        onGoing = Icon(
          Icons.circle,
          color: track,
        );
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
        onGoing = Icon(
          Icons.circle,
          color: track,
        );
        finished = Icon(
          Icons.circle,
          color: track,
        );
        break;
      default:
        break;
    }
    return progress(idle, onGoing, finished);
  }

  Widget progress(Icon idle, Icon onGoing, Icon finished) {
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
              Stack(
                children: [
                  idle,
                  Icon(Icons.radio_button_unchecked,
                      color: Theme.of(context).colorScheme.primary),
                ],
              ),
              const SpacingWidget(LayoutSize.size2),
              Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50))),
                  width: MediaQuery.of(context).size.width / 3.5,
                  height: 5),
              const SpacingWidget(LayoutSize.size2),
              Stack(
                children: [
                  onGoing,
                  Icon(Icons.radio_button_unchecked,
                      color: Theme.of(context).colorScheme.primary),
                ],
              ),
              const SpacingWidget(LayoutSize.size2),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(50))),
                width: MediaQuery.of(context).size.width / 3.5,
                height: 5,
              ),
              const SpacingWidget(LayoutSize.size2),
              Stack(
                children: [
                  finished,
                  Icon(Icons.radio_button_unchecked,
                      color: Theme.of(context).colorScheme.primary),
                ],
              ),
            ],
          ),
          const SpacingWidget(LayoutSize.size16),
          TextWidget(
            text: "Status: ${getEventStatus(widget.event?.state)}",
            style: Style.description,
            align: TextAlign.left,
          ),
          const SpacingWidget(LayoutSize.size8),
        ],
      )),
      ready: true,
      shapeLess: widget.shapeless,
    );
  }
}
