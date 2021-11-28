import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:e_racing_app/core/ui/component/text/text_widget.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';

import '../login_view_model.dart';


class LoginToogle2FAWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginToogle2FAWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginToogle2FAWidgetState createState() => _LoginToogle2FAWidgetState();
}

class _LoginToogle2FAWidgetState extends State<LoginToogle2FAWidget> {
  var isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Column(
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
            Observer(builder: (_) {
              return Container();
            }),
          ],
        ),
        onWillPop: _onBackPressed);
  }

  Future<bool> _onBackPressed() async {
    widget.viewModel.flow = LoginFlow.initial;
    return false;
  }
}
