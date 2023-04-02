import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';

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
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
        scrollable: false,
        body: content(),
        state: widget.viewModel.state,
        onBackPressed: onBackPressed);
  }

  @override
  observers() {}

  @override
  Widget content() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/checkred-flag.json',
              width: MediaQuery.of(context).size.width / 5,
              height: MediaQuery.of(context).size.height / 5),
          ButtonWidget(
            enabled: true,
            type: ButtonType.primary,
            onPressed: () {
              widget.viewModel.flow = LoginWidgetFlow.login;
            },
            label: "Já tenho uma conta",
          ),
          const SpacingWidget(LayoutSize.size32),
          ButtonWidget(
            enabled: true,
            type: ButtonType.primary,
            onPressed: () {
              widget.viewModel.flow = LoginWidgetFlow.signin;
            },
            label: "Criar uma conta",
          ),
        ],
      ),
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.flow = LoginWidgetFlow.login;
    return false;
  }
}
