import 'package:e_racing_app/core/ui/component/state/loading_ripple.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';

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
    if (widget.cardless) {
      return Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 1.0, bottom: 1.0),
          child: content());
    }
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, top: 1.0, bottom: 1.0),
      child: Card(child: content()),
    );
  }

  Widget content() {
    return widget.ready
        ? ExpansionTile(
            title: Padding(
              padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
              child: widget.ready
                  ? widget.header
                  : const LoadingShimmer(
                      height: 10,
                    ),
            ),
            children: widget.body,
            trailing: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Ink(
                decoration: const ShapeDecoration(
                  shape: CircleBorder(),
                ),
                child: _expanded
                    ? const Icon(
                        Icons.keyboard_arrow_up,
                        size: 20.0,
                      )
                    : const Icon(
                        Icons.keyboard_arrow_down,
                        size: 20.0,
                      ),
              ),
            ),
            onExpansionChanged: (bool expanded) {
              setState(() {
                _expanded = expanded;
              });
            })
        : const Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: LoadingShimmer(),
          );
  }

  Widget loading(BuildContext context) {
    return const Card(child: LoadingRipple());
  }
}
