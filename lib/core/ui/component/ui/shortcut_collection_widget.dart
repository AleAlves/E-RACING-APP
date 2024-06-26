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
    return Column(
        children: widget.shortcuts
            ?.map((e) => ShortcutWidget(
                  onPressed: widget.onPressed,
                  shortcut: e as ShortcutModel,
                ))
            .toList()
            .cast<Widget>() as List<Widget>);
  }
}
