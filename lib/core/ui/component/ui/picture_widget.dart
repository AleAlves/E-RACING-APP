import 'dart:convert';

import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PictureWidget extends StatefulWidget {
  final String? image;

  const PictureWidget({required this.image, Key? key}) : super(key: key);

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }

  @override
  _PictureWidgetState createState() => _PictureWidgetState();
}

class _PictureWidgetState extends State<PictureWidget> {
  bool loaded = false;
  Image? image;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loaded = widget.image == null;

    if (!loaded && image == null) {
      image = Image.memory(
        base64Decode(widget.image ?? ''),
        fit: BoxFit.fill,
      );
    }

    return loaded
        ? const Padding(
            padding: EdgeInsets.all(8.0),
            child: LoadingShimmer(
              height: 200,
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.memory(
                  base64Decode(widget.image ?? ''),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
  }
}
