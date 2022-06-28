import 'package:flutter/material.dart';

import '../../../model/event_model.dart';

enum StatusOrientation { vertical, horizontal }

class StatusWidget extends StatefulWidget {
  final EventState? state;
  final StatusOrientation? orientation;
  final VoidCallback? onPressed;

  const StatusWidget(
      {required this.state,
      required this.orientation,
      this.onPressed,
      Key? key})
      : super(key: key);

  @override
  _StatusWidgetState createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => content();

  Widget content() {
    Color? frame = Theme.of(context).chipTheme.selectedColor;
    Color stage = Theme.of(context).colorScheme.primary;
    double setp1 = 0.0;
    double setp2 = 0.0;
    double setp3 = 0.0;
    double setp4 = 0.0;

    switch (widget?.state) {
      case EventState.idle:
        setp1 = 10.0;
        break;
      case EventState.ready:
        setp1 = 10.0;
        setp2 = 10.0;
        break;
      case EventState.ongoing:
        setp1 = 10.0;
        setp2 = 10.0;
        setp3 = 10.0;
        break;
      case EventState.finished:
        setp1 = 10.0;
        setp2 = 10.0;
        setp3 = 10.0;
        setp4 = 10.0;
        break;
      default:
        break;
    }
    switch (widget.orientation) {
      case StatusOrientation.vertical:
        return vertical(frame, stage, setp1, setp2, setp3, setp4);
      case StatusOrientation.horizontal:
        return horizontal(frame, stage, setp1, setp2, setp3, setp4);
      default:
        return Container();
    }
  }

  Widget vertical(Color? frame, Color? stage, double setp1, double setp2,
          double setp3, double setp4) =>
      Stack(
        alignment: Alignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.circle,
                    size: setp1,
                    color: stage,
                  ),
                  Icon(
                    Icons.radio_button_off,
                    size: 15,
                    color: frame,
                  )
                ],
              ),
              Container(
                  decoration: BoxDecoration(color: frame),
                  width: 2,
                  height: 15),
              Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.circle,
                    size: setp2,
                    color: stage,
                  ),
                  Icon(
                    Icons.radio_button_off,
                    size: 15,
                    color: frame,
                  )
                ],
              ),
              Container(
                  decoration: BoxDecoration(color: frame),
                  width: 2,
                  height: 15),
              Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.circle,
                    size: setp3,
                    color: stage,
                  ),
                  Icon(
                    Icons.radio_button_off,
                    size: 15,
                    color: frame,
                  )
                ],
              ),
              Container(
                  decoration: BoxDecoration(color: frame),
                  width: 2,
                  height: 15),
              Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.circle,
                    size: setp4,
                    color: stage,
                  ),
                  Icon(
                    Icons.radio_button_off,
                    size: 15,
                    color: frame,
                  )
                ],
              )
            ],
          ),
        ],
      );

  Widget horizontal(Color? frame, Color? stage, double setp1, double setp2,
          double setp3, double setp4) =>
      Stack(
        alignment: Alignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.circle,
                    size: setp1,
                    color: stage,
                  ),
                  Icon(
                    Icons.radio_button_off,
                    size: 15,
                    color: frame,
                  )
                ],
              ),
              Container(
                  decoration: BoxDecoration(color: frame),
                  width: 20,
                  height: 4),
              Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.circle,
                    size: setp2,
                    color: stage,
                  ),
                  Icon(
                    Icons.radio_button_off,
                    size: 15,
                    color: frame,
                  )
                ],
              ),
              Container(
                  decoration: BoxDecoration(color: frame),
                  width: 20,
                  height: 4),
              Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.circle,
                    size: setp3,
                    color: stage,
                  ),
                  Icon(
                    Icons.radio_button_off,
                    size: 15,
                    color: frame,
                  )
                ],
              ),
              Container(
                  decoration: BoxDecoration(color: frame),
                  width: 20,
                  height: 4),
              Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.circle,
                    size: setp4,
                    color: stage,
                  ),
                  Icon(
                    Icons.radio_button_off,
                    size: 15,
                    color: frame,
                  )
                ],
              )
            ],
          ),
        ],
      );
}
