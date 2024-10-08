import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class LoadingRipple extends StatelessWidget {
  final double? width;
  final double? height;
  final Alignment align;

  const LoadingRipple(
      {this.align = Alignment.center, this.width, this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: align,
      child: Lottie.asset('assets/loading.json',
          width: width ?? MediaQuery.of(context).size.width / 5,
          height: height ?? MediaQuery.of(context).size.height / 5),
    );
  }
}
