import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../main.dart';

class DefaulErrorWidget extends StatefulWidget {
  const DefaulErrorWidget({Key? key}) : super(key: key);

  @override
  _DefaulErrorWidgetState createState() => _DefaulErrorWidgetState();
}

class _DefaulErrorWidgetState extends State<DefaulErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Observer(builder: (_) {
          return Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TextWidget(
                    text: "Tente Novamente", style: Style.subtitle),
                const BoundWidget(BoundType.size16),
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
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        onWillPop: _onBackPressed);
  }

  Future<bool> _onBackPressed() async {
    return false;
  }
}
