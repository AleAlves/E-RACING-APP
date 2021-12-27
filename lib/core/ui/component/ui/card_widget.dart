import 'dart:convert';

import 'package:e_racing_app/core/model/tag_model.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';

class CardWidget extends StatelessWidget {
  final String? label;
  final String? emblem;
  final TextAlign align;
  final List<TagModel?>? tags;
  final List<String?>? leagueTags;
  final VoidCallback? onPressed;

  const CardWidget(this.label, this.emblem, this.tags, this.leagueTags, this.onPressed,
      {this.align = TextAlign.center, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: InkWell(
          splashColor: ERcaingApp.color[0],
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
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: SizedBox(
            width: 100,
            height: 100,
            child: Image.memory(
              base64Decode(emblem ?? ''),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextWidget(label ?? '', Style.subtitle),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: leagueTags!.isEmpty
                    ? Container()
                    : Wrap(
                        spacing: 0.0,
                        runSpacing: 0.0,
                        children: leagueTags
                            !.map((tag) {
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ERcaingApp.color[10]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: TextWidget(
                                        tags?.firstWhere((k) => k?.id == tag)?.name
                                    ?? '-', Style.label),
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
