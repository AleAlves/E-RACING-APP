import 'dart:convert';

import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  final MediaModel? media;
  final bool? loadDefault;

  const BannerWidget({required this.media, this.loadDefault = false, Key? key})
      : super(key: key);

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  Image? image;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.media != null) {
      image = Image.memory(
        base64Decode(widget.media?.image ?? ''),
        fit: BoxFit.fill,
      );
    } else if (widget.loadDefault == true) {
      image = Image.asset(
        "assets/images/poster.jpg",
        fit: BoxFit.fill,
      );
    }

    return widget.media == null && widget.loadDefault == false
        ? const Padding(
            padding: EdgeInsets.only(left: 2, right: 2),
            child: LoadingShimmer(
              height: 200,
            ),
          )
        : Padding(
            padding: EdgeInsets.zero,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              child: SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: image),
            ),
          );
  }
}
