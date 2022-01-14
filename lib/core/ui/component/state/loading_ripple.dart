import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class LoadingRipple extends StatelessWidget {
  final double? width;
  final double? height;
  final Alignment align;

  const LoadingRipple(
      {this.align = Alignment.center, this.width, this.height, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Lottie.asset('assets/loading.json',
          width: width ?? MediaQuery.of(context).size.width,
          height: height ?? 100),
      alignment: align,
    );
  }
}
