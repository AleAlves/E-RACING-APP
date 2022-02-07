import 'package:e_racing_app/core/model/tag_model.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TagCollectionWidget extends StatefulWidget {
  final List<TagModel?>? tags;
  final List<String?>? tagIds;

  const TagCollectionWidget(
      {required this.tagIds, required this.tags, Key? key})
      : super(key: key);

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }

  @override
  _TagCollectionWidgetState createState() => _TagCollectionWidgetState();
}

class _TagCollectionWidgetState extends State<TagCollectionWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      alignment: WrapAlignment.start,
      direction: Axis.horizontal,
      spacing: 3.0,
      children: widget.tagIds!
          .map((item) {
            return ActionChip(
              label: TextWidget(
                text: name(item),
                style: Style.note,
              ),
              onPressed: () {},
            );
          })
          .toList()
          .cast<Widget>(),
    );
  }

  String name(String? id) {
    return widget.tags?.firstWhere((k) => k?.id == id)?.name ?? "";
  }
}
