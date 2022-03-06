import 'dart:convert';

import 'package:e_racing_app/core/model/media_model.dart';
import 'package:e_racing_app/core/ui/component/state/loading_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  final MediaModel? media;

  const BannerWidget({required this.media, Key? key}) : super(key: key);

  Widget loading(BuildContext context) {
    return const Card(child: LoadingShimmer());
  }

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  bool loaded = false;
  Image? image;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loaded = widget.media?.image == null;

    if (!loaded && image == null) {
      image = Image.memory(
        base64Decode(widget.media?.image ?? ''),
        fit: BoxFit.fill,
      );
    }

    return loaded
        ? const Padding(
            padding: EdgeInsets.only(left: 2, right: 2),
            child: LoadingShimmer(
              height: 200,
            ),
          )
        : Padding(
          padding: EdgeInsets.zero,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: image),
            ),
        );
  }
}
