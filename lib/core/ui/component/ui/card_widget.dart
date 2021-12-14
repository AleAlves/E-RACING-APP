import 'dart:convert';

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
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: SizedBox(
                  width: 100,
                  height:  100,
                  child: Image.memory(
                    base64Decode(emblem ?? ''),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: TextWidget(
                  label ?? 'No description',
                  Style.subtitle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
