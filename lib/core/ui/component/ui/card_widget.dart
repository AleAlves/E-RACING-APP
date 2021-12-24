import 'dart:convert';

import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';

class CardWidget extends StatelessWidget {
  final String? label;
  final String? emblem;
  final TextAlign align;

  const CardWidget(this.label, this.emblem,
      {this.align = TextAlign.center, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: InkWell(
          splashColor: ERcaingApp.color[900],
          onTap: () {
            debugPrint('Card tapped.');
          },
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
                child: Wrap(
                  spacing: 0.0,
                  runSpacing: 0.0,
                  children: [
                    "PC",
                    "Xbox",
                    "PS5",
                    "PS4",
                    "Assetto Corsa Competizione",
                    "Project Cars 2",
                    "RFactor 2",
                    "Automobilista 2",
                    "F1 2020"
                  ]
                      .map((tag) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ERcaingApp.color[10]),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: TextWidget(tag, Style.label),
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
          children: [
           Icon(Icons.chevron_right)
          ],
        )
      ],
    );
  }
}
