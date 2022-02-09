import 'package:flutter/cupertino.dart';

enum LayoutSize { size2, size4, size8, size16, size24, size32, size48, size64, size128, size256 }

class SpacingWidget extends StatelessWidget {
  final LayoutSize type;

  const SpacingWidget(this.type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case LayoutSize.size2:
        return const SizedBox(height: 2, width: 2,);
      case LayoutSize.size4:
        return const SizedBox(height: 4, width: 4,);
      case LayoutSize.size8:
        return const SizedBox(height: 8, width: 8,);
      case LayoutSize.size16:
        return const SizedBox(height: 16, width: 16);
      case LayoutSize.size24:
        return const SizedBox(height: 24, width: 24);
      case LayoutSize.size32:
        return const SizedBox(height: 32, width: 26);
      case LayoutSize.size48:
        return const SizedBox(height: 48, width: 48);
      case LayoutSize.size64:
        return const SizedBox(height: 64, width: 64);
      case LayoutSize.size128:
        return const SizedBox(height: 128, width: 128);
      case LayoutSize.size256:
        return const SizedBox(height: 256, width: 256);
    }
  }
}
