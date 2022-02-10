import 'package:e_racing_app/core/ui/component/state/loading_ripple.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';
import 'card_widget.dart';

class ExpandedWidget extends StatefulWidget {
  final Widget header;
  final List<Widget> body;
  final bool ready;
  final bool cardless;

  const ExpandedWidget(
      {Key? key,
      required this.header,
      required this.body,
      required this.ready,
      this.cardless = false})
      : super(key: key);

  @override
  _ExpandedWidgetState createState() => _ExpandedWidgetState();
}

class _ExpandedWidgetState extends State<ExpandedWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) => holder();

  Widget holder() {
    return widget.ready ? content() : const LoadingShimmer();
  }

  Widget content() {
    if (widget.cardless) {
      return content();
    }
    return CardWidget(ready: widget.ready, child: expansionWidget());
  }

  Widget expansionWidget() {
    return ExpansionTile(
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: widget.header,
        ),
        children: widget.body,
        trailing: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Ink(
            decoration: ShapeDecoration(
              shape: const CircleBorder(),
              color: Theme.of(context).colorScheme.primary,
            ),
            child: _expanded
                ? Icon(
                    Icons.keyboard_arrow_up,
                    size: 20.0,
                    color: Theme.of(context).colorScheme.background,
                  )
                : Icon(
                    Icons.keyboard_arrow_down,
                    color: Theme.of(context).colorScheme.background,
                    size: 20.0,
                  ),
          ),
        ),
        onExpansionChanged: (bool expanded) {
          setState(() {
            _expanded = expanded;
          });
        });
  }
}
