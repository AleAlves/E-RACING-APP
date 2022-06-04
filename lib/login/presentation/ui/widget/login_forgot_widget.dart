import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/login/domain/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

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
  final List<ReactionDisposer> _disposers = [];

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
      scrollable: false,
      content: content(),
      onBackPressed: onBackPressed,
      state: widget.viewModel.state,
    );
  }

  @override
  observers() {
    _disposers
        .add(reaction((_) => widget.viewModel.user, (UserModel? userModel) {
      _emailController.text = widget.viewModel.user?.profile?.email ?? "";
    }));
  }

  @override
  Widget content() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
              child: Column(
                children: [
                  const TextWidget(
                      text: "Recuperação de senha", style: Style.description),
                  const SpacingWidget(LayoutSize.size24),
                  InputTextWidget(
                      enabled: true,
                      label: "Email",
                      icon: Icons.mail,
                      controller: _emailController,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty == true ||
                            !value.contains("@")) {
                          return 'valid email needed';
                        }
                        return null;
                      }),
                  const SpacingWidget(LayoutSize.size48),
                  ButtonWidget(
                    enabled: true,
                    type: ButtonType.normal,
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                        widget.viewModel.forgot(_emailController.text);
                      }
                    },
                    label: "Recuperar",
                  ),
                  const SpacingWidget(LayoutSize.size48),
                  ButtonWidget(
                    enabled: true,
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
      ),
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.flow = LoginWidgetFlow.login;
    return false;
  }
}
