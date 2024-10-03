import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingRoundedShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  final Alignment align;

  const LoadingRoundedShimmer(
      {this.align = Alignment.center, this.width, this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Theme.of(context).cardColor,
        highlightColor: Theme.of(context).focusColor,
        child: Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ));
  }
}
