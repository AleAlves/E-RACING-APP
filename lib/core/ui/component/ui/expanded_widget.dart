import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'card_widget.dart';

class ExpandedWidget extends StatefulWidget {
  final Widget header;
  final List<Widget> body;
  final bool ready;
  final bool shapeless;
  final bool iniExpanded;

  const ExpandedWidget(
      {Key? key,
      required this.header,
      required this.body,
      required this.ready,
      this.iniExpanded = false,
      this.shapeless = false})
      : super(key: key);

  @override
  _ExpandedWidgetState createState() => _ExpandedWidgetState();
}

class _ExpandedWidgetState extends State<ExpandedWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) =>
      widget.ready ? content() : const LoadingShimmer();

  Widget content() {
    if (widget.shapeless) {
      return expansionWidget();
    }
    return CardWidget(ready: widget.ready, child: expansionWidget(), padding: EdgeInsets.only(top: 16, bottom: 16, left: 8),);
  }

  Widget expansionWidget() {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
          initiallyExpanded: widget.iniExpanded,
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: widget.header,
          ),
          children: widget.body,
          trailing: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Ink(
              child: _expanded
                  ? Icon(
                      Icons.keyboard_arrow_up,
                      size: 24.0,
                      color: Theme.of(context).colorScheme.onBackground,
                    )
                  : Icon(
                      Icons.keyboard_arrow_down,
                      color: Theme.of(context).colorScheme.onBackground,
                      size: 24.0,
                    ),
            ),
          ),
          onExpansionChanged: (bool expanded) {
            setState(() {
              _expanded = expanded;
            });
          }),
    );
  }
}
