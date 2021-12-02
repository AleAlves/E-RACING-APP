import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class LoadingRipple extends StatelessWidget {
  final double width;
  final double height;
  final Alignment align;

  const LoadingRipple(
      {this.align = Alignment.center,
      this.width = 100.00,
      this.height = 100.00,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Lottie.asset('assets/loading.json', width: width, height: 100),
      alignment: align,
    );
  }
}
