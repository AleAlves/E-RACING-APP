import 'package:e_racing_app/core/ui/component/state/loading_ripple.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';

class ClassExpandedCardHolderWidget extends StatefulWidget {
  final Widget header;
  final List<Widget> body;
  final bool ready;

  const ClassExpandedCardHolderWidget(
      {Key? key, required this.header, required this.body, required this.ready})
      : super(key: key);

  @override
  _ClassExpandedCardHolderWidgetState createState() =>
      _ClassExpandedCardHolderWidgetState();
}

class _ClassExpandedCardHolderWidgetState
    extends State<ClassExpandedCardHolderWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) => card();

  Widget card() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, top: 1.0, bottom: 1.0),
      child: Card(child: content()),
    );
  }

  Widget content() {
    return ExpansionTile(
        title: Padding(
          padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
          child: widget.header,
        ),
        children: widget.body,
        trailing: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Ink(
              decoration: ShapeDecoration(
                color: ERcaingApp.color.shade100,
                shape: CircleBorder(),
              ),
              child: _expanded
                  ? const Icon(
                Icons.keyboard_arrow_up,
                color: Colors.white,
                size: 20.0,
              )
                  : const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 20.0,
              ),),
        ),
        onExpansionChanged: (bool expanded) {
          setState(() {
            _expanded = expanded;
          });
        });
  }

  Widget loading(BuildContext context) {
    return const Card(child: LoadingRipple());
  }
}
