import 'dart:convert';

import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:flutter/material.dart';

class PosterWidget extends StatefulWidget {
  final String? post;
  final bool? loadDefault;

  const PosterWidget({required this.post, this.loadDefault = false, Key? key})
      : super(key: key);

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }

  @override
  _PosterWidgetState createState() => _PosterWidgetState();
}

class _PosterWidgetState extends State<PosterWidget> {
  Image? image;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.post != null) {
      image = Image.memory(
        base64Decode(widget.post ?? ''),
        fit: BoxFit.fill,
      );
    } else if (widget.loadDefault == true) {
      image = Image.asset(
        "assets/images/poster.jpg",
        fit: BoxFit.fill,
      );
    }
    return widget.post == null && widget.loadDefault == false
        ? LoadingShimmer(
            height: MediaQuery.of(context).size.height * 0.4,
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SizedBox(
                height: MediaQuery.of(context).size.height * .4,
                width: MediaQuery.of(context).size.width,
                child: image),
          );
  }
}
