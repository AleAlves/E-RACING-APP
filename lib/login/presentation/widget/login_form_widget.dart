import 'package:e_racing_app/core/ui/component/ui/bound_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/button_widget.dart';
import 'package:e_racing_app/core/ui/component/ui/text_from_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:e_racing_app/login/presentation/ui/login_flow.dart';

import '../login_view_model.dart';

class LoginFormWidget extends StatefulWidget {
  final LoginViewModel viewModel;

  const LoginFormWidget(this.viewModel, {Key? key}) : super(key: key);

  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    _emailController.text = '';
    _passwordController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(child: loginForm(), key: _formKey),
            Observer(builder: (_) {
              _emailController.text =
                  widget.viewModel.user?.profile?.email ?? "";
              _passwordController.text =
                  widget.viewModel.user?.auth?.password ?? "";
              return Container();
            }),
          ],
        ),
        onWillPop: _onBackPressed);
  }

  Widget loginForm() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          TextFormWidget('Email', Icons.mail, _emailController, (value) {
            if (value == null ||
                value.isEmpty == true ||
                !value.contains("@")) {
              return 'valid email needed';
            }
            return null;
          }),
          const BoundWidget(BoundType.medium),
          TextFormWidget('Password', Icons.vpn_key, _passwordController,
              (value) {
            if (value == null || value.isEmpty == true) {
              return 'Password needed';
            }
            if (value.length < 8) {
              return 'Password too short';
            }
            return null;
          }),
          const BoundWidget(BoundType.medium),
          ButtonWidget(
            ButtonType.normal,
            () {
              if (_formKey.currentState?.validate() == true) {
                widget.viewModel
                    .login(_emailController.text, _passwordController.text);
              }
            },
            label: "Entrar",
          ),
          const BoundWidget(BoundType.big),
          ButtonWidget(
            ButtonType.borderless,
            () {
              widget.viewModel.flow = LoginFlow.resetCode;
            },
            label: "Esqueci a senha",
          ),
        ],
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    widget.viewModel.flow = LoginFlow.initial;
    return false;
  }
}
