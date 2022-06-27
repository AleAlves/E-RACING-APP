import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class LoadingShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  final Alignment align;

  const LoadingShimmer(
      {this.align = Alignment.center, this.width, this.height, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: Card(
          child: SizedBox(
            width: width ?? MediaQuery.of(context).size.width,
            height: height ?? 75,
          ),
        ),
        baseColor: Theme.of(context).cardColor,
        highlightColor:Theme.of(context).focusColor);
  }
}
