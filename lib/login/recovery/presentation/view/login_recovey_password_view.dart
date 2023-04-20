import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../legacy/domain/model/user_model.dart';
import '../login_recovery_password_view_model.dart';

class LoginRecoveryPasswordView extends StatefulWidget {
  final LoginRecoveryPasswordViewModel viewModel;

  const LoginRecoveryPasswordView(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginRecoveryPasswordViewState createState() =>
      _LoginRecoveryPasswordViewState();
}

class _LoginRecoveryPasswordViewState extends State<LoginRecoveryPasswordView>
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
      body: content(),
      bottom: buttonWidget(),
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
          const SpacingWidget(LayoutSize.size128),
          Form(
              child: Column(
                children: [
                  const TextWidget(
                      text: "Password recovery", style: Style.paragraph),
                  const SpacingWidget(LayoutSize.size48),
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
                  const SpacingWidget(LayoutSize.size16),
                  ButtonWidget(
                    enabled: true,
                    type: ButtonType.link,
                    onPressed: () {
                      // widget.viewModel.flow = LoginWidgetFlow.reset;
                    },
                    label: "Already have the code?",
                  ),
                  const SpacingWidget(LayoutSize.size48),
                  Row(
                    children: const [
                      TextWidget(
                          text: "Other problem?", style: Style.paragraph),
                    ],
                  ),
                  ButtonWidget(
                    enabled: true,
                    type: ButtonType.link,
                    onPressed: () {
                      // widget.viewModel.flow = LoginWidgetFlow.resetCode;
                    },
                    label: "Generate new validation code",
                  ),
                ],
              ),
              key: _formKey),
        ],
      ),
    );
  }

  Widget buttonWidget() {
    return ButtonWidget(
      enabled: true,
      type: ButtonType.primary,
      onPressed: () {
        if (_formKey.currentState?.validate() == true) {
          widget.viewModel.forgot(_emailController.text);
        }
      },
      label: "Recover",
    );
  }

  @override
  Future<bool> onBackPressed() async {
    Modular.to.pop();
    return false;
  }
}
