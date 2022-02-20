import 'package:e_racing_app/core/model/event_model.dart';
import 'package:e_racing_app/core/model/pair_model.dart';
import 'package:e_racing_app/core/tools/access_validation_extension.dart';
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

    switch (widget.event?.state) {
      case EventState.idle:
        idle = Icon(
          Icons.circle,
          color: _getStatus()?.first,
          size: 24,
        );
        onGoing = Icon(
          Icons.radio_button_off,
          color: Theme.of(context).colorScheme.primary,
          size: 18,
        );
        finished = Icon(
          Icons.radio_button_off,
          color: Theme.of(context).colorScheme.primary,
          size: 18,
        );
        break;
      case EventState.ongoing:
        idle = const Icon(
          Icons.circle,
          size: 18,
          color: Color(0xFF294CA5),
        );
        onGoing = Icon(
          Icons.circle,
          color: _getStatus()?.first,
          size: 24,
        );
        finished = Icon(
          Icons.radio_button_off,
          color: Theme.of(context).colorScheme.primary,
          size: 18,
        );
        break;
      case EventState.finished:
        idle = const Icon(
          Icons.circle,
          size: 18,
          color: Color(0xFF294CA5),
        );
        onGoing = const Icon(
          Icons.circle,
          size: 18,
          color: Color(0xFF1AA01C),
        );
        finished = Icon(
          Icons.circle,
          color: _getStatus()?.first,
          size: 24,
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
                  idle,
                  const SpacingWidget(LayoutSize.size2),
                  Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      width: MediaQuery.of(context).size.width / 3.5,
                      height: 5),
                  const SpacingWidget(LayoutSize.size2),
                  onGoing,
                  const SpacingWidget(LayoutSize.size2),
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    width: MediaQuery.of(context).size.width / 3.5,
                    height: 5,
                  ),
                  const SpacingWidget(LayoutSize.size2),
                  finished,
                ],
              ),
              const SpacingWidget(LayoutSize.size16),
              TextWidget(
                text: "Status: ${_getStatus()?.second}",
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

  Pair<Color, String>? _getStatus() {
    switch (widget.event?.state) {
      case EventState.idle:
        return Pair(const Color(0xFF294CA5), "In preparation");
      case EventState.ongoing:
        return Pair(const Color(0xFF1AA01C), "On going");
      case EventState.finished:
        return Pair(const Color(0xFFA01A1A), "Finished");
      default:
        return Pair(const Color(0xFF294CA5), "unknow");
    }
  }
}
