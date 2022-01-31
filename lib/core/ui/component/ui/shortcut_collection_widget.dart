import 'package:e_racing_app/core/model/shortcut_model.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/shortcut_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';

class ShortcutCollectionWidget extends StatefulWidget {
  final Function(ShortcutModel?) onPressed;
  final List<ShortcutModel?>? shortcuts;

  const ShortcutCollectionWidget(
      {required this.shortcuts, required this.onPressed, Key? key})
      : super(key: key);

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }

  @override
  _ShortcutCollectionWidgetState createState() =>
      _ShortcutCollectionWidgetState();
}

class _ShortcutCollectionWidgetState extends State<ShortcutCollectionWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Card(
            color: ERcaingApp.color.shade100,
              margin: const EdgeInsets.only(left: 10, top: 8.0),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.shortcuts?.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(right: 8.0, bottom: 4.0),
                            child: ShortcutWidget(
                              onPressed: widget.onPressed,
                              shortcut: widget.shortcuts?[index],
                            ),
                          );
                        }),
                  )),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5.0),
                    topLeft: Radius.circular(5.0)),
              )),
        ),
      ],
    );
  }
}
