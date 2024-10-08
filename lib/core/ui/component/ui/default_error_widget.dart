import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../login/login_router.dart';

class DefaultErrorWidget extends StatefulWidget {
  const DefaultErrorWidget({super.key});

  @override
  _ErrorWidgetState createState() => _ErrorWidgetState();
}

class _ErrorWidgetState extends State<DefaultErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
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
                      type: ButtonType.icon,
                      icon: Icons.refresh,
                      onPressed: () {
                        Modular.to.popAndPushNamed(LoginRouter.signIn);
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
        }));
  }

  Future<bool> _onBackPressed() async {
    Modular.to.pushNamed(LoginRouter.signIn);
    return false;
  }
}
