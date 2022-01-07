import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';

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
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return ViewStateWidget(
        content: content(),
        onBackPressed: _onBackPressed,
        state: widget.viewModel.state,
      );
    });
  }

  Future<bool> _onBackPressed() async {
    widget.viewModel.flow = LoginWidgetFlow.init;
    return false;
  }

  @override
  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const TextWidget("Ativar/desativar 2FA", Style.description),
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
}
