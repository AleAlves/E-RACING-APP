import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_from_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../login_view_model.dart';

class LoginForgotWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginForgotWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginForgotWidgetState createState() => _LoginForgotWidgetState();
}

class _LoginForgotWidgetState extends State<LoginForgotWidget>
    implements BaseSateWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void initState() {
    _emailController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) => mainObserver();

  @override
  Observer mainObserver() => Observer(builder: (_) => viewState());

  @override
  ViewStateWidget viewState() {
    return ViewStateWidget(
      content: content(),
      onBackPressed: onBackPressed,
      state: widget.viewModel.state,
    );
  }

  @override
  observers() {}

  @override
  Widget content() {
    return Observer(builder: (_) {
      _emailController.text = widget.viewModel.user?.profile?.email ?? "";
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
              child: Column(
                children: [
                  const TextWidget("Recuperação de senha", Style.description),
                  const BoundWidget(BoundType.big),
                  TextFormWidget("Email", Icons.mail, _emailController,
                      (value) {
                    if (value == null ||
                        value.isEmpty == true ||
                        !value.contains("@")) {
                      return 'valid email needed';
                    }
                    return null;
                  }),
                  const BoundWidget(BoundType.big),
                  ButtonWidget(
                    type: ButtonType.normal,
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                        widget.viewModel.forgot(_emailController.text);
                      }
                    },
                    label: "Recuperar",
                  ),
                  const BoundWidget(BoundType.big),
                  ButtonWidget(
                    type: ButtonType.borderless,
                    onPressed: () {
                      widget.viewModel.flow = LoginWidgetFlow.reset;
                    },
                    label: "Já tenho o código",
                  ),
                ],
              ),
              key: _formKey),
        ],
      );
    });
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.flow = LoginWidgetFlow.init;
    return false;
  }
}
