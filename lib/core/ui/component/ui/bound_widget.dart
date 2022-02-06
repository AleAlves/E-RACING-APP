import 'package:flutter/cupertino.dart';

enum BoundType { size2, size8, size16, size24, size32, size48 }

class BoundWidget extends StatelessWidget {
  final BoundType type;

  const BoundWidget(this.type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case BoundType.size2:
        return const SizedBox(height: 2, width: 2,);
      case BoundType.size8:
        return const SizedBox(height: 8, width: 8,);
      case BoundType.size16:
        return const SizedBox(height: 16, width: 16);
      case BoundType.size24:
        return const SizedBox(height: 24, width: 24);
      case BoundType.size32:
        return const SizedBox(height: 32, width: 26);
      case BoundType.size48:
        return const SizedBox(height: 48, width: 48);
    }
  }
}
