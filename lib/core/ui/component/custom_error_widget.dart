import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../main.dart';

class CustomErrorWidget extends StatefulWidget {

  final Function() onRetry;

  const CustomErrorWidget(this.onRetry, {Key? key}) : super(key: key);

  @override
  _CustomErrorWidgetState createState() => _CustomErrorWidgetState();
}

class _CustomErrorWidgetState extends State<CustomErrorWidget> {

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Tente novamente"),
            const SizedBox(height: 8),
            Material(
              color: Colors.transparent,
              child: Center(
                child: Ink(
                  decoration: const ShapeDecoration(
                    color: ERcaingApp.color,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.refresh),
                    color: Colors.white,
                    onPressed: widget.onRetry,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
