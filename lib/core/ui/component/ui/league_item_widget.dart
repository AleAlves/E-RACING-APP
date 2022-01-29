import 'package:e_racing_app/core/model/tag_model.dart';
import 'package:e_racing_app/core/ui/component/ui/picture_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';

class LeagueItemWidget extends StatelessWidget {
  final String? label;
  final String? emblem;
  final TextAlign align;
  final List<TagModel?>? tags;
  final List<String?>? leagueTags;
  final VoidCallback? onPressed;

  const LeagueItemWidget(
      this.label, this.emblem, this.tags, this.leagueTags, this.onPressed,
      {this.align = TextAlign.center, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
      child: Card(
        child: InkWell(
          splashColor: ERcaingApp.color.shade100,
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: content(),
          ),
        ),
      ),
    );
  }

  Widget content() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PictureWidget(
          image: emblem,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextWidget(
                  text: label ?? '',
                  style: Style.subtitle,
                  align: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: leagueTags == null
                    ? Container()
                    : Wrap(
                        spacing: 1.0,
                        runSpacing: 0.0,
                        children: leagueTags!
                            .map((tag) {
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ERcaingApp.color.shade50),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: TextWidget(
                                        text: tags
                                                ?.firstWhere(
                                                    (k) => k?.id == tag)
                                                ?.name ??
                                            '-',
                                        style: Style.label),
                                  ),
                                ),
                              );
                            })
                            .toList()
                            .cast<Widget>(),
                      ),
              )
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Icon(Icons.chevron_right)],
        )
      ],
    );
  }
}
