import 'package:e_racing_app/core/navigation/routes.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
                    text: "Something went wrong", style: Style.subtitle),
                const SpacingWidget(LayoutSize.size48),
                Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ButtonWidget(
                      type: ButtonType.iconButton,
                      icon: Icons.refresh,
                      onPressed: () {
                        Modular.to.pushNamed(Routes.home);
                      },
                      enabled: true,
                    ),
                  ),
                ),
                const SpacingWidget(LayoutSize.size16),
                const TextWidget(
                    text: "Try again later", style: Style.subtitle),
              ],
            ),
          );
        }),
        onWillPop: _onBackPressed);
  }

  Future<bool> _onBackPressed() async {
    Modular.to.pushNamed(Routes.home);
    return false;
  }
}
