import 'dart:convert';

import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:flutter/material.dart';

class PictureWidget extends StatefulWidget {
  final String? image;
  final double width;
  final double height;
  final double padding;

  const PictureWidget(
      {required this.image, this.width = 100.0, this.height = 100.0, this.padding = 8.0,Key? key})
      : super(key: key);

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
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: LoadingShimmer(
              height: widget.height,
              width: widget.width,
            ),
          )
        : Padding(
            padding: EdgeInsets.all(widget.padding),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: SizedBox(
                width: widget.width,
                height: widget.height,
                child: Image.memory(
                  base64Decode(widget.image ?? ''),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
  }
}
