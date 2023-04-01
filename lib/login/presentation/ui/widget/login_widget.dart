import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/input_text_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/spacing_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/login/domain/model/user_model.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:mobx/mobx.dart';

import '../../login_view_model.dart';

class LoginWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> implements BaseSateWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    _emailController.text = '';
    _passwordController.text = '';
    widget.viewModel.getPublicKey();
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
      _passwordController.text = widget.viewModel.user?.auth?.password ?? "";
    }));
  }

  @override
  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(child: loginForm(), key: _formKey),
      ],
    );
  }

  Widget loginForm() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Lottie.asset('assets/checkred-flag.json',
              width: MediaQuery.of(context).size.width / 3, repeat: false),
          const SpacingWidget(LayoutSize.size16),
          InputTextWidget(
              enabled: true,
              label: 'Email',
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
          InputTextWidget(
              enabled: true,
              label: 'Password',
              icon: Icons.vpn_key,
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty == true) {
                  return 'Password needed';
                }
                if (value.length < 8) {
                  return 'Password too short';
                }
                return null;
              },
              inputType: InputType.password),
          const SpacingWidget(LayoutSize.size16),
          ButtonWidget(
            enabled: true,
            type: ButtonType.link,
            onPressed: () {
              widget.viewModel.flow = LoginWidgetFlow.resetCode;
            },
            label: "Preciso de ajuda",
          ),
          const SpacingWidget(LayoutSize.size16),
          ButtonWidget(
            enabled: true,
            type: ButtonType.secondary,
            onPressed: () {
              if (_formKey.currentState?.validate() == true) {
                widget.viewModel
                    .login(_emailController.text, _passwordController.text);
              }
            },
            label: "Entrar",
          ),
          const SpacingWidget(LayoutSize.size48),
          const TextWidget(
            text: "Join us",
            style: Style.paragraph,
          ),
          const SpacingWidget(LayoutSize.size16),
          ButtonWidget(
            enabled: true,
            type: ButtonType.primary,
            onPressed: () {
              widget.viewModel.flow = LoginWidgetFlow.signin;
            },
            label: "Criar uma conta",
          )
        ],
      ),
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.flow = LoginWidgetFlow.enviroment;
    return false;
  }
}
