import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/login/legacy/presentation/ui/login_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../login_view_model.dart';

class LoginToogle2FAWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginToogle2FAWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginToogle2FAWidgetState createState() => _LoginToogle2FAWidgetState();
}

class _LoginToogle2FAWidgetState extends State<LoginToogle2FAWidget>
    implements BaseSateWidget {
  var isSwitched = false;

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
      scrollable: false,
      body: content(),
      onBackPressed: onBackPressed,
      state: widget.viewModel.state,
    );
  }

  @override
  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const TextWidget(text: "Ativar/desativar 2FA", style: Style.paragraph),
        Switch(
          value: isSwitched,
          onChanged: (value) {
            setState(() {
              isSwitched = value;
              widget.viewModel.toogle2fa(!isSwitched);
            });
          },
        ),
      ],
    );
  }

  @override
  observers() {}

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.flow = LoginWidgetFlow.login;
    return false;
  }
}
