import 'package:e_racing_app/core/model/tag_model.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TagCollectionWidget extends StatefulWidget {
  final List<TagModel?>? tags;
  final List<String?>? tagIds;
  final bool singleLined;

  const TagCollectionWidget(
      {required this.tagIds,
      required this.tags,
      this.singleLined = false,
      Key? key})
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
    return widget.singleLined ? singleLinedContent() : wrappedContent();
  }

  Widget wrappedContent() {
    return widget.tagIds == null
        ? wrappedLoading()
        : Wrap(
            spacing: 5.0,
            runSpacing: 5.0,
            direction: Axis.horizontal,
            children: widget.tagIds!
                .map((item) {
                  return ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(14.0)),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextWidget(
                            text: name(item),
                            style: Style.note,
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  );
                })
                .toList()
                .cast<Widget>(),
          );
  }

  Widget wrappedLoading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        LoadingShimmer(
          width: 100,
          height: 30,
        ),
        SpacingWidget(LayoutSize.size4),
        LoadingShimmer(
          width: 100,
          height: 30,
        ),
        SpacingWidget(LayoutSize.size4),
        LoadingShimmer(
          width: 100,
          height: 30,
        ),
      ],
    );
  }

  Widget singleLinedContent() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.tagIds?.length,
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(14.0)),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextWidget(
                                text: name(widget.tagIds?[index]),
                                style: Style.note,
                                color:
                                    Theme.of(context).colorScheme.background),
                          ),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SpacingWidget(LayoutSize.size4)
                    ],
                  );
                }),
          ),
        ),
      ],
    );
  }

  String name(String? id) {
    return widget.tags?.firstWhere((k) => k?.id == id)?.name ?? "";
  }
}
