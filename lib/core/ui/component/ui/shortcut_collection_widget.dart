import 'package:e_racing_app/core/model/shortcut_model.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/shortcut_widget.dart';
import 'package:flutter/material.dart';

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
    return Wrap(
        direction: Axis.horizontal,
        children: widget.shortcuts
            ?.map((e) => SizedBox(
          width: MediaQuery.of(context).size.width / 3 - 8,
              child: ShortcutWidget(
                    onPressed: widget.onPressed,
                    shortcut: e,
                  ),
            ))
            .toList()
            .cast<Widget>() as List<Widget>);
  }
}
