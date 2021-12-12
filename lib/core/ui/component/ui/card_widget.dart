import 'dart:convert';

import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';

class CardWidget extends StatelessWidget {
  final String? label;
  final String? image;
  final TextAlign align;

  const CardWidget(this.label, this.image,
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
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextWidget(
                  label ?? 'No description',
                  Style.subtitle,
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 148,
                      child: Image.memory(
                        base64Decode(image ?? ''),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
