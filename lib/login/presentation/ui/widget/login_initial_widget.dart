import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';

import '../../login_view_model.dart';

class LoginInitialWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginInitialWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginInitialWidgetState createState() => _LoginInitialWidgetState();
}

class _LoginInitialWidgetState extends State<LoginInitialWidget>
    implements BaseSateWidget {
  @override
  Widget build(BuildContext context) {
    return ViewStateWidget(
        content: content(),
        state: widget.viewModel.state,
        onBackPressed: _onBackPressed);
  }

  Future<bool> _onBackPressed() async {
    widget.viewModel.flow = LoginWidgetFlow.init;
    return false;
  }

  @override
  Widget content() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonWidget(
            type: ButtonType.normal,
            onPressed: () {
              widget.viewModel.flow = LoginWidgetFlow.login;
            },
            label: "Já tenho uma conta",
          ),
          const BoundWidget(BoundType.huge),
          ButtonWidget(
            type: ButtonType.normal,
            onPressed: () {
              widget.viewModel.flow = LoginWidgetFlow.signin;
            },
            label: "Criar uma conta",
          ),
        ],
      ),
    );
  }
}
