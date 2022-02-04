import 'package:flutter/cupertino.dart';

enum BoundType { small, medium, big, huge, xl, sm }

class BoundWidget extends StatelessWidget {
  final BoundType type;

  const BoundWidget(this.type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case BoundType.sm:
        return const SizedBox(height: 1, width: 1,);
        case BoundType.small:
        return const SizedBox(height: 8, width: 8,);
      case BoundType.medium:
        return const SizedBox(height: 16, width: 16);
      case BoundType.big:
        return const SizedBox(height: 24, width: 24);
      case BoundType.huge:
        return const SizedBox(height: 26, width: 26);
      case BoundType.xl:
        return const SizedBox(height: 48, width: 48);
    }
  }
}
