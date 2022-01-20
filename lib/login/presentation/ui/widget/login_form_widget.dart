import 'package:e_racing_app/core/ui/component/state/view_state_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_from_widget.dart';
import 'package:e_racing_app/core/ui/view_state.dart';
import 'package:e_racing_app/login/domain/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';
import 'package:mobx/mobx.dart';

import '../../login_view_model.dart';

class LoginFormWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginFormWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget>
    implements BaseSateWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    _emailController.text = '';
    _passwordController.text = '';
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
  observers() {
    _disposers.add(reaction((_) => widget.viewModel.user, (UserModel? userModel) {
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
          InputTextWidget('Email', Icons.mail, _emailController, (value) {
            if (value == null ||
                value.isEmpty == true ||
                !value.contains("@")) {
              return 'valid email needed';
            }
            return null;
          }),
          const BoundWidget(BoundType.medium),
          InputTextWidget('Password', Icons.vpn_key, _passwordController,
              (value) {
            if (value == null || value.isEmpty == true) {
              return 'Password needed';
            }
            if (value.length < 8) {
              return 'Password too short';
            }
            return null;
          },  inputType: InputType.password),
          const BoundWidget(BoundType.xl),
          ButtonWidget(
            type: ButtonType.normal,
            onPressed: () {
              if (_formKey.currentState?.validate() == true) {
                widget.viewModel
                    .login(_emailController.text, _passwordController.text);
              }
            },
            label: "Entrar",
          ),
          const BoundWidget(BoundType.xl),
          ButtonWidget(
            type: ButtonType.borderless,
            onPressed: () {
              widget.viewModel.flow = LoginWidgetFlow.resetCode;
            },
            label: "Esqueci a senha",
          ),
        ],
      ),
    );
  }

  @override
  Future<bool> onBackPressed() async {
    widget.viewModel.flow = LoginWidgetFlow.init;
    return false;
  }
}
