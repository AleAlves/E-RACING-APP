import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';

import '../login_view_model.dart';

class LoginInitialWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginInitialWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginInitialWidgetState createState() => _LoginInitialWidgetState();
}

class _LoginInitialWidgetState extends State<LoginInitialWidget> {
  @override
  Widget build(BuildContext context) {
    return ViewStateWidget(getContent(), widget.viewModel.state);
  }

  Widget getContent() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonWidget(
            ButtonType.normal,
                () {
              widget.viewModel.flow = LoginFlow.login;
            },
            label: "Já tenho uma conta",
          ),
          const BoundWidget(BoundType.huge),
          ButtonWidget(
            ButtonType.normal,
                () {
              widget.viewModel.flow = LoginFlow.signin;
            },
            label: "Criar uma conta",
          ),
        ],
      ),
    );
  }
}
