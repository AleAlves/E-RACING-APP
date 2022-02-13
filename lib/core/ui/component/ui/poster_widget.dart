import 'dart:convert';

import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PosterWidget extends StatefulWidget {
  final String? post;

  const PosterWidget({required this.post, Key? key}) : super(key: key);

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }

  @override
  _PosterWidgetState createState() => _PosterWidgetState();
}

class _PosterWidgetState extends State<PosterWidget> {
  bool loaded = false;
  Image? image;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loaded = widget.post == null;

    if (!loaded && image == null) {
      image = Image.memory(
        base64Decode(widget.post ?? ''),
        fit: BoxFit.fill,
      );
    }

    return loaded
        ? const LoadingShimmer(
            height: 200,
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SizedBox(
                height: MediaQuery.of(context).size.height / 2 ,
                width: MediaQuery.of(context).size.width,
                child: image),
          );
  }
}
